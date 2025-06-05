import 'package:flutter/material.dart';
import '../model/artist_performance.dart';
import '../utility/api_service.dart';

class ArtistPerformanceProvider with ChangeNotifier {
  List<ArtistPerformance> _performances = [];
  bool _isLoading = false;
  String? _error;

  List<ArtistPerformance> get performances => _performances;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPerformances(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _performances = await ApiService().fetchArtistPerformances(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
