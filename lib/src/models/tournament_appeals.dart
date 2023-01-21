import 'dart:convert';

import 'tournament_results.dart';

class TournamentAppeals {
  TournamentAppeals({
    required this.id,
    required this.idTournament,
    required this.type,
    required this.issuedAt,
    required this.status,
    required this.appeal,
    required this.comment,
    required this.overriddenBy,
    required this.questionNumber,
    required this.answer,
  });

  final int id;
  final int idTournament;
  final AppealType type;
  final DateTime? issuedAt;
  final QuestionStatus status;
  final String? appeal;
  final String? comment;
  final int? overriddenBy;
  final int questionNumber;
  final String? answer;

  TournamentAppeals copyWith({
    required int id,
    required int idTournament,
    required AppealType type,
    required DateTime? issuedAt,
    required QuestionStatus status,
    required String? appeal,
    required String? comment,
    required int? overriddenBy,
    required int questionNumber,
    required String? answer,
  }) =>
      TournamentAppeals(
        id: id,
        idTournament: idTournament,
        type: type,
        issuedAt: issuedAt ?? this.issuedAt,
        status: status,
        appeal: appeal ?? this.appeal,
        comment: comment ?? this.comment,
        overriddenBy: overriddenBy ?? this.overriddenBy,
        questionNumber: questionNumber,
        answer: answer ?? this.answer,
      );

  factory TournamentAppeals.fromRawJson(String str) =>
      TournamentAppeals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TournamentAppeals.fromJson(Map<String, dynamic> json) =>
      TournamentAppeals(
        id: json["id"],
        idTournament: json["idtournament"],
        type: typeValues.map[json["type"]]!,
        issuedAt:
            json["issuedAt"] != null ? DateTime.parse(json["issuedAt"]) : null,
        status: statusValues.map[json["status"]]!,
        appeal: json["appeal"],
        comment: json["comment"],
        overriddenBy: json["overriddenBy"],
        questionNumber: json["questionNumber"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idtournament": idTournament,
        "type": typeValues.reverse[type],
        "issuedAt": issuedAt?.toIso8601String(),
        "status": statusValues.reverse[status],
        "appeal": appeal,
        "comment": comment,
        "overriddenBy": overriddenBy,
        "questionNumber": questionNumber,
        "answer": answer,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentAppeals &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          idTournament == other.idTournament &&
          type == other.type &&
          issuedAt == other.issuedAt &&
          status == other.status &&
          appeal == other.appeal &&
          comment == other.comment &&
          overriddenBy == other.overriddenBy &&
          questionNumber == other.questionNumber &&
          answer == other.answer;

  @override
  int get hashCode =>
      id.hashCode ^
      idTournament.hashCode ^
      type.hashCode ^
      issuedAt.hashCode ^
      status.hashCode ^
      appeal.hashCode ^
      comment.hashCode ^
      overriddenBy.hashCode ^
      questionNumber.hashCode ^
      answer.hashCode;

  @override
  String toString() {
    return 'TournamentAppeals{id: $id, idTournament: $idTournament, type: $type, issuedAt: $issuedAt, status: $status, appeal: $appeal, comment: $comment, overriddenBy: $overriddenBy, questionNumber: $questionNumber, answer: $answer}';
  }
}

enum AppealType { A, R, N }

final EnumValues<AppealType> typeValues =
    EnumValues<AppealType>(<String, AppealType>{
  "A": AppealType.A, // Accepted
  "R": AppealType.R, // Rejected
  "N": AppealType.N, // Narrator mistake
});
