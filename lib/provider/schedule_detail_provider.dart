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
