const {Sequelize} = require("sequelize");
const settings = require("../settings");

const DiscountGroup = new Sequelize(settings.db.url).define("discountGroups", {
    name: Sequelize.STRING(50)
}, {timestamps: false});

module.exports = DiscountGroup;