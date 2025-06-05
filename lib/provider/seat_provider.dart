import 'package:flutter/material.dart';

import '../utility/api_service.dart';

class SeatProvider with ChangeNotifier {
  Set<String> _reservedSeats = {};
  Set<String> _disabledSeats = {};
  Set<String>? _selectedSeat;

  Set<String>? get selectedSeat => _selectedSeat;
  Set<String> get reservedSeats => _reservedSeats;
  Set<String> get disabledSeats => _disabledSeats;

  void selectSeat(Set<String>? seat) {
    _selectedSeat = seat;
    notifyListeners();
  }

  Future<void> fetchSeatStatus(int scheduleId) async {
    try {
      final seats = await ApiService().fetchSeatStatus(scheduleId);
      debugPrint("seats : ${seats.length}");
      _reservedSeats = seats
          .where((e) => e.status == 'PENDING')
          .map((e) => e.seatCode)
          .toSet();
      debugPrint("reservedSeats : ${reservedSeats.length}");

      _disabledSeats = seats
          .where((e) => e.status == 'UNAVAILABLE')
          .map((e) => e.seatCode)
          .toSet();
      debugPrint("disabledSeats : ${disabledSeats.length}");

      notifyListeners();
    } catch (e) {
      debugPrint('좌석 정보 로딩 실패: $e');
    }
  }

  Future<void> clearSeats() async {
    _reservedSeats.clear();
    _disabledSeats.clear();
  }
}
