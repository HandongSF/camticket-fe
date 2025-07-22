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
