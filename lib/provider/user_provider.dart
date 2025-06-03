import 'package:flutter/material.dart';
import '../model/user.dart'; // User 클래스 경로 맞게 수정

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners(); // 사용자 정보 변경을 구독 중인 위젯에 알려줌
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
