const {Sequelize} = require("sequelize");
const settings = require("../settings");

const OrderFood = new Sequelize(settings.db.url).define("orderFoods", {
    orderId: Sequelize.INTEGER,
    foodId: Sequelize.INTEGER,
    count: Sequelize.INTEGER,
    price: Sequelize.FLOAT
}, {timestamps: false});

module.exports = OrderFood;