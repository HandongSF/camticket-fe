import 'package:flutter/material.dart';

import '../model/artist_manager.dart';
import '../utility/api_service.dart';

class ArtistManagerProvider with ChangeNotifier {
  List<ArtistManager> _managers = [];
  List<ArtistManager> get managers => _managers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadManagers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _managers = await ApiService().fetchArtistManagers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
