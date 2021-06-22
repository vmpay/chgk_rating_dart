/// Response example:
/// {
/// "idplayer": "147205",
/// "idteam": "58380",
/// "idseason": "50",
/// "is_captain": "0",
/// "added_since": "2017-04-21"
/// }
///
import 'dart:convert';

class PlayerTeam {
  PlayerTeam({
    this.idplayer,
    this.idteam,
    this.idseason,
    this.isCaptain,
    this.addedSince,
  });

  final String? idplayer;
  final String? idteam;
  final String? idseason;
  final String? isCaptain;
  final DateTime? addedSince;

  factory PlayerTeam.fromJson(String str) =>
      PlayerTeam.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerTeam.fromMap(Map<String, dynamic> json) => PlayerTeam(
        idplayer: json["idplayer"] == null ? null : json["idplayer"],
        idteam: json["idteam"] == null ? null : json["idteam"],
        idseason: json["idseason"] == null ? null : json["idseason"],
        isCaptain: json["is_captain"] == null ? null : json["is_captain"],
        addedSince: json["added_since"] == null
            ? null
            : DateTime.parse(json["added_since"]),
      );

  Map<String, dynamic> toMap() => {
        "idplayer": idplayer == null ? null : idplayer,
        "idteam": idteam == null ? null : idteam,
        "idseason": idseason == null ? null : idseason,
        "is_captain": isCaptain == null ? null : isCaptain,
        "added_since": addedSince == null
            ? null
            : "${addedSince?.year.toString().padLeft(4, '0')}-${addedSince?.month.toString().padLeft(2, '0')}-${addedSince?.day.toString().padLeft(2, '0')}",
      };

  @override
  String toString() {
    return 'PlayerTeam{idplayer: $idplayer, idteam: $idteam, idseason: $idseason, isCaptain: $isCaptain, addedSince: $addedSince}';
  }
}
