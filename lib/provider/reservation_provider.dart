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
