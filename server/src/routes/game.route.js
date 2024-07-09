import express from 'express';
import { getAllGamesController } from '../controllers/game.controller.js';

export const gameRouter = express.Router();

gameRouter.get('/', getAllGamesController);
