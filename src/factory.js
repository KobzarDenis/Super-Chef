//<editor-fold desc="Imports">
const {factory, SequelizeAdapter} = require("factory-girl");
const faker = require("faker");
const Client = require("./models/client");
const ClientDiscount = require("./models/clientDiscount");
const ClientOrder = require("./models/clientOrder");
const Discount = require("./models/discount");
const DiscountGroup = require("./models/discountGroup");
const Employee = require("./models/employee");
const EmployeeRole = require("./models/employeeRole");
const FoodGroup = require("./models/foodGroup");
const FoodIngredient = require("./models/foodIngredient");
const Ingredient = require("./models/ingredient");
const Food = require("./models/food");
const Table = require("./models/table");
const Order = require("./models/order");
const OrderFood = require("./models/orderFood");

//</editor-fold>

//<editor-fold desc="Declarations">
const myFactory = new factory.FactoryGirl();
const adapter = new SequelizeAdapter();

myFactory.setAdapter(adapter);

myFactory.mapData = function mapData(original, input) {
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

function getRandomPhoneNumber() {
    let phonePnumber = "+380";

    for (let i = 0; i < 9; i++) {
        phonePnumber = `${phonePnumber}${faker.random.number(9)}`;
    }

    return phonePnumber;
}

//</editor-fold>

myFactory.define("Client", Client, async (buildOptions) => {
    return myFactory.mapData({
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        email: faker.internet.email().toLowerCase(),
        phoneNumber: getRandomPhoneNumber()
    }, {buildOptions});
});

myFactory.define("FoodGroup", FoodGroup, async (buildOptions) => {
    return myFactory.mapData({
        name: faker.name.firstName()
    }, {buildOptions});
});

myFactory.define("Food", Food, async (buildOptions) => {
    return myFactory.mapData({
        name: faker.name.firstName(),
        description: faker.address.streetAddress(true),
        price: faker.random.number({min: 1, max: 3}),
        groupId: myFactory.assoc("FoodGroup", "id"),
    }, {buildOptions});
});

myFactory.define("Table", Table, async (buildOptions) => {
    return myFactory.mapData({
        seatCount: faker.random.arrayElement([2,4,8,10]),
        status: faker.random.arrayElement(["free", "reserved", "busy"])
    }, {buildOptions});
});

myFactory.define("EmployeeRole", EmployeeRole, async (buildOptions) => {
    return myFactory.mapData({
        name: faker.name.firstName(),
        description: faker.address.streetAddress(true)
    }, {buildOptions});
});

myFactory.define("Employee", Employee, async (buildOptions) => {
    return myFactory.mapData({
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        email: faker.internet.email().toLowerCase(),
        phoneNumber: getRandomPhoneNumber(),
        ein: getRandomPhoneNumber().substring(1, 9),
        sex: faker.random.arrayElement(["male", "female"]),
        salary: faker.random.number({min: 1000, max: 5000}),
        passportCode: faker.random.arrayElement(["AO", "OX", "FO", "LO"]),
        passportSeries: getRandomPhoneNumber().substring(1, 10),
        address: faker.address.streetAddress(true),
        offerDate: Date.now(),
        fireDate: null,
        roleId: myFactory.assoc("EmployeeRole", "id")
    }, {buildOptions});
});

myFactory.define("Ingredient", Ingredient, async (buildOptions) => {
    return myFactory.mapData({
        name: faker.name.firstName()
    }, {buildOptions});
});

myFactory.define("FoodIngredient", FoodIngredient, async (buildOptions) => {
    return myFactory.mapData({
        foodId: myFactory.assoc("Food", "id"),
        ingredientId: myFactory.assoc("Ingredient", "id"),
        weight: faker.random.number({min: 0.1, max: 1})
    }, {buildOptions});
});

myFactory.define("DiscountGroup", DiscountGroup, async (buildOptions) => {
    return myFactory.mapData({
        name: faker.name.firstName()
    }, {buildOptions});
});

myFactory.define("Discount", Discount, async (buildOptions) => {
    return myFactory.mapData({
        count: faker.random.number({min: 2, max: 10}),
        code: getRandomPhoneNumber().substring(1, 11),
        accumulativeBonuses: 0,
        description: faker.address.streetAddress(true),
        startDate: Date.now(),
        endDate: Date.now(),
        groupId: myFactory.assoc("DiscountGroup", "id")
    }, {buildOptions});
});

myFactory.define("ClientDiscount", ClientDiscount, async (buildOptions) => {
    return myFactory.mapData({
        clientId: myFactory.assoc("Client", "id"),
        discountId: myFactory.assoc("Discount", "id")
    }, {buildOptions});
});

myFactory.define("Order", Order, async (buildOptions) => {
    return myFactory.mapData({
        clientId: myFactory.assoc("Client", "id"),
        discountId: myFactory.assoc("Discount", "id"),
        employeeId: myFactory.assoc("Employee", "id"),
        tableId: myFactory.assoc("Table", "id"),
        paymentType: faker.random.arrayElement(["cash", "card"]),
        startDate: Date.now(),
        endDate: Date.now(),
        totalPrice: faker.random.number({min: 2, max: 100}),
        priceWithDiscount: faker.random.number({min: 1, max: 99}),
        tips: faker.random.number({min: 0, max: 10})
    }, {buildOptions});
});

myFactory.define("OrderFood", OrderFood, async (buildOptions) => {
    return myFactory.mapData({
        orderId: myFactory.assoc("Order", "id"),
        foodId: myFactory.assoc("Food", "id"),
        count: faker.random.number({min: 1, max: 4}),
        price: faker.random.number({min: 1, max: 10})
    }, {buildOptions});
});

myFactory.define("ClientOrder", ClientOrder, async (buildOptions) => {
    return myFactory.mapData({
        orderId: myFactory.assoc("Order", "id"),
        clientId: myFactory.assoc("Client", "id")
    }, {buildOptions});
});

module.exports = myFactory;