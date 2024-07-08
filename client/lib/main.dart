import 'package:client/common/const/app_colors.dart';
import 'package:client/ui/view/create_room_screen.dart';
import 'package:client/ui/view/game_list_screen.dart';
import 'package:client/ui/view/game_wait_screen.dart';
import 'package:client/ui/view/join_room_screen.dart';
import 'package:client/ui/view/login_screen.dart';
import 'package:client/ui/view/main_menu_screen.dart';
import 'package:client/ui/view/my_profile_screen.dart';
import 'package:client/ui/view/ranking_room_screen.dart';
import 'package:client/ui/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/ui/view/game/dudeoji_game_screen.dart'; // 추가된 부분
import 'package:client/ui/view/game/image_game_screen.dart'; // 추가된 부분
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MolGam',
      
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.bgColor,
      ),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        GameListScreen.routeName: (context) => const GameListScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RankingScreen.routeName: (context) => const RankingScreen(),
        MyProfileScreen.routeName: (context) => const MyProfileScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        GameWaitScreen.routeName: (context) => const GameWaitScreen(
              title: '게임 대기 화면',
              gameId: '1', // 필요한 경우 실제 게임 ID를 전달
            ), // 추가된 부분
        '/dudeoji-game': (context) => const DudeojiGameScreen(title: 'Whack a Mole'), // 추가된 부분
        '/image-game': (context) => const ImageGameScreen(title: 'Image Similarity Game'), // 추가된 부분
      },
     
      
      // TODO: change to SplashScreen.routeName
      initialRoute: SplashScreen.routeName,
    );
  }
}
