class User {
  final int? id;
  final int? kakaoId;
  final String? name;
  final String? nickName;
  final String? email;
  final String? profileImageUrl;
  final String? introduction;
  final String? bankAccount;
  final String role;

  User({
    this.id,
    this.kakaoId,
    this.name,
    this.nickName,
    this.email,
    this.profileImageUrl,
    this.introduction,
    this.bankAccount,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      kakaoId: json['kakaoId'],
      name: json['name'],
      nickName: json['nickName'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      introduction: json['introduction'],
      bankAccount: json['bankAccount'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kakaoId': kakaoId,
      'name': name,
      'nickName': nickName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'introduction': introduction,
      'bankAccount': bankAccount,
      'role': role,
    };
  }
}
