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
    checkUserId();
  }

  void signup(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignUpScreen.routeName,
      (route) => false,
    );
  }

  void mainMenu(BuildContext context, String userId) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainMenuScreen.routeName,
      (route) => false,
    );
  }

  void checkUserId() async {
    final userId = await AuthStorage.getUserId();
    // AuthStorage.delUserId(); // userId 삭제 코드

    if (userId == null) {
      if (!mounted) return;
      print('여기?');
      signup(context);
    } else {
      if (!mounted) return;
      mainMenu(context, userId);
    }
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
