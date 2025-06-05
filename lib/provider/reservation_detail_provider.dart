import 'package:camticket/utility/api_service.dart';
import 'package:flutter/material.dart';

import '../model/reservation_info_model/reservation_info_model.dart';

class ReservationDetailProvider extends ChangeNotifier {
  ReservationDetailResponse? detail;
  bool isLoading = false;
  String? error;

  Future<void> getReservationDetail(int reservationId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      detail = await ApiService().fetchReservationDetail(reservationId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
