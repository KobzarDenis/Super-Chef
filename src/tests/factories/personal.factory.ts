import * as faker from "faker";
import factory from "./factory";
import { EmployeeRole } from "../../models/EmployeeRole.model";
import { Employee } from "../../models/Employee.model";
import { FactoryUtils } from "./utils";


factory.define("EmployeeRole", EmployeeRole, async (buildOptions) => {
  return factory.mapData({
    name: faker.random.arrayElement(['Accountant', 'Waiter', 'Manager']),
    description: faker.lorem.text()
  }, buildOptions);
});

factory.define("Employee", Employee, (buildOptions) => {
  return factory.mapData({
    accountId: factory.assoc("Account", "id"),
    roleId: factory.assoc("EmployeeRole", "id"),
    sex: faker.random.arrayElement(['male', 'female']),
    salary: faker.random.number({ min: 1000, max: 5000 }),
    passportCode: faker.random.word().substr(0, 2).toUpperCase(),
    passportSeries: faker.random.number({ min: 10000, max: 99999 }).toString(),
    ein: faker.random.number({ min: 1000000, max: 9999999 }).toString(),
    phoneNumber: FactoryUtils.getRandomPhoneNumber(),
    email: faker.internet.email(),
    firstName: faker.name.firstName(),
    lastName: faker.name.lastName(),
    address: faker.address.streetAddress(true),
    offerDate: FactoryUtils.dateGenerator(),
    fireDate: FactoryUtils.dateGenerator()
  }, buildOptions);
});
