const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Table = new Sequelize(settings.db.url).define("tables", {
    seatCount: Sequelize.INTEGER,
    status: Sequelize.ENUM('free', 'reserved', 'busy')
}, {timestamps: false});

module.exports = Table;