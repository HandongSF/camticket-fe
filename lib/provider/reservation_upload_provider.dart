import 'package:flutter/material.dart';
import '../model/reservation_request.dart';
import '../utility/api_service.dart';

class ReservationUploadProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> uploadReservation(ReservationRequest request) async {
    _isLoading = true;
    _isSuccess = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await ApiService().uploadReservation(request);
      if (success) {
        _isSuccess = true;
      } else {
        _errorMessage = '예매에 실패했습니다.';
      }
    } catch (e) {
      _errorMessage = '예외 발생: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _isSuccess = false;
    _errorMessage = null;
    notifyListeners();
  }
}
