import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idplayer": "147205",
/// "idteam": "58380",
/// "idseason": "50",
/// "is_captain": "0",
/// "added_since": "2017-04-21"
/// }
/// ```
@immutable
class PlayerTeam {
  const PlayerTeam({
    required this.idPlayer,
    required this.idTeam,
    this.idSeason,
    this.isCaptain,
    this.addedSince,
  });

  final String idPlayer;
  final String idTeam;
  final String? idSeason;
  final String? isCaptain;
  final DateTime? addedSince;

  /// Decodes [PlayerTeam] object from json string
  factory PlayerTeam.fromJson(String str) =>
      PlayerTeam.fromMap(json.decode(str));

  /// Encodes [PlayerTeam] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [PlayerTeam] object from json map
  factory PlayerTeam.fromMap(Map<String, dynamic> json) => PlayerTeam(
    idPlayer: json['idplayer'] == null ? 'null' : json['idplayer'],
    idTeam: json['idteam'] == null ? 'null' : json['idteam'],
    idSeason: json['idseason'] == null ? null : json['idseason'],
    isCaptain: json['is_captain'] == null ? null : json['is_captain'],
    addedSince: json['added_since'] == null
        ? null
        : DateTime.parse(json['added_since']),
  );

  /// Encodes [PlayerTeam] object to json map
  Map<String, dynamic> toMap() => {
        'idplayer': idPlayer,
        'idteam': idTeam,
        'idseason': idSeason == null ? null : idSeason,
        'is_captain': isCaptain == null ? null : isCaptain,
        'added_since': addedSince == null
            ? null
            : "${addedSince?.year.toString().padLeft(4, '0')}-${addedSince?.month.toString().padLeft(2, '0')}-${addedSince?.day.toString().padLeft(2, '0')}",
      };

  @override
  String toString() {
    return 'PlayerTeam{idPlayer: $idPlayer, idTeam: $idTeam, idSeason: $idSeason, isCaptain: $isCaptain, addedSince: $addedSince}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerTeam &&
          runtimeType == other.runtimeType &&
          idPlayer == other.idPlayer &&
          idTeam == other.idTeam &&
          idSeason == other.idSeason &&
          isCaptain == other.isCaptain &&
          addedSince == other.addedSince;

  @override
  int get hashCode =>
      idPlayer.hashCode ^
      idTeam.hashCode ^
      idSeason.hashCode ^
      isCaptain.hashCode ^
      addedSince.hashCode;
}
