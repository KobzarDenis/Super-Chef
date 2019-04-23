import { Logger } from "./Logger";
import * as fs from "fs-extra";
import * as path from "path";
import { Model, Sequelize } from "sequelize-typescript";

/**
 * Database - class to work with sequelize
 * All available connections will store to "connections" except default connection
 * You can create connection by "createConnection" function(when name not transferred the connection is default)
 * You can get any connection by "getConnection" or call this function without name and get default connection
 */
export class Database   {
  public sequelize: Sequelize;
  private connections: any = {};
  private models: any[] = [];
  private logger: Logger;

  private static instance: Database;

  private constructor(private dbSettings, private mainSettings) {
    this.logger = Logger.getInstance();
    this.createConnection();
  }

  public static getInstance(dbSettings?, mainSettings?): Database {
    if (dbSettings && mainSettings) {
      if (!Database.instance) {
        Database.instance = new Database(dbSettings, mainSettings);
      }
    } else {
      if (!Database.instance) {
        throw new Error(`Empty instance. Missing parameters!`);
      }
    }
    return Database.instance;
  }

  /**
   * Function to create new database connection
   * Create named connection and save to connections array,
   * if name is not specified - create default connection
   * @param name
   * @param connectOptions
   * @returns {Sequelize}
   */
  public createConnection(name?, connectOptions?): Sequelize {
    if (!name) {
      this.sequelize = new Sequelize(this.prepareParams(this.dbSettings));
      return this.sequelize;
    }

    this.connections[name] = new Sequelize(this.prepareParams(connectOptions));
    return this.connections[name];
  }

  /**
   * Function to find all models in transferred path and include to Sequlize instance
   * Can recursive search
   * Files should be in format: "example.model.ts"
   * @param {string} modelsPath
   * @returns {Promise<void>}
   */
  public injectModels(modelsPath?: string) {
    modelsPath = modelsPath || path.join(__dirname, this.mainSettings.modelsPath);
    this.recursiveInject(modelsPath);
    this.sequelize.addModels(this.models);
  }

  /**
   * Function to get connection by name,
   * if name not specified - return default connection
   * @param name
   * @returns {Sequelize}
   */
  public getConnection(name?: string): Sequelize {
    if (!name) {
      return this.sequelize;
    }
    if (!this.connections[name]) {
      throw new Error(`Connection "${name}" not found`);
    }
    return this.connections[name];
  }

  /**
   * Function to custom adding model to Sequelize
   * @param {string | Model} model - can be a Model class or path to one model
   */
  public addModel(model: string | typeof Model) {
    try {
      if (typeof model === "string") {
        const importedModel = require(model);
        const modelName = (Object.keys(importedModel))[0];
        this.models.push(importedModel[modelName]);
        this.logger.info(`Model registered: ${modelName}`);
      } else {
        this.models.push(model);
      }
    } catch (err) {
      this.logger.error(err);
      this.logger.error("Error in model: " + model);
    }
  }

  private prepareParams(connectOptions) {
    let params: any = {
      operatorsAliases: false,
      logging: this.logger.verbose.bind(this.logger)
    };
    if (connectOptions.url) {
      params.url = connectOptions.url;
      return params;
    }
    params = Object.assign(params, {
      name: connectOptions.database,
      dialect: connectOptions.dialect,
      host: connectOptions || process.env.DB_HOST,
      username: connectOptions.username,
      password: connectOptions.password,
    });
    return params;
  }

  private recursiveInject(modelsPath?: string) {
    if (!modelsPath) {
      return;
    }
    const files = fs.readdirSync(modelsPath);

    for (const file of files) {
      const fileStat = fs.statSync(path.join(modelsPath, file));
      if (fileStat.isDirectory()) {
        this.recursiveInject(path.join(modelsPath, file));
      }
      if ((path.extname(file) !== ".js" && path.extname(file) !== ".ts") || file.indexOf("model") === -1) {
        continue;
      }
      this.addModel(path.join(modelsPath, file));
    }
  }
}
