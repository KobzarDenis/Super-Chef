const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Discount = new Sequelize(settings.db.url).define("discounts", {
    count: Sequelize.FLOAT,
    code: Sequelize.STRING(10),
    accumulativeBonuses: Sequelize.FLOAT,
    description: Sequelize.TEXT,
    startDate: Sequelize.DATE,
    endDate: Sequelize.DATE,
    groupId: Sequelize.INTEGER
}, {timestamps: false});

module.exports = Discount;