class CinemaService {
  public async GetAllCinemas() {
    return "Evo ti svi";
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
