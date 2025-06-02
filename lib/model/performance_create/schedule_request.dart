class ScheduleRequest {
  final int scheduleIndex;
  final DateTime startTime;

  ScheduleRequest({
    required this.scheduleIndex,
    required this.startTime,
  });

  Map<String, dynamic> toJson() => {
        'scheduleIndex': scheduleIndex,
        //'scheduleIndex': 0,
        'startTime': startTime.toIso8601String(),
        //'startTime': DateTime(1999, 1, 1, 0, 0, 0).toIso8601String(), // 임시값
      };
}
