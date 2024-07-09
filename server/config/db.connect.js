import mongoose from 'mongoose';
import dotenv from 'dotenv';
import Game from '../src/models/game.model.js';

dotenv.config();

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.DB_URI);
    console.log('Successfully connected to the database');

    // // 여러 데이터를 한 번에 삽입
    // const games = [
    //   {
    //     gameId: '1',
    //     name: '두더지 팡팡',
    //     description: '최대한 빠르게 두더지를 때려보세요!',
    //     rules:
    //       '두더지 게임은 화면에 나타나는 두더지를 잡는 게임입니다. 폭탄은 터치하지 마세요.',
    //   },
    //   {
    //     gameId: '2',
    //     name: '닮은 사람 찾기',
    //     description: '가장 닮은 사람 둘 마셔!',
    //     rules:
    //       '인공지능을 통해 여기 모여있는 사람들 중 가장 닮은 두 명을 찾아드립니다.',
    //   },
    //   {
    //     gameId: '3',
    //     name: '라이어 게임',
    //     description: '입벌구 여기여기 모여라 ^^',
    //     rules: '우리 중에 라이어가 있다! /n라이어를 찾아내 보자',
    //   },
    //   {
    //     gameId: '4',
    //     name: '훈민정음',
    //     description: '한국어 좀 치는 분들 모이세요',
    //     rules:
    //       '랜덤 초성이 보여집니다. 한 명씩 돌아가면서 해당 초성의 단어를 말해야 해요!',
    //   },
    // ];

    // gameId가 중복되지 않도록 삽입 전 확인
    // for (const game of games) {
    //   const existing = await Game.findOne({ gameId: game.gameId });
    //   if (!existing) {
    //     await Game.create(game);
    //     console.log('New game saved successfully');
    //   } else {
    //     console.log(`Game with gameId ${game.gameId} already exists`);
    //   }
    // }
  } catch (error) {
    console.error('Error connecting to the database', error);
  }
};

connectDB();

export default mongoose;
