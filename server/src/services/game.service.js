import Game from '../models/game.model.js';
import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';

export const getAllGames = async () => {
  try {
    const games = await Game.find({});
    return games;
  } catch (err) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
};
