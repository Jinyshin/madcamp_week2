import 'package:client/common/widgets/custon_auth_button.dart';
import 'package:client/ui/view/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAuthButton(
          onTap: () => _handleSignIn(context),
          text: 'Sign in with Google',
        ),
      ),
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
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    print('Sign-in successful: ${account!.toString()}');
    Navigator.pushNamed(context, MainMenuScreen.routeName);
  } catch (error) {
    print('에러: $error');
  }
}
