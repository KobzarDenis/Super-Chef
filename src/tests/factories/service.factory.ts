import * as faker from "faker";
import factory from "./factory";
import { FactoryUtils } from "./utils";
import { Discount } from "../../models/Discount.model";
import { DiscountGroup } from "../../models/DiscountGroup.model";
import { Client } from "../../models/Client.model";
import { ClientDiscount } from "../../models/ClientDiscount.model";

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
    startDate: new Date(),
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
