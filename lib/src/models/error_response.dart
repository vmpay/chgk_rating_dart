import 'dart:convert';

// TODO parse errors
class ErrorResponse {
  ErrorResponse({
    required this.type,
    required this.title,
    required this.detail,
  });

  final String type;
  final String title;
  final String detail;

  ErrorResponse copyWith({
    required String type,
    required String title,
    required String detail,
  }) =>
      ErrorResponse(
        type: type,
        title: title,
        detail: detail,
      );

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        type: json["type"],
        title: json["title"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "detail": detail,
      };
}
