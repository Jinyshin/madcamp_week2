import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';
import { signinResponseDTO } from '../dtos/user.dto.js';
import { saveUser, findUserById } from '../repository/user.dao.js';
import { findScoresByUserId } from '../repository/score.dao.js';

export const joinUser = async (body) => {
  const joinUserData = await saveUser({
    displayName: body.displayName,
    email: body.email,
    id: body.id,
    photoUrl: body.photoUrl,
  });

  if (joinUserData == -1) {
    throw new BaseError(status.EMAIL_ALREADY_EXIST);
  }
  return signinResponseDTO(joinUserData);
};

export const getProfile = async (userId) => {
  try {
    const user = await findUserById(userId);
    if (!user) throw new BaseError(status.NOT_FOUND, 'User not found');

    const scores = await findScoresByUserId(userId);
    return { user, scores };
  } catch (error) {
    throw new BaseError(status.PARAMETER_IS_WRONG, error.message);
  }
};
