const settings = {
    db: {
        logging: true,
        url: process.env.DATABASE_URL || "postgres://chef:admin@localhost:5432/super_chef",
        dialect: "postgres"
    }
};

module.exports = settings;