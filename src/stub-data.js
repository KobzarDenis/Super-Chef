const factory = require("./factory");
const faker = require("faker");
const {menu} = require("./modules/menu");


async function stubData() {
    const COUNT_OF_CLIENTS = 10;
    const COUNT_OF_TABLES = 20;
    const COUNT_OF_INGREDIENTS = 100;

    const clients = await factory.createMany("Client", COUNT_OF_CLIENTS);
    const tables = await factory.createMany("Table", COUNT_OF_TABLES);
    const ingredients = await factory.createMany("Ingredient", COUNT_OF_INGREDIENTS);
    const food = [];

    //Fill Menu
    for (let i = 0; i < menu.length; i++) {
        const foodGroup = await factory.create("FoodGroup", {name: menu[i].group});
        for (let j = 0; j < menu[i].foods.length; j++) {
            const f = await factory.create("Food", {
                name: menu[i].foods[j].name,
                price: menu[i].foods[j].price,
                groupId: foodGroup.id
            });
            for (let ci = 0; ci < faker.random.number({min: 2, max: 15}); ci++) {
                const ingredientId = ingredients[faker.random.number({min: 0, max: COUNT_OF_INGREDIENTS})].id;
                const foodId = f.id;

                await factory.create("FoodIngredient", {ingredientId, foodId});
            }
            food.push(f);
        }
    }

    return clients;
}

module.exports = stubData;