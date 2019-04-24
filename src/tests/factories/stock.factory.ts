import { FactoryUtils } from "./utils";
import * as faker from "faker";
import factory from "./factory";
import { ProductOrderStatus } from "../../models/ProductOrderStatus.model";
import { ProductGroup } from "../../models/ProductGroup.model";
import { Product } from "../../models/Product.model";
import { ProductApplying } from "../../models/ProductApplying.model";
import { Caterer } from "../../models/Caterer.model";
import { StockOrder } from "../../models/StockOrder.model";
import { CatererProduct } from "../../models/CatererProduct.model";

factory.define("ProductOrderStatus", ProductOrderStatus, (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Created', 'In-Process', 'Delivered'])
  }, buildOptions);
});

factory.define("ProductGroup", ProductGroup, (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Fish', 'Meat', 'Fruit', 'Vegetable']),
    description: faker.lorem.text()
  }, buildOptions);
});

factory.define("Product", Product, (buildOptions) => {
  return factory.mapData({
    groupId: factory.assoc("ProductGroup", "id"),
    name: faker.random.arrayElement(['Fish', 'Meat', 'Fruit', 'Vegetable']),
    rest: faker.random.number({ min: 1.0, max: 9.0 }),
    code: `${faker.random.word().substr(0, 2).toUpperCase()}-${faker.random.number({ min: 1000000, max: 9999999 })}`,
    price: faker.random.number({ min: 2, max: 10 })
  }, buildOptions);
});

factory.define("ProductApplying", ProductApplying, (buildOptions) => {
  return factory.mapData({
    productId: factory.assoc("Product", "id"),
    count: faker.random.number({ min: 5, max: 20 })
  }, buildOptions);
});

factory.define("Caterer", Caterer, (buildOptions) => {
  return factory.mapData({
    accountId: factory.assoc("Account", "id"),
    status: faker.random.arrayElement(['active', 'inactive']),
    code: `${faker.random.word().substr(0, 2).toUpperCase()}-${faker.random.number({ min: 1000000, max: 9999999 })}`,
    name: faker.name.firstName(),
    site: faker.internet.url(),
    phoneNumber: FactoryUtils.getRandomPhoneNumber(),
    email: faker.internet.email(),
    address: faker.address.streetAddress(true),
    updatedAt: new Date(),
    deletedAt: null,
    createdAt: FactoryUtils.dateGenerator(),
  }, buildOptions);
});

factory.define("StockOrder", StockOrder, (buildOptions) => {
  return factory.mapData({
    productId: factory.assoc("Product", "id"),
    catererId: factory.assoc("Caterer", "id"),
    employeeId: factory.assoc("Employee", "id"),
    statusId: factory.assoc("ProductOrderStatus", "id"),
    invoiceNumber: faker.random.uuid(),
    count: faker.random.number({ min: 15, max: 100 }),
    amount: faker.random.number({ min: 15, max: 100 }),
    orderDate: FactoryUtils.dateGenerator(),
    supplyDate: FactoryUtils.dateGenerator()
  }, buildOptions);
});

factory.define("CatererProduct", CatererProduct, (buildOptions) => {
  return factory.mapData({
    productId: factory.assoc("Product", "id"),
    catererId: factory.assoc("Caterer", "id")
  }, buildOptions);
});
