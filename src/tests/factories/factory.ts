import { factory, SequelizeAdapter } from "factory-girl";

const anotherFactory = new factory.FactoryGirl();
const adapter = new SequelizeAdapter();

adapter.destroy = async function (Model) {
  return Promise.resolve(Model.destroy({ truncate: true, cascade: true, force: true })).then(() => Model);
};

anotherFactory.setAdapter(adapter);
export default anotherFactory;

anotherFactory.cleanUp = async function () {
  const createdArray: any[] = [];
  const sequelizeUsedModels = {};
  for (const c of this.created) {
    if (c[0] instanceof SequelizeAdapter) {
      if (!sequelizeUsedModels[c[1].constructor.name]) {
        sequelizeUsedModels[c[1].constructor.name] = c[1].constructor;
      }
    } else {
      createdArray.push(c);
    }
  }
  const promise = createdArray.reduce(
    (prev, [adapter, model]) =>
      prev.then(() => (<any> adapter).destroy(model, (<any> model).constructor)),
    Promise.resolve()
  );
  const truncatePromises = [];
  for (const key in sequelizeUsedModels) {
    await this.defaultAdapter.destroy(sequelizeUsedModels[key]);
  }
  return truncatePromises;
  this.created.clear();
  this.resetSeq();
  return promise;
};

anotherFactory.mapData = function mapData(original, input) {
  const data = Object.assign({}, original);

  Object.keys(input).forEach((key) => {
    if (data.hasOwnProperty(key)) {
      if (input[key] !== undefined) {
        data[key] = input[key];
      }
    }
  });
  return data;
};

anotherFactory.addCustomModel = function (model) {
  anotherFactory.addToCreatedList(adapter, model);
};
