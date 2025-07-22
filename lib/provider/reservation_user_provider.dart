/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
