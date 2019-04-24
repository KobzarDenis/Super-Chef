import * as faker from "faker";
import factory from "./factory";
import { FactoryUtils } from "./utils";
import { Discount } from "../../models/Discount.model";
import { DiscountGroup } from "../../models/DiscountGroup.model";
import { Client } from "../../models/Client.model";
import { ClientDiscount } from "../../models/ClientDiscount.model";
import { FoodGroup } from "../../models/FoodGroup.model";
import { Food } from "../../models/Food.model";
import { OrderFood } from "../../models/OrderFood.model";
import { Ingredient } from "../../models/Ingredient.model";
import { FoodIngredient } from "../../models/FoodIngredient.model";
import { SeatTable } from "../../models/Table.model";
import { ServiceOrder } from "../../models/ServiceOrder.model";

factory.define("DiscountGroup", DiscountGroup, async (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Daily', 'Accumulative']),
  }, buildOptions);
});

factory.define("Discount", Discount, (buildOptions) => {
  return factory.mapData({
    groupId: factory.assoc("DiscountGroup", "id"),
    code: `${faker.random.word().substr(0, 2).toUpperCase()}-${faker.random.number({ min: 1000000, max: 9999999 })}`,
    accumulativeBonuses: faker.random.number({ min: 0.01, max: 200 }).toString(),
    count: faker.random.arrayElement([15, 30, 50]),
    startDate: FactoryUtils.dateGenerator(),
    endDate: new Date()
  }, buildOptions);
});

factory.define("Client", Client, (buildOptions) => {
  return factory.mapData({
    phoneNumber: FactoryUtils.getRandomPhoneNumber(),
    email: faker.internet.email(),
    firstName: faker.name.firstName(),
    lastName: faker.name.lastName()
  }, buildOptions);
});

factory.define("ClientDiscount", ClientDiscount, (buildOptions) => {
  return factory.mapData({
    discountId: factory.assoc("Discount", "id"),
    clientId: factory.assoc("Client", "id")
  }, buildOptions);
});

factory.define("FoodGroup", FoodGroup, (buildOptions) => {
  return factory.mapData({
    name: faker.name.firstName()
  }, buildOptions);
});

factory.define("Food", Food, (buildOptions) => {
  return factory.mapData({
    groupId: factory.assoc("FoodGroup", "id"),
    name: faker.name.firstName(),
    description: faker.lorem.text(),
    price: faker.random.number({ min: 3, max: 140 })
  }, buildOptions);
});

factory.define("Ingredient", Ingredient, (buildOptions) => {
  return factory.mapData({
    name: faker.name.firstName()
  }, buildOptions);
});

factory.define("OrderFood", OrderFood, (buildOptions) => {
  return factory.mapData({
    orderId: factory.assoc("Order", "id"),
    foodId: factory.assoc("Food", "id"),
    count: faker.random.number({ min: 1, max: 4 }),
    price: faker.random.number({ min: 3, max: 140 })
  }, buildOptions);
});

factory.define("FoodIngredient", FoodIngredient, (buildOptions) => {
  return factory.mapData({
    ingredientId: factory.assoc("Ingredient", "id"),
    foodId: factory.assoc("Food", "id"),
    weight: faker.random.number({ min: 1.1, max: 9.9 })
  }, buildOptions);
});

factory.define("SeatTable", SeatTable, (buildOptions) => {
  return factory.mapData({
    status: faker.random.arrayElement(['free', 'reserved', 'busy']),
    seatCount: faker.random.number({ min: 2, max: 10 })
  }, buildOptions);
});

factory.define("ServiceOrder", ServiceOrder, (buildOptions) => {
  return factory.mapData({
    clientId: factory.assoc("Client", "id"),
    employeeId: factory.assoc("Employee", "id"),
    tableId: factory.assoc("SeatTable", "id"),
    discountId: factory.assoc("Discount", "id"),
    startDate: FactoryUtils.dateGenerator(),
    endDate: FactoryUtils.dateGenerator(),
    totalPrice: faker.random.number({ min: 15, max: 100 }),
    priceWithDiscount: faker.random.number({ min: 15, max: 100 }),
    tips: faker.random.number({ min: 15, max: 100 }),
    paymentType: faker.random.arrayElement(['cash', 'card']),
    status: faker.random.arrayElement(['opened', 'closed'])
  }, buildOptions);
});

