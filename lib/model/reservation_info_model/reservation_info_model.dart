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

class ReservationDetailResponse {
  final int reservationId;
  final String status;
  final PerformanceInfo performanceInfo;
  final ReservationInfo reservationInfo;
  final SeatInfo seatInfo;
  final List<PaymentInfo> paymentInfo;
  final DateTime reservationDate;

  ReservationDetailResponse({
    required this.reservationId,
    required this.status,
    required this.performanceInfo,
    required this.reservationInfo,
    required this.seatInfo,
    required this.paymentInfo,
    required this.reservationDate,
  });

  factory ReservationDetailResponse.fromJson(Map<String, dynamic> json) =>
      ReservationDetailResponse(
        reservationId: json['reservationId'],
        status: json['status'],
        performanceInfo: PerformanceInfo.fromJson(json['performanceInfo']),
        reservationInfo: ReservationInfo.fromJson(json['reservationInfo']),
        seatInfo: SeatInfo.fromJson(json['seatInfo']),
        paymentInfo: (json['paymentInfo'] as List)
            .map((e) => PaymentInfo.fromJson(e))
            .toList(),
        reservationDate: DateTime.parse(json['reservationDate']),
      );
}

class ReservationInfo {
  final String userNickName;
  final String userBankAccount;
  final int ticketCount;
  final int totalPrice;
  final bool paymentCompleted;

  ReservationInfo({
    required this.userNickName,
    required this.userBankAccount,
    required this.ticketCount,
    required this.totalPrice,
    required this.paymentCompleted,
  });

  factory ReservationInfo.fromJson(Map<String, dynamic> json) =>
      ReservationInfo(
        userNickName: json['userNickName'],
        userBankAccount: json['userBankAccount'],
        ticketCount: json['ticketCount'],
        totalPrice: json['totalPrice'],
        paymentCompleted: json['paymentCompleted'],
      );
}

class PerformanceInfo {
  final String title;
  final String category;
  final String location;
  final DateTime performanceDate;
  final int scheduleId;
  final int scheduleIndex;
  final String profileImageUrl;

  PerformanceInfo({
    required this.title,
    required this.category,
    required this.location,
    required this.performanceDate,
    required this.scheduleId,
    required this.scheduleIndex,
    required this.profileImageUrl,
  });

  factory PerformanceInfo.fromJson(Map<String, dynamic> json) =>
      PerformanceInfo(
        title: json['title'],
        category: json['category'],
        location: json['location'],
        performanceDate: DateTime.parse(json['performanceDate']),
        scheduleId: json['scheduleId'],
        scheduleIndex: json['scheduleIndex'],
        profileImageUrl: json['profileImageUrl'],
      );
}

class SeatInfo {
  final String ticketType;
  final Set<String> selectedSeats;

  SeatInfo({
    required this.ticketType,
    required this.selectedSeats,
  });

  factory SeatInfo.fromJson(Map<String, dynamic> json) => SeatInfo(
        ticketType: json['ticketType'],
        selectedSeats: Set<String>.from(json['selectedSeats']),
      );
}

class PaymentInfo {
  final String ticketOptionName;
  final int unitPrice;
  final int quantity;
  final int subtotal;

  PaymentInfo({
    required this.ticketOptionName,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        ticketOptionName: json['ticketOptionName'],
        unitPrice: json['unitPrice'],
        quantity: json['quantity'],
        subtotal: json['subtotal'],
      );
}
