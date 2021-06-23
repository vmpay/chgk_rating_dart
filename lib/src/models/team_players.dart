/// Response example:
/// {
/// "idteam": 58380,
/// "idseason": 54,
/// "players": [
///     "2027",
///     "17579",
///     "71714",
///     "106446",
///     "128496"
/// ],
/// "captain": false
/// }
import 'dart:convert';

class TeamPlayers {
  TeamPlayers({
    this.idTeam,
    this.idSeason,
    this.players,
    this.captain,
  });

  final int? idTeam;
  final int? idSeason;
  final List<String>? players;
  final String? captain;

  factory TeamPlayers.fromJson(String str) =>
      TeamPlayers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamPlayers.fromMap(Map<String, dynamic> json) => TeamPlayers(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        idSeason: json['idseason'] == null ? null : json['idseason'],
        players: json['players'] == null
            ? null
            : List<String>.from(json['players'].map((x) => x)),
        // TODO false means null
        captain: json['captain'] == null ? null : json['captain'].toString(),
      );

  Map<String, dynamic> toMap() => {
        'idteam': idTeam == null ? null : idTeam,
        'idseason': idSeason == null ? null : idSeason,
        'players': players == null ? null : players,
        'captain': captain == null ? null : captain,
      };

  @override
  String toString() {
    return 'TeamPlayers{idTeam: $idTeam, idSeason: $idSeason, players: $players, captain: $captain}';
  }
}
