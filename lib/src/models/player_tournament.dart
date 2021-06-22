/// Response example:
/// {
/// "idplayer": 147205,
/// "idseason": 54,
/// "tournaments": [
///     {
///         "idtournament": "6035",
///         "idteam": "58380",
///         "in_base_team": "0"
///     },
///     {
///         "idtournament": "7110",
///         "idteam": "58380",
///         "in_base_team": "0"
///     },
///     {
///         "idtournament": "7099",
///         "idteam": "58380",
///         "in_base_team": "0"
///     },
///     {
///         "idtournament": "6143",
///         "idteam": "58380",
///         "in_base_team": "0"
///     },
///     {
///         "idtournament": "6273",
///         "idteam": "58380",
///         "in_base_team": "0"
///     },
///     {
///         "idtournament": "6925",
///         "idteam": "58380",
///         "in_base_team": "0"
///     }
/// ]
/// }
import 'dart:convert';

class PlayerTournamentResponse {
  PlayerTournamentResponse({
    this.idplayer,
    this.idseason,
    this.tournaments,
  });

  final int? idplayer;
  final String? idseason;
  final List<PlayerTournament>? tournaments;

  factory PlayerTournamentResponse.fromJson(String str) =>
      PlayerTournamentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerTournamentResponse.fromMap(Map<String, dynamic> json) =>
      PlayerTournamentResponse(
        idplayer: json["idplayer"] == null ? null : json["idplayer"],
        idseason: json["idseason"] == null ? null : json["idseason"].toString(),
        tournaments: json["tournaments"] == null
            ? null
            : List<PlayerTournament>.from(
                json["tournaments"].map((x) => PlayerTournament.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idplayer": idplayer == null ? null : idplayer,
        "idseason": idseason == null ? null : idseason,
        "tournaments": tournaments == null ? null : tournaments,
      };

  @override
  String toString() {
    return 'PlayerTournamentResponse{idplayer: $idplayer, idseason: $idseason, tournaments: $tournaments}';
  }
}

class PlayerTournament {
  PlayerTournament({
    this.idtournament,
    this.idteam,
    this.inBaseTeam,
  });

  final String? idtournament;
  final String? idteam;
  final String? inBaseTeam;

  factory PlayerTournament.fromJson(String str) =>
      PlayerTournament.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerTournament.fromMap(Map<String, dynamic> json) =>
      PlayerTournament(
        idtournament:
            json["idtournament"] == null ? null : json["idtournament"],
        idteam: json["idteam"] == null ? null : json["idteam"],
        inBaseTeam: json["in_base_team"] == null ? null : json["in_base_team"],
      );

  Map<String, dynamic> toMap() => {
        "idtournament": idtournament == null ? null : idtournament,
        "idteam": idteam == null ? null : idteam,
        "in_base_team": inBaseTeam == null ? null : inBaseTeam,
      };

  @override
  String toString() {
    return 'PlayerTournament{idtournament: $idtournament, idteam: $idteam, inBaseTeam: $inBaseTeam}';
  }
}
