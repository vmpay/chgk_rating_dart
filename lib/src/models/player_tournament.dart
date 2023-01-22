import 'dart:convert';

/// Player tournament response example:
/// ```json
///[
///    {
///        "idplayer": 2027,
///        "idteam": 26777,
///        "idtournament": 219
///    },
///    {
///        "idplayer": 2027,
///        "idteam": 26777,
///        "idtournament": 314
///    }
///]
/// ```
class PlayerTournament {
  PlayerTournament({
    required this.idPlayer,
    required this.idTeam,
    required this.idTournament,
  });

  final int? idPlayer;
  final int idTeam;
  final int idTournament;

  PlayerTournament copyWith({
    required int? idPlayer,
    required int idTeam,
    required int idTournament,
  }) =>
      PlayerTournament(
        idPlayer: idPlayer,
        idTeam: idTeam,
        idTournament: idTournament,
      );

  factory PlayerTournament.fromRawJson(String str) =>
      PlayerTournament.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerTournament.fromJson(Map<String, dynamic> json) =>
      PlayerTournament(
        idPlayer: json["idplayer"],
        idTeam: json["idteam"],
        idTournament: json["idtournament"],
      );

  Map<String, dynamic> toJson() => {
        "idplayer": idPlayer,
        "idteam": idTeam,
        "idtournament": idTournament,
      };

  static Iterable<PlayerTournament> decodeList(List<dynamic> list) =>
      list.map((e) => PlayerTournament.fromRawJson(e));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerTournament &&
          runtimeType == other.runtimeType &&
          idPlayer == other.idPlayer &&
          idTeam == other.idTeam &&
          idTournament == other.idTournament;

  @override
  int get hashCode =>
      idPlayer.hashCode ^ idTeam.hashCode ^ idTournament.hashCode;
}
