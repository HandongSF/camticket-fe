import 'package:flutter/material.dart';

import '../model/manage_overview.dart';
import '../utility/api_service.dart';

class ManageOverviewProvider with ChangeNotifier {
  List<ManageOverview> _performances = [];
  bool _isLoading = false;
  String? _error;

  List<ManageOverview> get performances => _performances;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchManageOverview() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _performances = await ApiService().fetchManageOverviewImage();
      debugPrint('Fetched overviews: ${_performances.length}');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
