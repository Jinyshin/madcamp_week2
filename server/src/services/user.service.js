import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';
import { signinResponseDTO } from '../dtos/user.dto.js';
import { addUser, getUser } from '../repository/user.dao.js';

// User 데이터 삽입
export const joinUser = async (body) => {
  const joinUserData = await addUser({
    email: body.email,
    name: body.name,
    gender: body.gender,
    birth: body.birth,
    addr: body.addr,
    specAddr: body.specAddr,
    phone: body.phone,
  });

  if (joinUserData == -1) {
    throw new BaseError(status.EMAIL_ALREADY_EXIST);
  } else {
    const user = await getUser(joinUserData);
    if (user === -1) {
      throw new BaseError(status.USER_NOT_FOUND);
    }
    return signinResponseDTO(user);
  }
};
