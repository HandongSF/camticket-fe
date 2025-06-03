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
