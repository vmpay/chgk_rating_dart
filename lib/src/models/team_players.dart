import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
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
/// "captain": "2027"
/// }
/// ```
@immutable
class TeamPlayers {
  const TeamPlayers({
    this.idTeam,
    this.idSeason,
    this.players,
    this.captain,
  });

  final int? idTeam;
  final int? idSeason;
  final List<String>? players;
  final String? captain;

  /// Decodes [TeamPlayers] object from json string
  factory TeamPlayers.fromJson(String str) =>
      TeamPlayers.fromMap(json.decode(str));

  /// Encodes [TeamPlayers] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TeamPlayers] object from json map
  factory TeamPlayers.fromMap(Map<String, dynamic> json) => TeamPlayers(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        idSeason: json['idseason'] == null ? null : json['idseason'],
        players: json['players'] == null
            ? null
            : List<String>.from(json['players'].map((x) => x)),
        // TODO false means null
        captain: json['captain'] == null ? null : json['captain'].toString(),
      );

  /// Encodes [TeamPlayers] object to json map
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamPlayers &&
          runtimeType == other.runtimeType &&
          idTeam == other.idTeam &&
          idSeason == other.idSeason &&
          players == other.players &&
          captain == other.captain;

  @override
  int get hashCode =>
      idTeam.hashCode ^ idSeason.hashCode ^ players.hashCode ^ captain.hashCode;
}
