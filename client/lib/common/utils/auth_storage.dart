import 'package:client/common/const/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessTokenKey = AppConfig.accessTokenKey;
  static const _refreshTokenKey = AppConfig.refreshTokenKey;

  // 유저 아이디 키 저장
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'userId', value: userId);
  }

  // 유저 아이디 키 검색
  static Future<String?> getUserId() async {
    return await _storage.read(key: 'userId');
  }

  // 유저 아이디 키 삭제
  static Future<String?> delUserId() async {
    await _storage.delete(key: 'userId');
    return null;
  }
}
