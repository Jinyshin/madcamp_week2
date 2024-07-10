import 'package:client/common/const/app_colors.dart';
import 'package:client/common/utils/socket_service.dart';
import 'package:client/data/provider/room_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _socketService.tappedListener(context);
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketService.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketService.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 100),
                    child: Text(
                      roomDataProvider.displayElements[index],
                      style: TextStyle(
                        color: roomDataProvider.displayElements[index] == 'O'
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
