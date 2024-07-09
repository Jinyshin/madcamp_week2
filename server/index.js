import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';
import path from 'path';
import { fileURLToPath } from 'url';
import Room from './src/models/room.model.js';
import { tempRouter } from './src/routes/temp.route.js';
import { userRouter } from './src/routes/user.route.js';
import { gameRouter } from './src/routes/game.route.js';
import { scoreRouter } from './src/routes/score.route.js';
import { response } from './config/response.js';
import { status } from './config/response.status.js';
import { BaseError } from './config/error.js';
import db from './config/db.connect.js'; // 이걸 해줘야 초기화가 됨
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const port = process.env.PORT || 3000;
const server = createServer(app);
const io = new Server(server);

// 정적 파일 제공
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'src', 'public', 'index.html'));
});

// server setting - veiw, static, body-parser etc..
app.set('port', process.env.PORT || 3000); // 서버 포트 지정
app.use(cors());
app.use(express.static('public')); // 정적 파일 접근
app.use(express.json()); // request의 본문을 json으로 해석할 수 있도록 함 (JSON 형태의 요청 body를 파싱하기 위함)
app.use(express.urlencoded({ extended: false })); // 단순 객체 문자열 형태로 본문 데이터 해석

// router setting
app.use('/temp', tempRouter);
app.use('/user', userRouter);
app.use('/games', gameRouter);
app.use('/score', scoreRouter);

// error handling
app.use((req, res, next) => {
  const err = new BaseError(status.NOT_FOUND);
  next(err);
});

app.use((err, req, res, next) => {
  // 템플릿 엔진 변수 설정
  res.locals.message = err.message;
  res.locals.error = process.env.NODE_ENV !== 'production' ? err : {};
  res.status(err.data.status).send(response(err.data));
});

io.on('connection', (socket) => {
  console.log('Socket.io 연결 성공!');

  // socket.on('userId', (data) => {
  //   console.log('플러터에서 보낸 userId:', data);
  // });
  socket.on('userId', async ({ data }) => {
    console.log('플러터에서 보낸 userId:', data);
  });

  socket.on('createRoom', async ({ userId }) => {
    try {
      // 새로운 게임 room을 생성하고 플레이어를 저장함
      let room = new Room();
      let player = {
        socketID: socket.id,
        userId,
        playerType: 'X',
      };
      room.players.push(player);
      room.turn = player; // 방장('X')이 먼저 시작함
      room.occupancy = 2;

      // MongoDB에 저장
      room = await room.save(); // 생성된 room을 리턴해줌. 우리가 보내지 않은 default 프로퍼티 값들도 활용하기 위해 재할당함.
      // console.log(room);

      const roomId = room._id.toString();
      socket.join(roomId); // 특정 room에 join하기 위함
      // 클라이언트에게 room이 생성되었음을 알림
      // 클라이언트는 다음 화면으로 이동함
      // socket.emit -> 나의 클라이언트에게만 noti를 줌
      // io.emit -> 이 앱에 참여중인 모든 player들에게 모두 noti를 줌
      // io.to(roomId) -> 이 방에 참여중인 player들에게 모두 noti를 줌
      io.to(roomId).emit('createRoomSuccess', room);
    } catch (e) {
      console.log(e);
    }
  });
});

server.listen(port, '0.0.0.0', () => {
  console.log(`server running at port:${port}`);
});
