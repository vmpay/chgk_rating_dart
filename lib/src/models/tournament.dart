/// Response example:
/// {
/// "idtournament": "6431",
/// "name": "Онлайн: 22:00 MSK / KYIV  \"Триптих. Лето\" (NEW!)",
/// "date_start": "2021-06-04 22:00:00",
/// "date_end": "0000-00-00 00:00:00",
/// "type_name": "Обычный",
/// "archive": "2021-06-04 22:00:00",
/// "date_archived_at": "2021-06-04 22:00:00"
/// }
import 'dart:convert';

class Tournament {
  Tournament({
    this.idTournament,
    this.name,
    this.dateStart,
    this.dateEnd,
    this.typeName,
    this.archive,
    this.dateArchivedAt,
  });

  final String? idTournament;
  final String? name;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final String? typeName;
  final String? archive;
  final DateTime? dateArchivedAt;

  factory Tournament.fromJson(String str) =>
      Tournament.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tournament.fromMap(Map<String, dynamic> json) => Tournament(
        idTournament:
            json['idtournament'] == null ? null : json['idtournament'],
        name: json['name'] == null ? null : json['name'],
        dateStart: json['date_start'] == null
            ? null
            : DateTime.parse(json['date_start']),
        dateEnd:
            json['date_end'] == null ? null : DateTime.parse(json['date_end']),
        typeName: json['type_name'] == null ? null : json['type_name'],
        archive: json['archive'] == null ? null : json['archive'],
        dateArchivedAt: json['date_archived_at'] == null
            ? null
            : DateTime.parse(json['date_archived_at']),
      );

  Map<String, dynamic> toMap() => {
        'idtournament': idTournament == null ? null : idTournament,
        'name': name == null ? null : name,
        'date_start': dateStart == null ? null : dateStart?.toIso8601String(),
        'date_end': dateEnd == null ? null : dateEnd?.toIso8601String(),
        'type_name': typeName == null ? null : typeName,
        'archive': archive == null ? null : archive,
        'date_archived_at':
            dateArchivedAt == null ? null : dateArchivedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return 'Tournament{idTournament: $idTournament, name: $name, dateStart: $dateStart, dateEnd: $dateEnd, typeName: $typeName, archive: $archive, dateArchivedAt: $dateArchivedAt}';
  }
}
