const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Client = new Sequelize(settings.db.url).define("clients", {
    firstName: Sequelize.STRING(100),
    lastName: Sequelize.STRING(100),
    email: Sequelize.STRING(50),
    phoneNumber: Sequelize.STRING(20)
}, {timestamps: false});

module.exports = Client;