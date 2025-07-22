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

class PerformanceDetail {
  final int id;
  final String title;
  final String category;
  final String location;
  final String ticketType;
  final int maxTicketsPerUser;
  final String backAccount;
  final String reservationStartAt;
  final String reservationEndAt;
  final String timeNotice;
  final String priceNotice;
  final String reservationNotice;
  final String profileImageUrl;
  final List<String> detailImageUrls;
  final List<Schedule> schedules;
  final List<SeatUnavailable> seatUnavailableCodesPerSchedule;
  final List<TicketOption> ticketOptions;

  PerformanceDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.ticketType,
    required this.maxTicketsPerUser,
    required this.backAccount,
    required this.reservationStartAt,
    required this.reservationEndAt,
    required this.timeNotice,
    required this.priceNotice,
    required this.reservationNotice,
    required this.profileImageUrl,
    required this.detailImageUrls,
    required this.schedules,
    required this.seatUnavailableCodesPerSchedule,
    required this.ticketOptions,
  });

  factory PerformanceDetail.fromJson(Map<String, dynamic> json) {
    return PerformanceDetail(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      location: json['location'],
      ticketType: json['ticketType'],
      maxTicketsPerUser: json['maxTicketsPerUser'],
      backAccount: json['backAccount'],
      reservationStartAt: json['reservationStartAt'],
      reservationEndAt: json['reservationEndAt'],
      timeNotice: json['timeNotice'],
      priceNotice: json['priceNotice'],
      reservationNotice: json['reservationNotice'],
      profileImageUrl: json['profileImageUrl'],
      detailImageUrls: List<String>.from(json['detailImageUrls']),
      schedules:
          (json['schedules'] as List).map((e) => Schedule.fromJson(e)).toList(),
      seatUnavailableCodesPerSchedule:
          (json['seatUnavailableCodesPerSchedule'] as List)
              .map((e) => SeatUnavailable.fromJson(e))
              .toList(),
      ticketOptions: (json['ticketOptions'] as List)
          .map((e) => TicketOption.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'location': location,
        'ticketType': ticketType,
        'maxTicketsPerUser': maxTicketsPerUser,
        'backAccount': backAccount,
        'reservationStartAt': reservationStartAt,
        'reservationEndAt': reservationEndAt,
        'timeNotice': timeNotice,
        'priceNotice': priceNotice,
        'reservationNotice': reservationNotice,
        'profileImageUrl': profileImageUrl,
        'detailImageUrls': detailImageUrls,
        'schedules': schedules.map((e) => e.toJson()).toList(),
        'seatUnavailableCodesPerSchedule':
            seatUnavailableCodesPerSchedule.map((e) => e.toJson()).toList(),
        'ticketOptions': ticketOptions.map((e) => e.toJson()).toList(),
      };
}

class Schedule {
  final int scheduleIndex;
  final String startTime;

  Schedule({
    required this.scheduleIndex,
    required this.startTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleIndex: json['scheduleIndex'],
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'scheduleIndex': scheduleIndex,
        'startTime': startTime,
      };
}

class SeatUnavailable {
  final int scheduleIndex;
  final List<String> codes;

  SeatUnavailable({
    required this.scheduleIndex,
    required this.codes,
  });

  factory SeatUnavailable.fromJson(Map<String, dynamic> json) {
    return SeatUnavailable(
      scheduleIndex: json['scheduleIndex'],
      codes: List<String>.from(json['codes']),
    );
  }

  Map<String, dynamic> toJson() => {
        'scheduleIndex': scheduleIndex,
        'codes': codes,
      };
}

class TicketOption {
  final String name;
  final int price;

  TicketOption({
    required this.name,
    required this.price,
  });

  factory TicketOption.fromJson(Map<String, dynamic> json) {
    return TicketOption(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
      };
}
