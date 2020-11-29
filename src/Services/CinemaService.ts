import conn from "../Database/connection";
import { classToPlain } from "class-transformer";

class CinemaService {
  public async GetAllCinemas() {
    await conn.poolPromise.then(async (pool) => {
      return classToPlain(await pool.query("SELECT * FROM racun")).recordset;
    });
  }

  public async GetCinema(id) {
    return `Evo ti jedan sa id ${id}`;
  }

  public async AddCinema(body) {
    return "Dodano";
  }

  public async UpdateCinema(body) {
    return "Modifikovano";
  }

  public async DeleteCinema(id) {
    return `Izbrisano ${id}`;
  }
}

export default new CinemaService();
