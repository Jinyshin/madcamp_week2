import 'dart:io';

abstract class AppConfig {
  // static String localHost = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  static String localHost = '127.0.0.1';
  static String baseUrl = 'http://$localHost:3000';
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
