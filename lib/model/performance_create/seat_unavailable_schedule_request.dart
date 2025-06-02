class SeatUnavailableScheduleRequest {
  final int scheduleIndex;
  final List<String> codes;

  SeatUnavailableScheduleRequest({
    required this.scheduleIndex,
    required this.codes,
  });

  Map<String, dynamic> toJson() => {
        'scheduleIndex': scheduleIndex,
        'codes': codes,
      };
}
