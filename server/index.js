import express from 'express';
import { createServer } from 'http';
import { join } from 'path';
import { Server } from 'socket.io';
// import Room from './models/room_model.js';
import { tempRouter } from './src/routes/temp.routes.js';
import { userRouter } from './src/routes/user.route.js';
import { response } from './config/response.js';
import { status } from './config/response.status.js';
import { BaseError } from './config/error.js';
import db from './config/db.connect.js'; // 이걸 해줘야 초기화가 됨
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;
const server = createServer(app);
const io = new Server(server);

// server setting - veiw, static, body-parser etc..
app.set('port', process.env.PORT || 3000); // 서버 포트 지정
app.use(cors()); // cors 방식 허용
app.use(express.static('public')); // 정적 파일 접근
app.use(express.json()); // request의 본문을 json으로 해석할 수 있도록 함 (JSON 형태의 요청 body를 파싱하기 위함)
app.use(express.urlencoded({ extended: false })); // 단순 객체 문자열 형태로 본문 데이터 해석

// TODO: flutter랑 연결하기
// app.get('/', (req, res) => {
//   res.sendFile(join(__dirname, 'index.html'));
// });

io.on('connection', (socket) => {
  console.log('Socket.io 연결 성공!');

  socket.on('msg', async ({ msg }) => {
    console.log(msg);
  });

  socket.on('createRoom', async ({ nickname }) => {
    try {
      console.log(nickname);
      // room is created
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: 'X',
      };
      room.players.push(player);
      room.turn = player; // 방장이 먼저
      // mongo db에 저장
      room = await room.save();
      console.log(room);
      const roomId = room._id.toString();

      socket.join(roomId);
      // notify
      io.to(roomId).emit('createRoomSuccess', room);

      // go to the next page
    } catch (e) {
      console.log(e);
    }
  });
});

// router setting
app.use('/temp', tempRouter);
app.use('/user', userRouter);

// error handling
app.use((req, res, next) => {
  const err = new BaseError(status.NOT_FOUND);
  next(err);
});

app.use((err, req, res, next) => {
  // 템플릿 엔진 변수 설정
  res.locals.message = err.message;
  // 개발환경이면 에러를 출력하고 아니면 출력하지 않기
  res.locals.error = process.env.NODE_ENV !== 'production' ? err : {};
  res.status(err.data.status).send(response(err.data));
});

server.listen(port, '0.0.0.0', () => {
  console.log(`server running at http://localhost:${port}`);
});
