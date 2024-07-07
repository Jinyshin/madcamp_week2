import User from '../models/user.model.js';
import { BaseError } from '../../config/error.js';
import { status } from '../../config/response.status.js';

// User 데이터 삽입
export const addUser = async (data) => {
  try {
    // Check if the user already exists
    const existingUser = await User.findOne({ email: data.email });

    if (existingUser) {
      return -1;
    }

    // Create a new user
    const newUser = new User({
      email: data.email,
      name: data.name,
      gender: data.gender,
      birth: data.birth,
      addr: data.addr,
      specAddr: data.specAddr,
      phone: data.phone,
    });

    // Save the user to the database
    const result = await newUser.save();
    return result._id;
  } catch (err) {
    throw new BaseError(status.PARAMETER_IS_WRONG);
  }
};

// 사용자 정보 얻기
export const getUser = async (userId) => {
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
