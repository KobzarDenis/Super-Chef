const {Sequelize} = require("sequelize");
const settings = require("../settings");

const FoodIngredient = new Sequelize(settings.db.url).define("foodIngredients", {
    foodId: Sequelize.INTEGER,
    ingredientId: Sequelize.INTEGER,
    weight: Sequelize.FLOAT
}, {timestamps: false});

module.exports = FoodIngredient;