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

import '../model/manage_overview.dart';
import '../utility/api_service.dart';

class ManageOverviewProvider with ChangeNotifier {
  List<ManageOverview> _performances = [];
  bool _isLoading = false;
  String? _error;

  List<ManageOverview> get performances => _performances;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchManageOverview() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _performances = await ApiService().fetchManageOverviewImage();
      debugPrint('Fetched overviews: ${_performances.length}');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
