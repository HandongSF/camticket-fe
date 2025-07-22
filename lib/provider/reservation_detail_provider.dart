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

import 'package:camticket/utility/api_service.dart';
import 'package:flutter/material.dart';

import '../model/reservation_info_model/reservation_info_model.dart';

class ReservationDetailProvider extends ChangeNotifier {
  ReservationDetailResponse? detail;
  bool isLoading = false;
  String? error;

  Future<void> getReservationDetail(int reservationId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      detail = await ApiService().fetchReservationDetail(reservationId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
