class ReservationData {
  final int reservationId;
  final String performanceTitle;
  final DateTime performanceDate;
  final String userNickName;
  final String userEmail;
  final String ticketOptionName;
  final int ticketPrice;
  final int count;
  final int totalPrice;
  final String status;
  final List<String> selectedSeats;
  final DateTime regDate;

  ReservationData({
    required this.reservationId,
    required this.performanceTitle,
    required this.performanceDate,
    required this.userNickName,
    required this.userEmail,
    required this.ticketOptionName,
    required this.ticketPrice,
    required this.count,
    required this.totalPrice,
    required this.status,
    required this.selectedSeats,
    required this.regDate,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      reservationId: json['reservationId'],
      performanceTitle: json['performanceTitle'],
      performanceDate: DateTime.parse(json['performanceDate']),
      userNickName: json['userNickName'],
      userEmail: json['userEmail'],
      ticketOptionName: json['ticketOptionName'],
      ticketPrice: json['ticketPrice'],
      count: json['count'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      regDate: DateTime.parse(json['regDate']),
    );
  }
}
