import 'dart:convert';

/// Player response example:
/// ```json
/// {
///     "id": 27822,
///     "name": "Михаил",
///     "patronymic": "Владимирович",
///     "surname": "Савченков"
/// }
/// ```
class Player {
  Player({
    required this.id,
    required this.name,
    required this.patronymic,
    required this.surname,
  });

  final int id;
  final String name;
  final String? patronymic;
  final String surname;

  Player copyWith({
    required int id,
    required String name,
    required String? patronymic,
    required String surname,
  }) =>
      Player(
        id: id,
        name: name,
        patronymic: patronymic,
        surname: surname,
      );

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
        patronymic: json["patronymic"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "patronymic": patronymic,
        "surname": surname,
      };

  static Iterable<Player> decodeList(List<dynamic> list) =>
      list.map((dynamic e) => Player.fromJson(e));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          patronymic == other.patronymic &&
          surname == other.surname;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ patronymic.hashCode ^ surname.hashCode;

  @override
  String toString() {
    return 'Player{id: $id, name: $name, patronymic: $patronymic, surname: $surname}';
  }
}
