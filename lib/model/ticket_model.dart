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

// model/reservation_overview.dart

class ReservationOverview {
  final int reservationId;
  final String performanceTitle;
  final DateTime performanceDate;
  final String ticketOptionName;
  final int ticketPrice;
  final int count;
  final int totalPrice;
  final String status;
  final List<String> selectedSeats;
  final DateTime regDate;
  final DateTime reservationStartAt;
  final DateTime reservationEndAt;
  final String location;
  final String locationDisplayName;
  final String performanceProfileImageUrl;
  final int artistId;
  final String artistName;
  final String artistProfileImageUrl;

  ReservationOverview({
    required this.reservationId,
    required this.performanceTitle,
    required this.performanceDate,
    required this.ticketOptionName,
    required this.ticketPrice,
    required this.count,
    required this.totalPrice,
    required this.status,
    required this.selectedSeats,
    required this.regDate,
    required this.reservationStartAt,
    required this.reservationEndAt,
    required this.location,
    required this.locationDisplayName,
    required this.performanceProfileImageUrl,
    required this.artistId,
    required this.artistName,
    required this.artistProfileImageUrl,
  });

  factory ReservationOverview.fromJson(Map<String, dynamic> json) {
    return ReservationOverview(
      reservationId: json['reservationId'],
      performanceTitle: json['performanceTitle'],
      performanceDate: DateTime.parse(json['performanceDate']),
      ticketOptionName: json['ticketOptionName'],
      ticketPrice: json['ticketPrice'],
      count: json['count'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      regDate: DateTime.parse(json['regDate']),
      reservationStartAt: DateTime.parse(json['reservationStartAt']),
      reservationEndAt: DateTime.parse(json['reservationEndAt']),
      location: json['location'],
      locationDisplayName: json['locationDisplayName'],
      performanceProfileImageUrl: json['performanceProfileImageUrl'],
      artistId: json['artistId'],
      artistName: json['artistName'],
      artistProfileImageUrl: json['artistProfileImageUrl'],
    );
  }
}
