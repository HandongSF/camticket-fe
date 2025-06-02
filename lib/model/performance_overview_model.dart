class PerformanceOverview {
  final int postId;
  final String title;
  final String profileImageUrl;
  final DateTime reservationStartAt;
  final DateTime reservationEndAt;
  final DateTime firstScheduleStartTime;
  final String location;
  final int userId;
  final String category;
  final bool closed;

  String? profileImageUrl2; // 동적으로 추가될 필드

  PerformanceOverview({
    required this.postId,
    required this.title,
    required this.profileImageUrl,
    required this.reservationStartAt,
    required this.reservationEndAt,
    required this.firstScheduleStartTime,
    required this.location,
    required this.userId,
    required this.category,
    required this.closed,
    this.profileImageUrl2,
  });

  factory PerformanceOverview.fromJson(Map<String, dynamic> json) {
    return PerformanceOverview(
      postId: json['postId'],
      title: json['title'],
      profileImageUrl: json['profileImageUrl'],
      reservationStartAt: DateTime.parse(json['reservationStartAt']),
      reservationEndAt: DateTime.parse(json['reservationEndAt']),
      firstScheduleStartTime: DateTime.parse(json['firstScheduleStartTime']),
      location: json['location'],
      userId: json['userId'],
      category: json['category'],
      closed: json['closed'],
    );
  }
}
