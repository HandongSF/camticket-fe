class ArtistManager {
  final int userId;
  final String nickName;
  final String profileImageUrl;

  ArtistManager({
    required this.userId,
    required this.nickName,
    required this.profileImageUrl,
  });

  factory ArtistManager.fromJson(Map<String, dynamic> json) {
    return ArtistManager(
      userId: json['userId'],
      nickName: json['nickName'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
