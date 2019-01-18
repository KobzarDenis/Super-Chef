const {Sequelize} = require("sequelize");
const settings = require("../settings");

const ClientOrder = new Sequelize(settings.db.url).define("clientOrders", {
    clientId: Sequelize.INTEGER,
    orderId: Sequelize.INTEGER
}, {timestamps: false});

module.exports = ClientOrder;