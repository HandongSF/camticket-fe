import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // 토큰 저장
  Future<void> saveToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // 토큰 불러오기
  Future<String?> readToken(String key) async {
    return await _storage.read(key: key);
  }

  // 토큰 삭제
  Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }
}
