import { response } from '../../config/response.js';
import { status } from '../../config/response.status.js';
import { getAllGames } from '../services/game.service.js';

export const getAllGamesController = async (req, res, next) => {
  try {
    const results = await getAllGames();
    res.send(response(status.SUCCESS, results));
  } catch (error) {
    next(error);
  }
};
