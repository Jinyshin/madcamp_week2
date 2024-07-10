import 'package:client/common/const/app_colors.dart';
import 'package:client/common/const/app_text_style.dart';
import 'package:client/common/utils/socket_service.dart';
import 'package:client/common/widgets/confirm_dialog.dart';
import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/data/provider/room_data_provider.dart';
import 'package:client/ui/view/game/tictactoe_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketService _socketService = SocketService();

  void gameList(BuildContext context) {
    // Navigator.pushNamed(context, GameListScreen.routeName);
    // 임시
    Navigator.pushNamed(context, TicTacToeGameScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _socketService.updateRoomListener(context);
    _socketService.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showLeaveRoomConfirmDialog(context);
          },
        ),
        title: const Text('방 만들기'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<RoomDataProvider>(
                builder: (context, roomDataProvider, child) {
                  final roomNumber = roomDataProvider.roomData['_id'] ?? '';
                  final players =
                      (roomDataProvider.roomData['players'] as List<dynamic>?)
                              ?.map((player) => player['userId'] as String)
                              .toList() ??
                          [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '방 정보',
                              style: submenuTitleTextStyle,
                            ),
                            Divider(
                                color: AppColors.faintGray.withOpacity(0.3)),
                            const SizedBox(height: 8),
                            Text(
                              '방 번호: $roomNumber',
                              style: submenuContentTextStyle,
                            ),
                            // const Text(
                            //   'QR: 123456',
                            //   style: submenuContentTextStyle,
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '플레이어 정보',
                              style: submenuTitleTextStyle,
                            ),
                            Divider(
                                color: AppColors.faintGray.withOpacity(0.3)),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                itemCount: players.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    players[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      CustomButton(
                        onTap: () => gameList(context),
                        text: '게임 선택',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
