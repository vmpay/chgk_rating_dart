import 'dart:convert';

/// Response example:
/// ```json
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
///     }
/// ]
/// }
/// ```
class PlayerTournamentResponse {
  PlayerTournamentResponse({
    this.idPlayer,
    this.idSeason,
    this.tournaments,
  });

  final int? idPlayer;
  final String? idSeason;
  final List<PlayerTournament>? tournaments;

  /// Decodes [PlayerTournamentResponse] object from json string
  factory PlayerTournamentResponse.fromJson(String str) =>
      PlayerTournamentResponse.fromMap(json.decode(str));

  /// Encodes [PlayerTournamentResponse] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [PlayerTournamentResponse] object from json map
  factory PlayerTournamentResponse.fromMap(Map<String, dynamic> json) =>
      PlayerTournamentResponse(
        idPlayer: json['idplayer'] == null ? null : json['idplayer'],
        idSeason: json['idseason'] == null ? null : json['idseason'].toString(),
        tournaments: json['tournaments'] == null
            ? null
            : List<PlayerTournament>.from(
                json['tournaments'].map((x) => PlayerTournament.fromMap(x))),
      );

  /// Encodes [PlayerTournamentResponse] object to json map
  Map<String, dynamic> toMap() => {
        'idplayer': idPlayer == null ? null : idPlayer,
        'idseason': idSeason == null ? null : idSeason,
        'tournaments': tournaments == null ? null : tournaments,
      };

  @override
  String toString() {
    return 'PlayerTournamentResponse{idPlayer: $idPlayer, idSeason: $idSeason, tournaments: $tournaments}';
  }
}

/// Response example:
/// ```json
/// {
/// "idtournament": "6035",
/// "idteam": "58380",
/// "in_base_team": "0"
/// }
/// ```
class PlayerTournament {
  PlayerTournament({
    required this.idTournament,
    this.idTeam,
    this.inBaseTeam,
  });

  final String idTournament;
  final String? idTeam;
  final String? inBaseTeam;

  /// Decodes [PlayerTournament] object from json string
  factory PlayerTournament.fromJson(String str) =>
      PlayerTournament.fromMap(json.decode(str));

  /// Encodes [PlayerTournament] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [PlayerTournament] object from json map
  factory PlayerTournament.fromMap(Map<String, dynamic> json) =>
      PlayerTournament(
        idTournament:
            json['idtournament'] == null ? 'null' : json['idtournament'],
        idTeam: json['idteam'] == null ? null : json['idteam'],
        inBaseTeam: json['in_base_team'] == null ? null : json['in_base_team'],
      );

  /// Encodes [PlayerTournament] object to json map
  Map<String, dynamic> toMap() => {
        'idtournament': idTournament == null ? 'null' : idTournament,
        'idteam': idTeam == null ? null : idTeam,
        'in_base_team': inBaseTeam == null ? null : inBaseTeam,
      };

  @override
  String toString() {
    return 'PlayerTournament{idTournament: $idTournament, idTeam: $idTeam, inBaseTeam: $inBaseTeam}';
  }
}
