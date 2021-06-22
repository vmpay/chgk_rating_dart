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
    this.idteam,
    this.idseason,
    this.tournaments,
  });

  final int? idteam;
  final int? idseason;
  final List<String>? tournaments;

  factory TeamTournament.fromJson(String str) =>
      TeamTournament.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamTournament.fromMap(Map<String, dynamic> json) => TeamTournament(
        idteam: json["idteam"] == null ? null : json["idteam"],
        idseason: json["idseason"] == null ? null : json["idseason"],
        tournaments: json["tournaments"] == null
            ? null
            : List<String>.from(json["tournaments"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "idteam": idteam == null ? null : idteam,
        "idseason": idseason == null ? null : idseason,
        "tournaments": tournaments == null ? null : tournaments,
      };

  @override
  String toString() {
    return 'TeamTournament{idteam: $idteam, idseason: $idseason, tournaments: $tournaments}';
  }
}
