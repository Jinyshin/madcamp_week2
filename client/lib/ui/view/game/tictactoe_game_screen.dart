import 'package:client/common/utils/socket_service.dart';
import 'package:client/data/provider/room_data_provider.dart';
import 'package:client/ui/widgets/scoreboard.dart';
import 'package:client/ui/widgets/tictactoeboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeGameScreen extends StatefulWidget {
  static String routeName = '/tictactoe';
  const TicTacToeGameScreen({super.key});

  @override
  State<TicTacToeGameScreen> createState() => _TicTacToeGameScreenState();
}

class _TicTacToeGameScreenState extends State<TicTacToeGameScreen> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _socketService.updateRoomListener(context);
    _socketService.updatePlayersStateListener(context);
    _socketService.pointIncreaseListener(context);
    _socketService.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Scoreboard(),
            const TicTacToeBoard(),
            Text('${roomDataProvider.roomData['turn']['userId']} 차례입니다!'),
          ],
        ),
      ),
    );
  }
}
