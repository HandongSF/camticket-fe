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
