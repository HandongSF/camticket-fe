import 'package:flutter/material.dart';
import 'package:camticket/model/reservation_list_model.dart';
import 'package:camticket/utility/api_service.dart';

class ReservationProvider with ChangeNotifier {
  // --- 내부 상태 ---------------------------------------------------------
  List<ReservationData> _reservationList = [];
  bool _isLoading = false;
  String? _error;

  // --- 외부 노출(read-only) --------------------------------------------
  List<ReservationData> get reservationList => _reservationList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // --- API 호출 ----------------------------------------------------------
  Future<void> fetchReservationList(int postId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _reservationList = await ApiService().fetchReservationList(postId);
    } catch (e) {
      _error = 'fetchReservationList 오류: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- 헬퍼: 데이터 초기화 -----------------------------------------------
  void clear() {
    _reservationList = [];
    _error = null;
    notifyListeners();
  }
}
