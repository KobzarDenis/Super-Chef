import { Model } from "sequelize";

const excludeTables = ["foods", "foodGroups"];

export async function cleanDB(sequelize) {
  if (process.env.DISABLE_CLEAR && process.env.DISABLE_CLEAR === "true") {
    return;
  }

  const models: any[] = [];
  (<any> sequelize).modelManager.forEachModel((model: Model<any, any>) => {
    if (excludeTables.indexOf(<string> model.getTableName()) !== -1) {
      return;
    }
    models.push(model);
  });
  for (const model of models) {
    await model.destroy({where: {}});
  }
}
