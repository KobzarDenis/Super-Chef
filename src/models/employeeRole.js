const {Sequelize} = require("sequelize");
const settings = require("../settings");

const EmployeeRole = new Sequelize(settings.db.url).define("employeeRoles", {
    name: Sequelize.STRING(50),
    description: Sequelize.TEXT
}, {timestamps: false});

module.exports = EmployeeRole;