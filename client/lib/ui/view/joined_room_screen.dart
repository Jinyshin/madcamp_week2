import 'package:client/common/const/app_colors.dart';
import 'package:client/common/const/app_text_style.dart';
import 'package:client/common/widgets/confirm_dialog.dart';
import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/common/widgets/custom_textfield.dart';
import 'package:client/ui/view/game_list_screen.dart';
import 'package:flutter/material.dart';

class JoinedRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const JoinedRoomScreen({super.key});

  @override
  State<JoinedRoomScreen> createState() => _JoinedRoomScreenState();
}

class _JoinedRoomScreenState extends State<JoinedRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  // TODO: player list from server
  final List<String> players = ['사용자1', '사용자2'];

  void gameList(BuildContext context) {
    Navigator.pushNamed(context, GameListScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
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
                  Divider(color: AppColors.faintGray.withOpacity(0.3)),
                  const SizedBox(height: 8),
                  const Text(
                    // TODO: random number
                    '방 번호: 123456',
                    style: submenuContentTextStyle,
                  ),
                  const Text(
                    // TODO: QR code
                    'QR: 123456',
                    style: submenuContentTextStyle,
                  ),
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
                  Divider(color: AppColors.faintGray.withOpacity(0.3)),
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
        ),
      ),
    );
  }
}
