import 'package:flutter/material.dart';
import '../model/schedule_detail_model.dart';
import '../utility/api_service.dart';

class ScheduleDetailProvider with ChangeNotifier {
  List<ScheduleDetail> _scheduleDetails = [];
  bool _isLoading = false;

  List<ScheduleDetail> get scheduleDetails => _scheduleDetails;
  bool get isLoading => _isLoading;

  Future<void> loadScheduleDetails(int postId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _scheduleDetails = await ApiService().fetchScheduleDetails(postId);
    } catch (e) {
      debugPrint('회차 정보 로딩 실패: $e');
      _scheduleDetails = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
