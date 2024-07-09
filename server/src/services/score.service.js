import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';
import {
  saveScore,
  findAllScores,
  findScoresByGameId,
  findMaxScoreByUserIdAndGameId,
} from '../repository/score.dao.js';

export const saveNewScore = async (body) => {
  const scoreData = await saveScore({
    userId: body.userId,
    gameId: body.gameId,
    score: body.score,
  });

  if (scoreData == -1) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
  return scoreData;
};

export const getRankings = async (gameId) => {
  try {
    const scores = await findScoresByGameId(gameId);
    return scores;
  } catch (error) {
    throw new BaseError(status.PARAMETER_IS_WRONG, error.message);
  }
};

export const getMaxScore = async (userId, gameId) => {
  try {
    const maxScore = await findMaxScoreByUserIdAndGameId(userId, gameId);
    return maxScore ? maxScore.score : 0;
  } catch (error) {
    throw new BaseError(status.PARAMETER_IS_WRONG, error.message);
  }
};

export const getAllScores = async () => {
  const scores = await findAllScores();

  if (scores == -1) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
  return scores;
};
