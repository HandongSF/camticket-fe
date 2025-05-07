import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String _subPage = 'default';
  String get subPage => _subPage;
  void setIndex(int index) {
    debugPrint("Selected index: $index");
    _selectedIndex = index;
    notifyListeners();
  }

  void setSubPage(String page) {
    _subPage = page;
    notifyListeners();
  }
}
