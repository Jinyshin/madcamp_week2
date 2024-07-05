import 'dart:io';

class AppConfig {
  static String baseUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
  static const String signInUrl = 'auth/signin';
  static const String signUpUrl = 'users/registration';
  static const String logOutUrl = 'users/logout';
  static const String googleSignInUrl = 'auth/google/login';
  static const String profileUrl = 'users/user';

  static const timeout = Duration(seconds: 5);
  static const splashTime = Duration(seconds: 2);
  static const String accessTokenKey = 'access';
  static const String refreshTokenKey = 'refresh';
}
