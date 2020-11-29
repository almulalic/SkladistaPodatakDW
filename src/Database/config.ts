require("dotenv").config();

const dbConfig = {
  server: process.env.DB_URL,
  port: process.env.DB_PORT,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
};

export default dbConfig;
