import { response } from '../../config/response.js';
import { status } from '../../config/response.status.js';
import { joinUser, getProfile } from '../services/user.service.js';

export const userJoinController = async (req, res, next) => {
  try {
    const result = await joinUser(req.body);
    res.send(response(status.SUCCESS, result));
  } catch (error) {
    next(error); // 에러를 다음 미들웨어로 전달하여 처리
  }
};

export const getProfileController = async (req, res, next) => {
  try {
    const result = await getProfile(req.params.userId);
    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
};
