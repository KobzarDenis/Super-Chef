import { Database } from "./Database";
import { Logger } from "./Logger";
import options from "./modules/options";
import factory, { FactoryUtils } from "./tests/factories/index";
import * as faker from "faker";
import settings from "./settings";
import { Food } from "./models/Food.model";
import { DiscountGroup } from "./models/DiscountGroup.model";
import { Employee } from "./models/Employee.model";

Logger.getInstance(settings.logger);
Database.getInstance(settings.database, settings.main);
Database.getInstance().injectModels();

enum TransactionStatus {
  Created = 'Created',
  Canceled = 'Canceled',
  InProcess = 'In-Process',
  Success = 'Success'
}

enum ProductOrderStatus {
  Created = 'Created',
  InProcess = 'In-Process',
  Delivered = 'Delivered'
}

enum TransactionTypes {
  Salary = 'Salary',
  OrderFood = 'Order-Food',
  Earnings = 'Earnings'
}

enum EmployeeRole {
  Manager = 'Manager',
  Waiter = 'Waiter',
  Accountant = 'Accountant'
}

const MENU_PRODUCTS_ID: number[] = [];
const STOCK_PRODUCTS = [];
const CLIENTS: any[] = [];
const TABLES_ID: number[] = [];
const BANKS_ID: number[] = [];
const EMPLOYEE = {};
const TRANSACTION_STATUSES = {};
const PRODUCT_ORDER_STATUSES = {};
const TRANSACTION_TYPES = {};

async function generateClients(repeat) {
  const groupIdArr = [];

  for (let groupName of options.countOptions.discounts.groups) {
    const group: DiscountGroup = <DiscountGroup> await factory.create('DiscountGroup', { name: groupName });
    groupIdArr.push(group.id);
  }

  for (let i = 0; i < repeat; i++) {
    const discount = await factory.create("Discount", {
      groupId: faker.random.arrayElement(groupIdArr),
      startDate: FactoryUtils.dateGenerator({ year: 2016 })
    });
    const client = await factory.create("Client");
    await factory.create("ClientDiscount", { clientId: client.id, discountId: discount.id });
    CLIENTS.push({ clientId: client.id, discountId: discount.id, discountCode: discount.code });
  }
}

async function generateTables(repeat) {
  for (let i = 0; i < repeat; i++) {
    const table = await factory.create("SeatTable");
    TABLES_ID.push(table.id);
  }
}

async function generateBanks() {
  for (let bank of options.banks) {
    const b = await factory.create("Bank", {
      name: bank.name,
      bic: bank.bic,
      bin: bank.bin,
      transitAccount: bank.transitAccount
    });
    BANKS_ID.push(b.id);
  }
}

async function generateStatusesAndTypes() {
  for (let status of options.transactionStatuses) {
    const s = await factory.create("TransactionStatus", { name: status.name, description: status.desc });
    TRANSACTION_STATUSES[status.name] = s.id;
  }
  for (let status of options.productOrderStatuses) {
    const s = await factory.create("ProductOrderStatus", { name: status.name });
    PRODUCT_ORDER_STATUSES[status.name] = s.id;
  }
  for (let ttype of options.transactionTypes) {
    const t = await factory.create("TransactionType", { name: ttype.name, description: ttype.desc });
    TRANSACTION_TYPES[ttype.name] = t.id;
  }
}

async function generateServiceOrders() {
  const waiters = EMPLOYEE[EmployeeRole.Waiter].map(e => e.eId);
  for (let i = 0; i < CLIENTS.length; i++) {
    for (let j = 0; j < faker.random.number({ min: 20, max: 500 }); j++) {
      const month = faker.random.number({ min: 0, max: 11 });
      const hour = faker.random.number({ min: 10, max: 20 });
      const year = faker.random.arrayElement([2016, 2017, 2018]);
      const startDate = FactoryUtils.dateGenerator({ year, month, hour });
      const endDate = FactoryUtils.dateGenerator({ year, month, hour: hour + 1 });
      const order = await factory.create("ServiceOrder", {
        startDate,
        endDate,
        clientId: CLIENTS[i].clientId,
        discountId: CLIENTS[i].discountId,
        employeeId: faker.random.arrayElement(waiters),
        tableId: faker.random.arrayElement(TABLES_ID),
        status: 'closed'
      });
      for (let inc = 0; inc < faker.random.number({ min: 2, max: 5 }); inc++) {
        await factory.create("OrderFood", {
          orderId: order.id,
          productId: faker.random.arrayElement(MENU_PRODUCTS_ID)
        });
      }
      const date = `${year}-${endDate.getMonth() + 1}-${FactoryUtils.dateGenerator.dayNumber} ${hour}:26:56.691 +00:00`;
      await Database.getInstance().sequelize.query(`call service.order_pay(${order.id}, '${CLIENTS[i].discountCode}', ${TRANSACTION_TYPES[TransactionTypes.Earnings]}, '${date}')`);
    }
  }
}

async function generateMenu() {
  const COUNT_OF_INGREDIENT = 40;
  const ingredients = (await factory.createMany("Ingredient", COUNT_OF_INGREDIENT)).map((ig) => ig.id);
  for (let group of options.menu) {
    const fg = await factory.create("FoodGroup", { name: group.group });
    for (let i = 0; i < group.foods.length; i++) {
      const f = await factory.create("Food", {
        name: group.foods[i].name,
        price: group.foods[i].price,
        groupId: fg.id
      });
      MENU_PRODUCTS_ID.push(f.id);
      for (let j = 0; j < faker.random.number({ min: 3, max: 10 }); j++) {
        try {
          await factory.create("FoodIngredient", {
            foodId: f.id,
            ingredientId: faker.random.arrayElement(ingredients)
          });
        } catch (e) {
          continue;
        }
      }
    }
  }

  for (let productGroup of options.stock) {
    const pg = await factory.create("ProductGroup", { name: productGroup.group });
    for (let product of productGroup.products) {
      const p = await factory.create("Product", {
        groupId: pg.id,
        name: product.name,
        code: product.code,
        price: product.price
      });
      STOCK_PRODUCTS.push(p.id);
    }
  }
}

async function generateEmployees() {
  for (let role of options.employeeRoles) {
    const r = await factory.create("EmployeeRole", { name: role.name, description: role.desc });
    EMPLOYEE[role.name] = [];
    for (let i = 0; i < role.count; i++) {
      const offerDate = FactoryUtils.dateGenerator({ year: 2016, month: 1 });
      const account = await factory.create("Account", {
        bankId: faker.random.arrayElement(BANKS_ID),
        createdAt: offerDate,
        updatedAt: offerDate
      });
      const e = await factory.create("Employee", {
        roleId: r.id,
        accountId: account.id,
        offerDate,
        fireDate: null
      });
      EMPLOYEE[role.name].push({ eId: e.id, aId: account.id, salary: e.salary });
    }
  }

  const accountants = EMPLOYEE[EmployeeRole.Accountant].map(e => e.eId);

  for (let role of Object.keys(EMPLOYEE)) {
    for (let employee of EMPLOYEE[role]) {
      //Salary for 2016
      for (let i = 1; i < 12; i++) {
        const date = FactoryUtils.dateGenerator({ year: 2016, month: i });
        const employeeId = faker.random.arrayElement(accountants);
        await generateTransactionOutcome(date, employee.aId, employeeId, TRANSACTION_TYPES[TransactionTypes.Salary], TRANSACTION_STATUSES[TransactionStatus.Success], employee.salary, `Salary for employee ${employee.eId}`)
      }

      //Salary for 2017
      for (let i = 1; i < 12; i++) {
        const date = FactoryUtils.dateGenerator({ year: 2017, month: i });
        const employeeId = faker.random.arrayElement(accountants);
        await generateTransactionOutcome(date, employee.aId, employeeId, TRANSACTION_TYPES[TransactionTypes.Salary], TRANSACTION_STATUSES[TransactionStatus.Success], employee.salary, `Salary for employee ${employee.eId}`)
      }

      //Salary for 2018
      for (let i = 1; i < 12; i++) {
        const date = FactoryUtils.dateGenerator({ year: 2018, month: i });
        const employeeId = faker.random.arrayElement(accountants);
        await generateTransactionOutcome(date, employee.aId, employeeId, TRANSACTION_TYPES[TransactionTypes.Salary], TRANSACTION_STATUSES[TransactionStatus.Success], employee.salary, `Salary for employee ${employee.eId}`)
        await generateTransactionOutcome(date, employee.aId, employeeId, TRANSACTION_TYPES[TransactionTypes.Salary], TRANSACTION_STATUSES[TransactionStatus.Canceled], employee.salary, `Salary for employee ${employee.eId}`)
      }
    }
  }

}

async function generateTransactionOutcome(timestamp, accountId, employeeId, outcomeType, status, amount, description) {
  await factory.create('Outcome', { timestamp, accountId, employeeId, outcomeType, status, amount, description });
}

(async function () {
  try {
    await generateStatusesAndTypes();
    await generateBanks();
    await generateEmployees();
    await generateMenu();
    await generateTables(50);
    await generateClients(10000);
    await generateServiceOrders();
    console.log("All Done!");
  } catch (e) {
    console.log(e);
    await factory.cleanUp();
    process.exit(0);
  }
})();
