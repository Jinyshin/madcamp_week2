const express = require('express');
const { createServer } = require('http');
const { join } = require('path');
const mongoose = require('mongoose');
const { Server } = require('socket.io');
const Room = require('./models/room_model');
const port = process.env.PORT || 3000;

const app = express();
const server = createServer(app);
const io = new Server(server);

const DB =
  'mongodb+srv://jinyshin:1234@gamecluster.rxdktyn.mongodb.net/?retryWrites=true&w=majority&appName=GameCluster';

// TODO: flutter랑 연결하기
app.get('/', (req, res) => {
  res.sendFile(join(__dirname, 'index.html'));
});

io.on('connection', (socket) => {
  console.log('Socket.io 연결 성공!');

  socket.on('msg', async ({ msg }) => {
    print(msg);
  });

  socket.on('creaeteRoom', async ({ nickname }) => {
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

      socket.join(room);
      // notify
      io.to(roomId).emit('createRoomSuccess', room);

      // go to the next page
    } catch (e) {
      console.log(e);
    }
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log('DB 연결 성공!');
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, '0.0.0.0', () => {
  console.log(`server running at http://localhost:${port}`);
});
