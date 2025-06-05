import 'package:flutter/material.dart';
import '../model/ticket_option_detail.dart';
import '../utility/api_service.dart';

class TicketOptionProvider with ChangeNotifier {
  List<TicketOptionDetail> _options = [];
  List<TicketOptionDetail> get options => _options;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadOptions(int postId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _options = await ApiService().fetchTicketOptions(postId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
