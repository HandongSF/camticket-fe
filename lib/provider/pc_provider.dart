// lib/provider/performance_category_provider.dart
import 'package:flutter/material.dart';

class PerformanceCategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  int _selectedCategory = 0;

  int get selectedCategory => _selectedCategory;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }
}
