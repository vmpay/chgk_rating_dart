/// Response example:
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
import 'dart:convert';

class TeamTournament {
  TeamTournament({
    this.idTeam,
    this.idSeason,
    this.tournaments,
  });

  final int? idTeam;
  final int? idSeason;
  final List<String>? tournaments;

  factory TeamTournament.fromJson(String str) =>
      TeamTournament.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamTournament.fromMap(Map<String, dynamic> json) => TeamTournament(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        idSeason: json['idseason'] == null ? null : json['idseason'],
        tournaments: json['tournaments'] == null
            ? null
            : List<String>.from(json['tournaments'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'idteam': idTeam == null ? null : idTeam,
        'idseason': idSeason == null ? null : idSeason,
        'tournaments': tournaments == null ? null : tournaments,
      };

  @override
  String toString() {
    return 'TeamTournament{idTeam: $idTeam, idSeason: $idSeason, tournaments: $tournaments}';
  }
}
