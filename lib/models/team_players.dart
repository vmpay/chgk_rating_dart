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
    this.idteam,
    this.idseason,
    this.players,
    this.captain,
  });

  final int? idteam;
  final int? idseason;
  final List<String>? players;
  final String? captain;

  factory TeamPlayers.fromJson(String str) =>
      TeamPlayers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamPlayers.fromMap(Map<String, dynamic> json) => TeamPlayers(
        idteam: json["idteam"] == null ? null : json["idteam"],
        idseason: json["idseason"] == null ? null : json["idseason"],
        players: json["players"] == null
            ? null
            : List<String>.from(json["players"].map((x) => x)),
        // TODO false means null
        captain: json["captain"] == null ? null : json["captain"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "idteam": idteam == null ? null : idteam,
        "idseason": idseason == null ? null : idseason,
        "players": players == null ? null : players,
        "captain": captain == null ? null : captain,
      };

  @override
  String toString() {
    return 'TeamPlayers{idteam: $idteam, idseason: $idseason, players: $players, captain: $captain}';
  }
}
