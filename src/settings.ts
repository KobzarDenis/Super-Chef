const settings = {
  main: {
    name: "API Gateway",
    domain: process.env.DOMAIN,
    address: process.env.ADDRESS || "http://localhost:8080",
    namespace: `${process.env.environment || ""}_ziphub`,
    port: process.env.PORT ? +process.env.PORT : 8080,
    modulesPath: "./modules",
    modelsPath: "./models",
    authModule: "auth"
  },
  logger: {
    level: "verbose",
    logsFile: "logs/combined.log",
    errorsFile: "logs/errors.log"
  },
  database: {
    seederStorage: "sequelize",
    migrationStorage: "sequelize",
    logging: process.env.DATABASE_LOGGING,
    url: process.env.DATABASE_URL || "postgres://chef:test@localhost:5432/super_chef",
    dialect: "postgres",
  }
};

export default settings;
