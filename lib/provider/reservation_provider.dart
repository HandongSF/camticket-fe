import 'package:camticket/model/reservation_list_model.dart';
import 'package:camticket/utility/api_service.dart';
import 'package:flutter/material.dart';

class ReservationProvider with ChangeNotifier {
  List<ReservationData> reservationList = [];

  Future<void> fetchReservationList(int postId) async {
    try {
      reservationList = await ApiService().fetchReservationList(postId);
    } catch (e) {
      debugPrint('error : $e');
      return;
    }
  }
}
