import Score from '../models/score.model.js';

export const saveScore = async (data) => {
  try {
    const newScore = new Score(data);
    const result = await newScore.save();
    return result;
  } catch (error) {
    console.error('Error adding score:', error.message);
    return -1;
  }
};

// 특정 사용자의 게임 점수들 조회
export const findScoresByUserId = async (userId) => {
  try {
    return await Score.find({ userId });
  } catch (error) {
    console.error('Error finding scores:', error.message);
    return -1;
  }
};

// 특정 게임의 점수들 조회
export const findScoresByGameId = async (gameId) => {
  try {
    return await Score.find({ gameId })
      .sort({ score: -1 })
      .limit(10)
      .populate('userId');
  } catch (error) {
    console.error('Error finding scores:', error.message);
    return -1;
  }
};

// 나의 특정 게임의 최고 점수 조회
export const findMaxScoreByUserIdAndGameId = async (userId, gameId) => {
  try {
    return await Score.findOne({ userId, gameId }).sort({ score: -1 });
  } catch (error) {
    console.error('Error finding max score:', error.message);
    return -1;
  }
};

export const findAllScores = async () => {
  try {
    const scores = await Score.find({});
    return scores;
  } catch (error) {
    console.error('Error retrieving scores:', error.message);
    return -1;
  }
};
