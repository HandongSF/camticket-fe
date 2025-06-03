import 'package:camticket/auth/secure_storage.dart';
import 'package:camticket/utility/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/user.dart'; // User 클래스 경로 맞게 수정

class UserProvider with ChangeNotifier {
  SecureStorage secureStorage = SecureStorage();

  User? _user;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners(); // 사용자 정보 변경을 구독 중인 위젯에 알려줌
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    try {
      String? userId = await secureStorage.readToken('user-id'); // await 추가
      if (userId != null) {
        _user = await ApiService().fetchUserInfo(int.parse(userId));
        notifyListeners();
      } else {
        debugPrint('userId가 저장되어 있지 않습니다.');
      }
    } catch (e) {
      debugPrint('error : $e');
    }
  }

  void updateUserInfo({
    required String name,
    String? introduction,
    String? bankAccount
  }) async {
    if (_user == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final role = _user!.role;
      final userId = _user!.id;
      if (userId == null) {
        _error = 'User ID가 null입니다. 업데이트할 수 없습니다.';
        debugPrint(_error);
        return;
      }
      User updatedUser;

      if (role == 'ROLE_MANAGER') {
        updatedUser = await ApiService().updateUserInfoForManager(
          userId: userId,
          nickName: name,
          introduction: introduction ?? _user!.introduction ?? '',
        );
      } else if (role == 'ROLE_USER') {
        updatedUser = await ApiService().updateUserInfoForUser(
          userId: userId,
          nickName: name,
          bankAccount: bankAccount ?? _user!.bankAccount ?? '',
        );
      } else {
        // 기타 역할 처리
        updatedUser = _user!;
      }

      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = '업데이트 중 오류 발생: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
