import 'dart:convert';

/// Error response example:
/// ```json
/// {
///   "type": "https://tools.ietf.org/html/rfc2616#section-10",
///   "title": "An error occurred",
///   "detail": "Not Found"
/// }
/// ```
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorResponse &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          title == other.title &&
          detail == other.detail;

  @override
  int get hashCode => type.hashCode ^ title.hashCode ^ detail.hashCode;

  @override
  String toString() {
    return 'ErrorResponse{type: $type, title: $title, detail: $detail}';
  }
}
