class ArtistPerformance {
  final int postId;
  final String profileImageUrl;

  ArtistPerformance({
    required this.postId,
    required this.profileImageUrl,
  });

  factory ArtistPerformance.fromJson(Map<String, dynamic> json) {
    return ArtistPerformance(
      postId: json['postId'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
