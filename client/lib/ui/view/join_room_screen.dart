import 'package:client/common/widgets/custom_auth_button.dart';
import 'package:client/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "방 찾기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            CustomTextField(
              controller: _nicknameController,
              hintText: '닉네임을 입력하세요',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _gameIdController,
              hintText: '방 번호를 입력하세요',
            ),
            SizedBox(height: size.height * 0.045),
            CustomButton(onTap: () {}, text: '참가하기'),
          ],
        ),
      ),
    );
  }
}
