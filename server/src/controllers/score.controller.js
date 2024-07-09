import { response } from '../../config/response.js';
import { status } from '../../config/response.status.js';
import {
  saveNewScore,
  getRankings,
  getMaxScore,
  getAllScores,
} from '../services/score.service.js';

export const saveScoreController = async (req, res, next) => {
  try {
    const result = await saveNewScore(req.body);
    res.send(response(status.SUCCESS, result));
  } catch (error) {
    next(error);
  }
};

export const getRankingsController = async (req, res, next) => {
  try {
    const result = await getRankings(req.params.gameId);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
};

export const getMaxScoreController = async (req, res, next) => {
  try {
    const result = await getMaxScore(req.params.userId, req.params.gameId);
    res.status(200).json({ maxScore: result });
  } catch (err) {
    next(err);
  }
};

export const getScoresController = async (req, res, next) => {
  try {
    const result = await getAllScores();
    res.send(response(status.SUCCESS, result));
  } catch (error) {
    next(error);
  }
};
