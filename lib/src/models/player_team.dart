import 'dart:convert';

/// Player team response example:
/// ```json
/// {
/// "idplayer": "147205",
/// "idteam": "58380",
/// "idseason": "50",
/// "is_captain": "0",
/// "added_since": "2017-04-21"
/// }
/// ```
class PlayerTeam {
  PlayerTeam({
    required this.idPlayer,
    required this.idSeason,
    required this.idTeam,
    required this.dateAdded,
    required this.dateRemoved,
    required this.playerNumber,
  });

  final int idPlayer;
  final int idSeason;
  final int idTeam;
  final DateTime? dateAdded;
  final DateTime? dateRemoved;
  final int playerNumber;

  PlayerTeam copyWith({
    required int idPlayer,
    required int idSeason,
    required int idTeam,
    required DateTime? dateAdded,
    required DateTime? dateRemoved,
    required int playerNumber,
  }) =>
      PlayerTeam(
        idPlayer: idPlayer,
        idSeason: idSeason,
        idTeam: idTeam,
        dateAdded: dateAdded ?? this.dateAdded,
        dateRemoved: dateRemoved ?? this.dateRemoved,
        playerNumber: playerNumber,
      );

  factory PlayerTeam.fromRawJson(String str) =>
      PlayerTeam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerTeam.fromJson(Map<String, dynamic> json) => PlayerTeam(
        idPlayer: json["idplayer"],
        idSeason: json["idseason"],
        idTeam: json["idteam"],
        dateAdded: json["dateAdded"] != null
            ? DateTime.parse(json["dateAdded"])
            : null,
        dateRemoved: json["dateRemoved"] != null
            ? DateTime.parse(json["dateRemoved"])
            : null,
        playerNumber: json["playerNumber"],
      );

  Map<String, dynamic> toJson() => {
        "idplayer": idPlayer,
        "idseason": idSeason,
        "idteam": idTeam,
        "dateAdded": dateAdded?.toIso8601String(),
        "dateRemoved": dateRemoved?.toIso8601String(),
        "playerNumber": playerNumber,
      };

  static Iterable<PlayerTeam> decodeList(List<dynamic> list) =>
      list.map((dynamic e) => PlayerTeam.fromJson(e));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerTeam &&
          runtimeType == other.runtimeType &&
          idPlayer == other.idPlayer &&
          idSeason == other.idSeason &&
          idTeam == other.idTeam &&
          dateAdded == other.dateAdded &&
          dateRemoved == other.dateRemoved &&
          playerNumber == other.playerNumber;

  @override
  int get hashCode =>
      idPlayer.hashCode ^
      idSeason.hashCode ^
      idTeam.hashCode ^
      dateAdded.hashCode ^
      dateRemoved.hashCode ^
      playerNumber.hashCode;
}
