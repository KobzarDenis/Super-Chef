const {Sequelize} = require("sequelize");
const settings = require("../settings");
const FoodGroup = require("./foodGroup");

const Food = new Sequelize(settings.db.url).define("foods", {
    name: Sequelize.STRING(100),
    description: Sequelize.TEXT,
    price: Sequelize.FLOAT,
    groupId: Sequelize.INTEGER,
}, {timestamps: false});

// Food.belongsTo(FoodGroup, {as: "groupId"});

module.exports = Food;