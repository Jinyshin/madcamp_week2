import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';
import { signinResponseDTO } from '../dtos/user.dto.js';
import { addUser } from '../repository/user.dao.js';

// User 데이터 삽입
export const joinUser = async (body) => {
  const joinUserData = await addUser({
    displayName: body.displayName,
    email: body.email,
    id: body.id,
    photoUrl: body.photoUrl,
  });

  if (joinUserData == -1) {
    throw new BaseError(status.EMAIL_ALREADY_EXIST);
  }
  return signinResponseDTO(user);
};
