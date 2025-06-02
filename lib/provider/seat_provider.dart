import 'package:flutter/material.dart';

class SeatProvider with ChangeNotifier {
  Set<String>? _selectedSeat;

  Set<String>? get selectedSeat => _selectedSeat;

  void selectSeat(Set<String>? seat) {
    _selectedSeat = seat;
    notifyListeners();
  }
}
