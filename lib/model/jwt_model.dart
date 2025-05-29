class JwtToken {
  final int userId;
  final String tokenType;
  final int iat;
  final int exp;

  JwtToken({
    required this.userId,
    required this.tokenType,
    required this.iat,
    required this.exp,
  });

  factory JwtToken.fromDecodedToken(Map<String, dynamic> decoded) {
    return JwtToken(
      userId: decoded['userId'],
      tokenType: decoded['tokenType'],
      iat: decoded['iat'],
      exp: decoded['exp'],
    );
  }
}
