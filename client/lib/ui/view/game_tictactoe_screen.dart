import 'package:client/data/services/socket_service.dart';
import 'package:flutter/material.dart';

class GameTicTacToeScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameTicTacToeScreen({super.key});

  @override
  State<GameTicTacToeScreen> createState() => _GameTicTacToeScreenState();
}

class _GameTicTacToeScreenState extends State<GameTicTacToeScreen> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    // _socketService.updateRoomListener(context);
    // _socketService.updatePlayersStateListener(context);
    // _socketService.pointIncreaseListener(context);
    // _socketService.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    // RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return const Scaffold(
        // body: roomDataProvider.roomData['isJoin']
        //     ? const WaitingLobby()
        //     : SafeArea(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             const Scoreboard(),
        //             const TicTacToeBoard(),
        //             Text(
        //                 '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
        //           ],
        //         ),
        //       ),
        );
  }
}
