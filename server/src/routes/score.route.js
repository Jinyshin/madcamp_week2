import express from 'express';
import {
  saveScoreController,
  getScoresController,
  getRankingsController,
  getMaxScoreController,
} from '../controllers/score.controller.js';

export const scoreRouter = express.Router();

scoreRouter.post('/', saveScoreController);
scoreRouter.get('/list', getScoresController);
scoreRouter.get('/rank/:gameId', getRankingsController);
scoreRouter.get('/max-score/:userId/:gameId', getMaxScoreController);
