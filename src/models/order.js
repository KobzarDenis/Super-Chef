const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Order = new Sequelize(settings.db.url).define("orders", {
    employeeId: Sequelize.INTEGER,
    tableId: Sequelize.INTEGER,
    discountId: Sequelize.INTEGER,
    totalPrice: Sequelize.FLOAT,
    priceWithDiscount: Sequelize.FLOAT,
    tips: Sequelize.FLOAT,
    startDate: Sequelize.DATE,
    endDate: Sequelize.DATE,
    paymentType: Sequelize.ENUM("cash", "card")
}, {timestamps: false});

module.exports = Order;