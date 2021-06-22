/// Response example:
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
import 'dart:convert';

class TournamentTeam {
  TournamentTeam({
    this.idteam,
    this.recaps,
  });

  final String? idteam;
  final List<TournamentTeamPlayer>? recaps;

  factory TournamentTeam.fromJson(String str) =>
      TournamentTeam.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TournamentTeam.fromMap(Map<String, dynamic> json) => TournamentTeam(
        idteam: json["idteam"] == null ? null : json["idteam"],
        recaps: json["recaps"] == null
            ? null
            : List<TournamentTeamPlayer>.from(
                json["recaps"].map((x) => TournamentTeamPlayer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idteam": idteam == null ? null : idteam,
        "recaps": recaps == null ? null : recaps,
      };

  @override
  String toString() {
    return 'TournamentTeamPlayers{idteam: $idteam, recaps: $recaps}';
  }
}

class TournamentTeamPlayer {
  TournamentTeamPlayer({
    this.idplayer,
    this.isCaptain,
    this.isBase,
    this.isForeign,
  });

  final String? idplayer;
  final String? isCaptain;
  final String? isBase;
  final String? isForeign;

  factory TournamentTeamPlayer.fromJson(String str) =>
      TournamentTeamPlayer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TournamentTeamPlayer.fromMap(Map<String, dynamic> json) =>
      TournamentTeamPlayer(
        idplayer: json["idplayer"] == null ? null : json["idplayer"],
        isCaptain: json["is_captain"] == null ? null : json["is_captain"],
        isBase: json["is_base"] == null ? null : json["is_base"],
        isForeign: json["is_foreign"] == null ? null : json["is_foreign"],
      );

  Map<String, dynamic> toMap() => {
        "idplayer": idplayer == null ? null : idplayer,
        "is_captain": isCaptain == null ? null : isCaptain,
        "is_base": isBase == null ? null : isBase,
        "is_foreign": isForeign == null ? null : isForeign,
      };

  @override
  String toString() {
    return 'TournamentTeamPlayer{idplayer: $idplayer, isCaptain: $isCaptain, isBase: $isBase, isForeign: $isForeign}';
  }
}
