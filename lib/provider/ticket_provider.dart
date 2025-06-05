import 'package:flutter/material.dart';
import '../model/ticket_model.dart';
import '../utility/api_service.dart'; // ApiService 경로

class ReservationOverviewProvider with ChangeNotifier {
  List<ReservationOverview> _reservations = [];
  bool _isLoading = false;
  String? _error;

  List<ReservationOverview> get reservations => _reservations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchReservations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reservations = await ApiService().fetchMyReservationOverviews();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _reservations = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
