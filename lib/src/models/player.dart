/// Response example:
/// {
/// "idplayer": "27822",
/// "surname": "Савченков",
/// "name": "Михаил",
/// "patronymic": "Владимирович",
/// "comment": null,
/// "db_chgk_info_tag": "msavchenkov"
/// }
import 'dart:convert';

class Player {
  Player({
    this.idplayer,
    this.surname,
    this.name,
    this.patronymic,
    this.comment,
    this.dbChgkInfoTag,
  });

  final String? idplayer;
  final String? surname;
  final String? name;
  final String? patronymic;
  final String? comment;
  final String? dbChgkInfoTag;

  factory Player.fromJson(String str) => Player.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Player.fromMap(Map<String, dynamic> json) => Player(
        idplayer: json["idplayer"] == null ? null : json["idplayer"],
        surname: json["surname"] == null ? null : json["surname"],
        name: json["name"] == null ? null : json["name"],
        patronymic: json["patronymic"] == null ? null : json["patronymic"],
        comment: json["comment"] == null ? null : json["comment"],
        dbChgkInfoTag:
            json["db_chgk_info_tag"] == null ? null : json["db_chgk_info_tag"],
      );

  Map<String, dynamic> toMap() => {
        "idplayer": idplayer == null ? null : idplayer,
        "surname": surname == null ? null : surname,
        "name": name == null ? null : name,
        "patronymic": patronymic == null ? null : patronymic,
        "comment": comment == null ? null : comment,
        "db_chgk_info_tag": dbChgkInfoTag == null ? null : dbChgkInfoTag,
      };

  @override
  String toString() {
    return 'Player{idplayer: $idplayer, surname: $surname, name: $name, patronymic: $patronymic, comment: $comment, dbChgkInfoTag: $dbChgkInfoTag}';
  }
}
