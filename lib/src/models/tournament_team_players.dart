import 'dart:convert';

/// Response example:
/// ```json
/// {
/// "idteam": "58380",
/// "recaps": [
///     {
///         "idplayer": "2027",
///         "is_captain": "1",
///         "is_base": "1",
///         "is_foreign": "0"
///     },
///     {
///         "idplayer": "68445",
///         "is_captain": "0",
///         "is_base": "1",
///         "is_foreign": "0"
///     },
///     {
///         "idplayer": "71714",
///         "is_captain": "0",
///         "is_base": "1",
///         "is_foreign": "0"
///     },
///     {
///         "idplayer": "79847",
///         "is_captain": "0",
///         "is_base": "1",
///         "is_foreign": "0"
///     },
///     {
///         "idplayer": "106446",
///         "is_captain": "0",
///         "is_base": "0",
///         "is_foreign": "1"
///     },
///     {
///         "idplayer": "147205",
///         "is_captain": "0",
///         "is_base": "1",
///         "is_foreign": "0"
///     }
/// ]
/// }
/// ```
class TournamentTeam {
  TournamentTeam({
    this.idTeam,
    this.recaps,
  });

  final String? idTeam;
  final List<TournamentTeamPlayer>? recaps;

  /// Decodes [TournamentTeam] object from json string
  factory TournamentTeam.fromJson(String str) =>
      TournamentTeam.fromMap(json.decode(str));

  /// Encodes [TournamentTeam] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentTeam] object from json map
  factory TournamentTeam.fromMap(Map<String, dynamic> json) => TournamentTeam(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        recaps: json['recaps'] == null
            ? null
            : List<TournamentTeamPlayer>.from(
                json['recaps'].map((x) => TournamentTeamPlayer.fromMap(x))),
      );

  /// Encodes [TournamentTeam] object to json map
  Map<String, dynamic> toMap() => {
        'idteam': idTeam == null ? null : idTeam,
        'recaps': recaps == null ? null : recaps,
      };

  @override
  String toString() {
    return 'TournamentTeamPlayers{idTeam: $idTeam, recaps: $recaps}';
  }
}

/// Response example:
/// ```json
/// {
/// "idplayer": "68445",
/// "is_captain": "0",
/// "is_base": "1",
/// "is_foreign": "0"
/// }
/// ```
class TournamentTeamPlayer {
  TournamentTeamPlayer({
    this.idPlayer,
    this.isCaptain,
    this.isBase,
    this.isForeign,
  });

  final String? idPlayer;
  final String? isCaptain;
  final String? isBase;
  final String? isForeign;

  /// Decodes [TournamentTeamPlayer] object from json string
  factory TournamentTeamPlayer.fromJson(String str) =>
      TournamentTeamPlayer.fromMap(json.decode(str));

  /// Encodes [TournamentTeamPlayer] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentTeamPlayer] object from json map
  factory TournamentTeamPlayer.fromMap(Map<String, dynamic> json) =>
      TournamentTeamPlayer(
        idPlayer: json['idplayer'] == null ? null : json['idplayer'],
        isCaptain: json['is_captain'] == null ? null : json['is_captain'],
        isBase: json['is_base'] == null ? null : json['is_base'],
        isForeign: json['is_foreign'] == null ? null : json['is_foreign'],
      );

  /// Encodes [TournamentTeamPlayer] object to json map
  Map<String, dynamic> toMap() => {
        'idplayer': idPlayer == null ? null : idPlayer,
        'is_captain': isCaptain == null ? null : isCaptain,
        'is_base': isBase == null ? null : isBase,
        'is_foreign': isForeign == null ? null : isForeign,
      };

  @override
  String toString() {
    return 'TournamentTeamPlayer{idPlayer: $idPlayer, isCaptain: $isCaptain, isBase: $isBase, isForeign: $isForeign}';
  }
}
