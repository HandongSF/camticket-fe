class ManageOverview {
  final int postId;
  final String lastScheduleTime;
  final String profileImageUrl;

  ManageOverview({
    required this.postId,
    required this.lastScheduleTime,
    required this.profileImageUrl,
  });

  factory ManageOverview.fromJson(Map<String, dynamic> json) {
    return ManageOverview(
      postId: json['postId'] ?? 0,
      lastScheduleTime: json['lastScheduleTime'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }
  DateTime get lastScheduleDateTime {
    final time = lastScheduleTime;
    return DateTime.parse(time.length == 16 ? '$time:00' : time);
  }
}
