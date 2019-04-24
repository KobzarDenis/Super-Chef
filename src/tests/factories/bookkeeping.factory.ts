import { FactoryUtils } from "./utils";
import * as faker from "faker";
import factory from "./factory";
import { Bank } from "../../models/Bank.model";
import { Account } from "../../models/Account.model";
import { TransactionStatus } from "../../models/TransactionStatus.model";
import { TransactionType } from "../../models/TransactionType.model";
import { Income } from "../../models/Income.model";
import { Outcome } from "../../models/Outcome.model";


factory.define("Bank", Bank, async (buildOptions) => {
  return factory.mapData({
    name: FactoryUtils.getBank(faker.random.number({ min: 1, max: 4 })),
    transitAccount: FactoryUtils.getBank.current.transitAccount,
    bic: FactoryUtils.getBank.current.bic,
    bin: FactoryUtils.getBank.current.bin
  }, buildOptions);
});

factory.define("Account", Account, (buildOptions) => {
  return factory.mapData({
    bankId: factory.assoc("Bank", "id"),
    number: `tt-${faker.random.uuid()}`,
    isActive: true,
    createdAt: FactoryUtils.dateGenerator(),
    updatedAt: new Date()
  }, buildOptions);
});

factory.define("TransactionStatus", TransactionStatus, (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Created', 'Canceled', 'In-Process', 'Success']),
    description: faker.lorem.text()
  }, buildOptions);
});

factory.define("TransactionType", TransactionType, (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Salary', 'Order-Food', 'Earnings']),
    description: faker.lorem.text()
  }, buildOptions);
});

factory.define("Income", Income, (buildOptions) => {
  return factory.mapData({
    incomeType: factory.assoc("TransactionType", "id"),
    amount: faker.random.number({ min: 1000, max: 5000 }),
    timestamp: FactoryUtils.dateGenerator()
  }, buildOptions);
});

factory.define("Outcome", Outcome, (buildOptions) => {
  return factory.mapData({
    outcomeType: factory.assoc("TransactionType", "id"),
    status: factory.assoc("TransactionStatus", "id"),
    accountId: factory.assoc("Account", "id"),
    employeeId: factory.assoc("Employee", "id"),
    amount: faker.random.number({ min: 1000, max: 50000 }),
    timestamp: FactoryUtils.dateGenerator()
  }, buildOptions);
});
