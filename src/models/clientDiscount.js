const {Sequelize} = require("sequelize");
const settings = require("../settings");

const ClientDiscount = new Sequelize(settings.db.url).define("clientDiscounts", {
    clientId: Sequelize.INTEGER,
    discountId: Sequelize.INTEGER
}, {timestamps: false});

module.exports = ClientDiscount;