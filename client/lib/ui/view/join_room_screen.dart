import 'package:client/common/utils/auth_storage.dart';
import 'package:client/common/utils/socket_service.dart';
import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final SocketService _socketService = SocketService();
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _socketService.joinRoomSuccessListener(context);
    _socketService.errorOccuredListener(context);
    _socketService.updatePlayersStateListener(context);
  }

  Future<void> _initializeUserId() async {
    final id = await AuthStorage.getUserId();
    setState(() {
      userId = id!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('방 찾기'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CustomTextField(
              controller: _gameIdController,
              hintText: '방 번호를 입력하세요',
            ),
            SizedBox(height: size.height * 0.045),
            CustomButton(
              onTap: () =>
                  _socketService.joinRoom(userId, _gameIdController.text),
              text: '참가하기',
            ),
          ],
        ),
      ),
    );
  }
}
