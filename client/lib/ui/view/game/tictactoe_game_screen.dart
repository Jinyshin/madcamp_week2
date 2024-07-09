import 'package:client/data/provider/room_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeGameScreen extends StatefulWidget {
  static String routeName = '/tictactoe';
  const TicTacToeGameScreen({super.key});

  @override
  State<TicTacToeGameScreen> createState() => _TicTacToeGameScreenState();
}

class _TicTacToeGameScreenState extends State<TicTacToeGameScreen> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<RoomDataProvider>(context).roomData.toString());
    return const Scaffold();
  }
}
