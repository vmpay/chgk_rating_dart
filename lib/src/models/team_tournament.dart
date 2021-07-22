import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idteam": 58380,
/// "idseason": 54,
/// "tournaments": [
///     "6035",
///     "7110",
///     "7099",
///     "6143",
///     "6283",
///     "6273",
///     "6925",
///     "6866",
///     "6278",
///     "6676"
/// ]
/// }
/// ```
@immutable
class TeamTournament {
  const TeamTournament({
    this.idTeam,
    this.idSeason,
    this.tournaments,
  });

  final int? idTeam;
  final int? idSeason;
  final List<String>? tournaments;

  /// Decodes [TeamTournament] object from json string
  factory TeamTournament.fromJson(String str) =>
      TeamTournament.fromMap(json.decode(str));

  /// Encodes [TeamTournament] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TeamTournament] object from json map
  factory TeamTournament.fromMap(Map<String, dynamic> json) => TeamTournament(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        idSeason: json['idseason'] == null ? null : json['idseason'],
        tournaments: json['tournaments'] == null
            ? null
            : List<String>.from(json['tournaments'].map((x) => x)),
      );

  /// Encodes [TeamTournament] object from json map
  Map<String, dynamic> toMap() => {
        'idteam': idTeam == null ? null : idTeam,
        'idseason': idSeason == null ? null : idSeason,
        'tournaments': tournaments == null ? null : tournaments,
      };

  @override
  String toString() {
    return 'TeamTournament{idTeam: $idTeam, idSeason: $idSeason, tournaments: $tournaments}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamTournament &&
          runtimeType == other.runtimeType &&
          idTeam == other.idTeam &&
          idSeason == other.idSeason &&
          tournaments == other.tournaments;

  @override
  int get hashCode =>
      idTeam.hashCode ^ idSeason.hashCode ^ tournaments.hashCode;
}
