import 'package:client/common/utils/auth_storage.dart';
import 'package:client/data/models/user_join_request.dart';
import 'package:client/data/models/user_join_response.dart';
import 'package:client/ui/view/main_menu_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  final Dio dio = Dio();

  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  Future<void> handleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print(account);

        UserJoinRequest userJoinRequest = UserJoinRequest(
          account.displayName!,
          account.email,
          account.id,
          account.photoUrl,
        );

        print(userJoinRequest.toString());

        await signUp(userJoinRequest);
        if (!context.mounted) return;
        Navigator.pushNamed(context, MainMenuScreen.routeName);
      }
    } catch (error) {
      print('구글로그인 에러: $error');
    }
  }

  Future<UserJoinResponse> signUp(UserJoinRequest userJoinRequest) async {
    const url = 'http://143.248.191.30:3000/user/signin';
    final data = userJoinRequest.toJson();

    try {
      final response = await dio.post(url, data: data);

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UserJoinResponse userJoinResponse =
            UserJoinResponse.fromJson(response.data);
        await AuthStorage.saveUserId(userJoinResponse.result.id);

        return UserJoinResponse.fromJson(response.data);
      } else {
        throw Exception('로그인 실패: ${response.data}');
      }
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }
}
