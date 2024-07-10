import 'package:client/common/utils/dialog.dart';
import 'package:client/common/utils/game_service.dart';
import 'package:client/common/utils/snackbar.dart';
import 'package:client/common/utils/socket_client.dart';
import 'package:client/data/provider/room_data_provider.dart';
import 'package:client/ui/view/joined_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  void joinRoom(String userId, String roomId) {
    if (userId.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'userId': userId,
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
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      // Navigator.pushNamed(context, TicTacToeGameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, JoinedRoomScreen.routeName);
    });

    _socketClient.on('updatePlayers', (players) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      Map<String, dynamic> updatedRoomData = roomDataProvider.roomData;
      updatedRoomData['players'] = players;
      roomDataProvider.updateRoomData(updatedRoomData);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['userId']} won the game!');
      // 임시
      Navigator.popUntil(context, (route) => false);
    });
  }
}
