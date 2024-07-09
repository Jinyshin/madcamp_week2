import mongoose from 'mongoose';

const GameSchema = new mongoose.Schema({
  gameId: {
    type: String,
    required: true,
    unique: true,
  },
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  rules: {
    type: String,
    required: true,
  },
});

const Game = mongoose.model('Game', GameSchema);

export default Game;
