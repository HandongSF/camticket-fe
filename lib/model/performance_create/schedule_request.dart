class ScheduleRequest {
  final DateTime date;
  final List<String> rounds;

  ScheduleRequest({
    required this.date,
    required this.rounds,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'rounds': rounds,
      };
}
