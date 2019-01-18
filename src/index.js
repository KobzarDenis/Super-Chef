const settings = require("./settings");
const stubData = require("./stub-data");
const {Sequelize} = require("sequelize");
const utils = require("util");

const sequelize = new Sequelize(settings.db.url);

sequelize
    .authenticate()
    .then((data) => {
        stubData().then((clients) => {
            console.log(clients);
        });
    })
    .catch(err => {
        console.error('Unable to connect to the database:', err);
    });