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

class ReservationRequest {
  final int performancePostId;
  final int performanceScheduleId;
  final List<String> selectedSeatCodes;
  final String userBankAccount;
  final List<TicketOrder> ticketOrders;
  final bool isPaymentCompleted;

  ReservationRequest({
    required this.performancePostId,
    required this.performanceScheduleId,
    required this.selectedSeatCodes,
    required this.userBankAccount,
    required this.ticketOrders,
    required this.isPaymentCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'performancePostId': performancePostId,
      'performanceScheduleId': performanceScheduleId,
      'selectedSeatCodes': selectedSeatCodes,
      'userBankAccount': userBankAccount,
      'ticketOrders': ticketOrders.map((e) => e.toJson()).toList(),
      'paymentCompleted': isPaymentCompleted,
    };
  }
}

class TicketOrder {
  final int ticketOptionId;
  final int count;
  final int unitPrice;

  TicketOrder({
    required this.ticketOptionId,
    required this.count,
    required this.unitPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketOptionId': ticketOptionId,
      'count': count,
      'unitPrice': unitPrice,
    };
  }
}
