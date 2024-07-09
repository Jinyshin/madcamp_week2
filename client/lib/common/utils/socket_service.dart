import 'package:client/common/utils/socket_client.dart';
import 'package:client/ui/view/game/tictactoe_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  final _socketClient = SocketClient.instance.socket;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String userId) {
    // _socketClient.emit('userId', userId);
    _socketClient.emit('userId', {'data': userId});

    if (userId.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'userId': userId,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      print('방이 잘 생성됐다면 여기에 방 id가 출력되어야 한다.');
      print(room);
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
      // TODO: 빠른 구현을 위해 일단 틱택토로 라우팅해둠 -> GameListScreen 라우팅으로 수정하기
      Navigator.pushNamed(context, TicTacToeGameScreen.routeName);
    });
  }

  // void joinRoomSuccessListener(BuildContext context) {
  //   _socketClient.on('joinRoomSuccess', (room) {
  //     Provider.of<RoomDataProvider>(context, listen: false)
  //         .updateRoomData(room);
  //     Navigator.pushNamed(context, GameScreen.routeName);
  //   });
  // }

  // void errorOccuredListener(BuildContext context) {
  //   _socketClient.on('errorOccurred', (data) {
  //     showSnackBar(context, data);
  //   });
  // }

  // void updatePlayersStateListener(BuildContext context) {
  //   _socketClient.on('updatePlayers', (playerData) {
  //     Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
  //       playerData[0],
  //     );
  //     Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
  //       playerData[1],
  //     );
  //   });
  // }

  // void updateRoomListener(BuildContext context) {
  //   _socketClient.on('updateRoom', (data) {
  //     Provider.of<RoomDataProvider>(context, listen: false)
  //         .updateRoomData(data);
  //   });
  // }

  // void tappedListener(BuildContext context) {
  //   _socketClient.on('tapped', (data) {
  //     RoomDataProvider roomDataProvider =
  //         Provider.of<RoomDataProvider>(context, listen: false);
  //     roomDataProvider.updateDisplayElements(
  //       data['index'],
  //       data['choice'],
  //     );
  //     roomDataProvider.updateRoomData(data['room']);
  //     // check winnner
  //     GameMethods().checkWinner(context, _socketClient);
  //   });
  // }

  // void pointIncreaseListener(BuildContext context) {
  //   _socketClient.on('pointIncrease', (playerData) {
  //     var roomDataProvider =
  //         Provider.of<RoomDataProvider>(context, listen: false);
  //     if (playerData['socketID'] == roomDataProvider.player1.socketID) {
  //       roomDataProvider.updatePlayer1(playerData);
  //     } else {
  //       roomDataProvider.updatePlayer2(playerData);
  //     }
  //   });
  // }

  // void endGameListener(BuildContext context) {
  //   _socketClient.on('endGame', (playerData) {
  //     showGameDialog(context, '${playerData['nickname']} won the game!');
  //     Navigator.popUntil(context, (route) => false);
  //   });
  // }
}
