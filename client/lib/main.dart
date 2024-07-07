import 'package:client/common/const/app_colors.dart';
import 'package:client/ui/view/create_room_screen.dart';
import 'package:client/ui/view/join_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.bgColor,
      ),
      routes: {
        MainMenuScreen.routeName: (context) => MainMenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      initialRoute: MainMenuScreen.routeName,
    );
  }
}

// 구글 로그인에 필요한 권한(스코프)을 정의하는 리스트
const List<String> scopes = <String>[
  'email', // 이메일 주소 접근 권한
  'https://www.googleapis.com/auth/contacts.readonly', // 읽기 전용으로 구글 연락처 접근 권한
];

// GoogleSignIn 클래스의 인스턴스를 생성
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

// 구글 로그인을 처리하는 함수
Future<void> _handleSignIn(BuildContext context) async {
  try {
    await _googleSignIn.signIn();
    Navigator.pushNamed(context, HomeScreen.routeName);
  } catch (error) {
    print(error);
  }
}

class MainMenuScreen extends StatelessWidget {
  static const routeName = '/main-menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleSignIn(context),
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateRoomScreen.routeName);
              },
              child: Text('방 만들기'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, JoinRoomScreen.routeName);
              },
              child: Text('방 들어가기'),
            ),
            TextButton(
              onPressed: () {
                // 랭킹 화면으로 이동하는 코드 작성
              },
              child: Text('랭킹'),
            ),
            TextButton(
              onPressed: () {
                // 내 프로필 화면으로 이동하는 코드 작성
              },
              child: Text('내 프로필'),
            ),
          ],
        ),
      ),
    );
  }
}

