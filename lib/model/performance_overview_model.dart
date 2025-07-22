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

class PerformanceOverview {
  final int postId;
  final String title;
  final String profileImageUrl;
  final DateTime reservationStartAt;
  final DateTime reservationEndAt;
  final DateTime firstScheduleStartTime;
  final String location;
  final int userId;
  final String category;
  final bool closed;

  String? profileImageUrl2; // 동적으로 추가될 필드

  PerformanceOverview({
    required this.postId,
    required this.title,
    required this.profileImageUrl,
    required this.reservationStartAt,
    required this.reservationEndAt,
    required this.firstScheduleStartTime,
    required this.location,
    required this.userId,
    required this.category,
    required this.closed,
    this.profileImageUrl2,
  });

  factory PerformanceOverview.fromJson(Map<String, dynamic> json) {
    return PerformanceOverview(
      postId: json['postId'],
      title: json['title'],
      profileImageUrl: json['profileImageUrl'],
      reservationStartAt: DateTime.parse(json['reservationStartAt']),
      reservationEndAt: DateTime.parse(json['reservationEndAt']),
      firstScheduleStartTime: DateTime.parse(json['firstScheduleStartTime']),
      location: json['location'],
      userId: json['userId'],
      category: json['category'],
      closed: json['closed'],
    );
  }
}
