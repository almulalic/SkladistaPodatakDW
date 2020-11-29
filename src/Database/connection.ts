var sql = require("mssql");
require("dotenv").config();

const dbConfig = {
  server: process.env.DB_URL,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
};

const poolPromise = new sql.ConnectionPool(dbConfig as any)
  .connect()
  .then((pool) => {
    console.log("Connected to MSSQL");
    return pool;
  })
  .catch((err) => console.log("Database Connection Failed! Bad Config: ", err));

export = {
  sql,
  poolPromise,
};
