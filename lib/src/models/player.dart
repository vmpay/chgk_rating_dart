import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idplayer": "27822",
/// "surname": "Савченков",
/// "name": "Михаил",
/// "patronymic": "Владимирович",
/// "comment": "Комментарий",
/// "db_chgk_info_tag": "msavchenkov"
/// }
/// ```
@immutable
class Player {
  const Player({
    required this.idPlayer,
    this.surname,
    this.name,
    this.patronymic,
    this.comment,
    this.dbChgkInfoTag,
  });

  final String idPlayer;
  final String? surname;
  final String? name;
  final String? patronymic;
  final String? comment;
  final String? dbChgkInfoTag;

  /// Decodes [Player] object from json string
  factory Player.fromJson(String str) => Player.fromMap(json.decode(str));

  /// Encodes [Player] object to json String
  String toJson() => json.encode(toMap());

  /// Decodes [Player] object from json map
  factory Player.fromMap(Map<String, dynamic> json) => Player(
        idPlayer: json['idplayer'] == null ? 'null' : json['idplayer'],
        surname: json['surname'] == null ? null : json['surname'],
        name: json['name'] == null ? null : json['name'],
        patronymic: json['patronymic'] == null ? null : json['patronymic'],
        comment: json['comment'] == null ? null : json['comment'],
        dbChgkInfoTag:
            json['db_chgk_info_tag'] == null ? null : json['db_chgk_info_tag'],
      );

  /// Encodes [Player] object to json map
  Map<String, dynamic> toMap() =>
      {
        'idplayer': idPlayer == null ? 'null' : idPlayer,
        'surname': surname == null ? null : surname,
        'name': name == null ? null : name,
        'patronymic': patronymic == null ? null : patronymic,
        'comment': comment == null ? null : comment,
        'db_chgk_info_tag': dbChgkInfoTag == null ? null : dbChgkInfoTag,
      };

  @override
  String toString() {
    return 'Player{idPlayer: $idPlayer, surname: $surname, name: $name, patronymic: $patronymic, comment: $comment, dbChgkInfoTag: $dbChgkInfoTag}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          idPlayer == other.idPlayer &&
          surname == other.surname &&
          name == other.name &&
          patronymic == other.patronymic &&
          comment == other.comment &&
          dbChgkInfoTag == other.dbChgkInfoTag;

  @override
  int get hashCode =>
      idPlayer.hashCode ^
      surname.hashCode ^
      name.hashCode ^
      patronymic.hashCode ^
      comment.hashCode ^
      dbChgkInfoTag.hashCode;
}
