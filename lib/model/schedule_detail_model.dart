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

class ScheduleDetail {
  final int scheduleId;
  final DateTime startTime;
  final int availableSeats;
  final int totalSeats;
  final bool bookingAvailable;

  ScheduleDetail({
    required this.scheduleId,
    required this.startTime,
    required this.availableSeats,
    required this.totalSeats,
    required this.bookingAvailable,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      scheduleId: json['scheduleId'],
      startTime: DateTime.parse(json['startTime']),
      availableSeats: json['availableSeats'],
      totalSeats: json['totalSeats'],
      bookingAvailable: json['bookingAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'startTime': startTime.toIso8601String(),
      'availableSeats': availableSeats,
      'totalSeats': totalSeats,
      'bookingAvailable': bookingAvailable,
    };
  }
}
