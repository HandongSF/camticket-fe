import 'package:flutter/material.dart';

import '../model/performanceDetail.dart';

class SelectedPerformanceProvider with ChangeNotifier {
  PerformanceDetail? _selectedPerformance;
  PerformanceDetail? get selectedPerformance => _selectedPerformance;

  void setSelectedPerformance(PerformanceDetail? performance) {
    _selectedPerformance = performance;
    notifyListeners();
  }

  Future<PerformanceDetail?> fetchSelectedPerformance() async {
    return selectedPerformance;
  }
}
