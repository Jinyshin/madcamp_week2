import express from 'express';
import {
  userJoinController,
  getProfileController,
} from '../controllers/user.controller.js';

export const userRouter = express.Router();

userRouter.post('/signin', userJoinController);
userRouter.get('/profile/:userId', getProfileController);
