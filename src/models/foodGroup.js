const {Sequelize} = require("sequelize");
const settings = require("../settings");

const FoodGroup = new Sequelize(settings.db.url).define("foodGroups", {
    name: Sequelize.STRING(100)
}, {timestamps: false});

module.exports = FoodGroup;