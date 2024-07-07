import 'package:client/common/layout/default_layout.dart';
import 'package:client/common/utils/auth_storage.dart';
import 'package:client/ui/view/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void login(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  void mainMenu(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainMenuScreen.routeName,
      (route) => false,
    );
  }

  void checkToken() async {
    final accessToken = await AuthStorage.getAccessToken();
    final refreshToken = await AuthStorage.getRefreshToken();

    // AuthStorage.delAccessToken(); // 회원가입 api 연결을 위한 임시 토큰 삭제 코드

    // if (accessToken == null || refreshToken == null) {
    //   if (!mounted) return;
    //   login(context);
    // } else {
    //   // TODO: 실제로는 일치 여부 확인까지 필요함
    //   if (!mounted) return;
    //   mainMenu(context);
    // }
    mainMenu(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'asset/logo.svg',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
