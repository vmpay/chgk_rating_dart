import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// [
/// {
///     "question_number": "6",
///     "answer": "Росвелл",
///     "issued_at": "2017-07-19 17:28:11",
///     "status": "A",
///     "comment": null,
///     "resolved_at": "2017-07-25 09:52:04",
///     "appeal_jury_comment": "Комментарий"
/// },
/// {
///     "question_number": "33",
///     "answer": "теплое течение",
///     "issued_at": "2017-07-19 17:28:11",
///     "status": "D",
///     "comment": null,
///     "resolved_at": "2017-07-25 09:57:30",
///     "appeal_jury_comment": "Комментарий"
/// }
/// ]
/// ```
@immutable
class TournamentControversial {
  const TournamentControversial({
    this.questionNumber,
    this.answer,
    this.issuedAt,
    this.status,
    this.comment,
    this.resolvedAt,
    this.appealJuryComment,
  });

  final String? questionNumber;
  final String? answer;
  final DateTime? issuedAt;
  final QuestionStatus? status;
  final String? comment;
  final DateTime? resolvedAt;
  final String? appealJuryComment;

  /// Decodes [TournamentControversial] object from json string
  factory TournamentControversial.fromJson(String str) =>
      TournamentControversial.fromMap(json.decode(str));

  /// Encodes [TournamentControversial] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentControversial] object from json map
  factory TournamentControversial.fromMap(Map<String, dynamic> json) =>
      TournamentControversial(
        questionNumber:
            json['question_number'] == null ? null : json['question_number'],
        answer: json['answer'] == null ? null : json['answer'],
        issuedAt: json['issued_at'] == null
            ? null
            : DateTime.parse(json['issued_at']),
        status:
            json['status'] == null ? null : statusValues.map[json['status']],
        comment: json['comment'] == null ? null : json['comment'],
        resolvedAt: json['resolved_at'] == null
            ? null
            : DateTime.parse(json['resolved_at']),
        appealJuryComment: json['appeal_jury_comment'] == null
            ? null
            : json['appeal_jury_comment'],
      );

  /// Encodes [TournamentControversial] object to json map
  Map<String, dynamic> toMap() => {
        'question_number': questionNumber == null ? null : questionNumber,
        'answer': answer == null ? null : answer,
        'issued_at': issuedAt == null ? null : issuedAt?.toIso8601String(),
        'status': status == null ? null : statusValues.reverse[status],
        'comment': comment == null ? null : comment,
        'resolved_at':
            resolvedAt == null ? null : resolvedAt?.toIso8601String(),
        'appeal_jury_comment':
            appealJuryComment == null ? null : appealJuryComment,
      };

  @override
  String toString() {
    return 'TournamentControversial{questionNumber: $questionNumber, answer: $answer, issuedAt: $issuedAt, status: $status, comment: $comment, resolvedAt: $resolvedAt, appealJuryComment: $appealJuryComment}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentControversial &&
          runtimeType == other.runtimeType &&
          questionNumber == other.questionNumber &&
          answer == other.answer &&
          issuedAt == other.issuedAt &&
          status == other.status &&
          comment == other.comment &&
          resolvedAt == other.resolvedAt &&
          appealJuryComment == other.appealJuryComment;

  @override
  int get hashCode =>
      questionNumber.hashCode ^
      answer.hashCode ^
      issuedAt.hashCode ^
      status.hashCode ^
      comment.hashCode ^
      resolvedAt.hashCode ^
      appealJuryComment.hashCode;
}

/// [A] - approved, [D] - declined, [N] - new
enum QuestionStatus { A, D, N }

/// [QuestionStatus.A] - approved, [QuestionStatus.D] - declined, [QuestionStatus.N] - new
final EnumValues<QuestionStatus> statusValues = EnumValues<QuestionStatus>(
    {'A': QuestionStatus.A, 'D': QuestionStatus.D, 'N': QuestionStatus.N});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((String k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
