import 'package:flutter/material.dart';
import '../model/jwt_model.dart';

class JwtProvider with ChangeNotifier {
  JwtToken? _jwt;

  JwtToken? get jwt => _jwt;

  void setJwt(JwtToken jwt) {
    _jwt = jwt;
    notifyListeners();
  }

  void clearJwt() {
    _jwt = null;
    notifyListeners();
  }

  bool get isLoggedIn => _jwt != null;
}
