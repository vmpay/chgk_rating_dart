import 'dart:convert';

class TokenResponse {
  TokenResponse({
    required this.token,
  });

  final String token;

  TokenResponse copyWith({
    required String token,
  }) =>
      TokenResponse(
        token: token,
      );

  factory TokenResponse.fromRawJson(String str) =>
      TokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenResponse &&
          runtimeType == other.runtimeType &&
          token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() {
    return 'TokenResponse{token: $token}';
  }
}
