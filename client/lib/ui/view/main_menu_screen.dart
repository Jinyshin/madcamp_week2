import 'package:client/common/utils/socket_service.dart';
import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/ui/view/create_room_screen.dart';
import 'package:client/ui/view/join_room_screen.dart';
import 'package:client/ui/view/ranking_room_screen.dart';
import 'package:client/ui/view/my_profile_screen.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  static String routeName = '/main-menu';
  final String userId;

  const MainMenuScreen({super.key, required this.userId});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final SocketService _socketService = SocketService();

  void createRoom(BuildContext context) {
    // TODO: 방을 새로 생성하고, response로 받은 방 번호를 보내야 할듯?->일단은 기획을 영상대로 하고 추후 변경하든가말든가

    _socketService.createRoom(widget.userId);
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void ranking(BuildContext context) {
    Navigator.pushNamed(context, RankingScreen.routeName);
  }

  void myProfile(BuildContext context) {
    Navigator.pushNamed(context, MyProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOLEGAME'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: "방 만들기",
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => joinRoom(context),
              text: "방 찾기",
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => ranking(context),
              text: "랭킹 보기",
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => myProfile(context),
              text: "내 정보",
            ),
          ],
        ),
      ),
    );
  }
}
