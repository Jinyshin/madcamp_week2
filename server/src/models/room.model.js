import mongoose from 'mongoose';
import playerSchema from './player.model.js';

const roomSchema = new mongoose.Schema({
  occupancy: {
    type: Number,
    default: 1,
  },
  maxRounds: {
    type: Number,
    default: 3,
  },
  currentRound: {
    required: true,
    type: Number,
    default: 1,
  },
  players: [playerSchema],
  isJoin: {
    type: Boolean,
    default: true,
  },
  turn: playerSchema,
  turnIndex: {
    type: Number,
    default: 0,
  },
});

const roomModel = mongoose.model('Room', roomSchema);

export default roomModel;
