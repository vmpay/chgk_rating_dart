import 'dart:convert';

class TokenRequest {
  TokenRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  TokenRequest copyWith({
    required String email,
    required String password,
  }) =>
      TokenRequest(
        email: email,
        password: password,
      );

  factory TokenRequest.fromRawJson(String str) =>
      TokenRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenRequest.fromJson(Map<String, dynamic> json) => TokenRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenRequest &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password;

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'TokenRequest{email: $email, password: $password}';
  }
}
