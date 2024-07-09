import User from '../models/user.model.js';
import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';

// User 데이터 삽입
export const saveUser = async (data) => {
  try {
    // Check if the user already exists
    const existingUser = await User.findOne({ email: data.email });

    if (existingUser) {
      return -1;
    }

    // Create a new user
    const newUser = new User({
      displayName: data.displayName,
      email: data.email,
      gender: data.gender,
      id: data.id,
      addr: data.addr,
      photoUrl: data.photoUrl,
    });

    // Save the user to the database
    const result = await newUser.save();
    return result._id;
  } catch (err) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
};

// 사용자 정보 얻기
export const findUserById = async (userId) => {
  try {
    const user = await User.findById(userId);

    if (!user) {
      return -1;
    }

    return user;
  } catch (err) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
};
