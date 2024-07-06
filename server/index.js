import express from 'express';
import http from 'http';
import mongoose from 'mongoose';
import { Server as SocketIOServer } from 'socket.io';

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = new SocketIOServer(server);

// middleware
app.use(express.json());

const DB =
  'mongodb+srv://jinyshin:1234@gamecluster.rxdktyn.mongodb.net/?retryWrites=true&w=majority&appName=GameCluster';

io.on('connection', (socket) => {
  console.log('Socket.io 연결 성공!'); // TODO: not working. why..
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
  console.log(`Server started and running on port ${port}`);
});
