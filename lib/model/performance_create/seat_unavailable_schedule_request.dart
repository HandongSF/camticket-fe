class SeatUnavailableScheduleRequest {
  final DateTime date;
  final String round;
  final List<String> seatIds;

  SeatUnavailableScheduleRequest({
    required this.date,
    required this.round,
    required this.seatIds,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'round': round,
        'seatIds': seatIds,
      };
}
