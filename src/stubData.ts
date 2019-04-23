import { Database } from "./Database";
import { Logger } from "./Logger";
import * as menu from "./modules/menu";
import factory, { FactoryUtils } from "./tests/factories/index";
import * as faker from "faker";
import * as _ from "lodash";
import settings from "./settings";

const countOptions = {
  users: {
    employees: 10,
    clients: 100000
  },
  discounts: {
    groups: ['Daily', 'Accumulative']
  },
  companies: 70,
  dealsPerCompany: 40,
  maxlocationsPerCompany: 12,
  keywords: 20,
  initialLocation: {
    lat: 50.435670,
    lng: 30.500431,
    radius: 10000
  },
  npoDonationStatistics: {
    years: 2,
    months: 5,
    consumers: 10,
    npos: 10,
  }
};

Logger.getInstance(settings.logger);
Database.getInstance(settings.database, settings.main);
Database.getInstance().injectModels();

async function generateClients(repeat) {
  const groupIdArr = [];

  for (let groupName of countOptions.discounts.groups) {
    const group = await factory.create('DiscountGroup', { name: groupName });
    groupIdArr.push(group.id);
  }

  for (let i = 0; i < repeat; i++) {
    const discount = await factory.create("Discount", { groupId: faker.random.arrayElement(groupIdArr) });
    const client = await factory.create("Client");
    await factory.create("ClientDiscount", { clientId: client.id, discountId: discount.id });
  }

}

async function generateMenu() {

}

async function generateEmployees(roleId, repeat) {
  for (let i = 0; i < repeat; i++) {
    const account = await factory.create("Account", { bankId: faker.random.number({ min: 9, max: 12 }) });
    await factory.create("Employee", { roleId, accountId: account.id, fireDate: null });
  }

}

(async function () {
  await generateClients(10000);
  await generateEmployees(8, 5);
  await generateEmployees(7, 2);
  await generateEmployees(9, 3);
  console.log("All Done!");
  process.exit(0);
})();
