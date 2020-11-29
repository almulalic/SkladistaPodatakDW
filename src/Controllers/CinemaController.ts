import express from "express";
import { CinemaService } from "../Services";

const CinemaController = express.Router();

CinemaController.get("/all", async (req, res) => {
  console.log(await CinemaService.GetAllCinemas());
  res.json(await CinemaService.GetAllCinemas());
});

CinemaController.get("/", async (req, res) => {
  res.json(await CinemaService.GetCinema(req.query.cinemaId));
});

CinemaController.post("/", async (req, res) => {
  res.json(await CinemaService.AddCinema(req.body));
});

CinemaController.put("/", async (req, res) => {
  res.json(await CinemaService.UpdateCinema(req.body));
});

CinemaController.delete("/", async (req, res) => {
  res.json(await CinemaService.DeleteCinema(req.query.cinemaId));
});

export default CinemaController;
