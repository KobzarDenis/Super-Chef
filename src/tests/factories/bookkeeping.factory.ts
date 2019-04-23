import { FactoryUtils } from "./utils";
import * as faker from "faker";
import factory from "./factory";
import { Bank } from "../../models/Bank.model";
import { Account } from "../../models/Account.model";


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
    createdAt: new Date(),
    updatedAt: new Date()
  }, buildOptions);
});
