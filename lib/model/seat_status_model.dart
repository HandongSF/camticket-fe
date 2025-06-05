class SeatStatus {
  final String seatCode;
  final String status;
  final bool selected;

  SeatStatus({
    required this.seatCode,
    required this.status,
    required this.selected,
  });

  factory SeatStatus.fromJson(Map<String, dynamic> json) {
    return SeatStatus(
      seatCode: json['seatCode'],
      status: json['status'],
      selected: json['selected'],
    );
  }
}
