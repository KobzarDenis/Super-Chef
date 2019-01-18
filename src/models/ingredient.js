const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Ingredient = new Sequelize(settings.db.url).define("ingredients", {
    name: Sequelize.STRING(100)
}, {timestamps: false});

module.exports = Ingredient;