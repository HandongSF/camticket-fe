// provider/reservation_detail_provider.dart

import 'package:camticket/model/reservation_info_model/reservation_info_model.dart';
import 'package:flutter/material.dart';

import '../utility/api_service.dart';

class ReservationDetailUserProvider with ChangeNotifier {
  ReservationDetailResponse? _reservationDetail;
  bool _isLoading = false;
  String? _error;

  ReservationDetailResponse? get reservationDetail => _reservationDetail;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchReservationDetail(int reservationId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await ApiService().fetchReservationDetail(reservationId);
      _reservationDetail = result;
    } catch (e) {
      _error = e.toString();
      _reservationDetail = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _reservationDetail = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
