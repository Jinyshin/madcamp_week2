import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/ui/view/create_room_screen.dart';
import 'package:client/ui/view/join_room_screen.dart';
import 'package:client/ui/view/ranking_room_screen.dart';
import 'package:client/ui/view/my_profile_screen.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
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
        title: const Text('몰겜'),
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
