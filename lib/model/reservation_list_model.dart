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

class ReservationData {
  final int reservationId;
  final String performanceTitle;
  final DateTime performanceDate;
  final String userNickName;
  final String userEmail;
  final String ticketOptionName;
  final int ticketPrice;
  final int count;
  final int totalPrice;
  final String status;
  final List<String> selectedSeats;
  final DateTime regDate;

  ReservationData({
    required this.reservationId,
    required this.performanceTitle,
    required this.performanceDate,
    required this.userNickName,
    required this.userEmail,
    required this.ticketOptionName,
    required this.ticketPrice,
    required this.count,
    required this.totalPrice,
    required this.status,
    required this.selectedSeats,
    required this.regDate,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      reservationId: json['reservationId'],
      performanceTitle: json['performanceTitle'],
      performanceDate: DateTime.parse(json['performanceDate']),
      userNickName: json['userNickName'],
      userEmail: json['userEmail'],
      ticketOptionName: json['ticketOptionName'],
      ticketPrice: json['ticketPrice'],
      count: json['count'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      regDate: DateTime.parse(json['regDate']),
    );
  }
}
