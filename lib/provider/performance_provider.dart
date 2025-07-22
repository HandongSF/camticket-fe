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

import 'package:camticket/model/performanceDetail.dart';
import 'package:camticket/utility/api_service.dart';
import 'package:flutter/material.dart';

import '../model/performance_overview_model.dart';

class PerformanceProvider with ChangeNotifier {
  List<PerformanceOverview> _performances = [];
  bool _isLoading = false;
  String? _error;

  List<PerformanceOverview> get performances => _performances;
  bool get isLoading => _isLoading;
  String? get error => _error;

  PerformanceDetail? _performanceDetails;
  PerformanceDetail? get performanceDetails => _performanceDetails;
  String? _detailError;
  String? get detailError => _detailError;
  bool _detailLoading = false;
  bool get detailLoading => _detailLoading;

  Future<void> fetchPerformanceDetail(int performanceId) async {
    _detailLoading = true;
    _detailError = null;
    notifyListeners();

    try {
      _performanceDetails =
          await ApiService().fetchPerformanceDetail(performanceId);
      //debugPrint('Fetched performance details: ${_performanceDetails.title}');
    } catch (e) {
      _detailError = e.toString();
      debugPrint('Error fetching performance details: $_detailError');
    } finally {
      _detailLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPerformances() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _performances = await ApiService().fetchOverview();
      debugPrint('Fetched performances: ${_performances.length}');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
