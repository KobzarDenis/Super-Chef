const {Sequelize} = require("sequelize");
const settings = require("../settings");

const Employee = new Sequelize(settings.db.url).define("employees", {
    firstName: Sequelize.STRING(100),
    lastName: Sequelize.STRING(100),
    email: Sequelize.STRING(50),
    phoneNumber: Sequelize.STRING(20),
    ein: Sequelize.STRING(20),
    sex: Sequelize.ENUM("male", "female"),
    salary: Sequelize.FLOAT,
    passportCode: Sequelize.STRING(5),
    passportSeries: Sequelize.STRING(10),
    address: Sequelize.STRING(100),
    offerDate: Sequelize.DATE,
    fireDate: Sequelize.DATE,
    roleId: Sequelize.INTEGER
}, {timestamps: false});

module.exports = Employee;