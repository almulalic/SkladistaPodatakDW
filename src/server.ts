import cors from "cors";
import express from "express";
import bodyParser from "body-parser";

import { CinemaController } from "./Controllers";

const app = express();
require("dotenv").config();
let port = process.env.PORT || 5000;

app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
// app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.use("/cinema", CinemaController);

app.listen(port, () => {
  console.info("Server is running on port: " + port);
});

export default app;
