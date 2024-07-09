import 'package:client/common/widgets/custon_auth_button.dart';
import 'package:client/data/services/user_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return Scaffold(
      body: Center(
        child: CustomAuthButton(
          onTap: () => userService.handleSignIn(context),
          text: 'Sign in with Google',
        ),
      ),
    );
  }
}
