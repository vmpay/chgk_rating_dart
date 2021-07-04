import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idteam": "58380",
/// "name": "Олег с мышами",
/// "town": "Варшава",
/// "region_name": "Мазовецкое воеводство",
/// "country_name": "Польша",
/// "tournaments_this_season": "0",
/// "tournaments_total": "125",
/// "comment": "Комментарий"
/// }
/// ```
@immutable
class Team {
  const Team({
    required this.idTeam,
    this.name,
    this.town,
    this.regionName,
    this.countryName,
    this.tournamentsThisSeason,
    this.tournamentsTotal,
    this.comment,
  });

  final String idTeam;
  final String? name;
  final String? town;
  final String? regionName;
  final String? countryName;
  final String? tournamentsThisSeason;
  final String? tournamentsTotal;
  final String? comment;

  /// Decodes [Team] object from json string
  factory Team.fromJson(String str) => Team.fromMap(json.decode(str));

  /// Encodes [Team] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [Team] object from json map
  factory Team.fromMap(Map<String, dynamic> json) => Team(
    idTeam: json['idteam'] == null ? '-1' : json['idteam'],
        name: json['name'] == null ? null : json['name'],
        town: json['town'] == null ? null : json['town'],
        regionName: json['region_name'] == null ? null : json['region_name'],
        countryName: json['country_name'] == null ? null : json['country_name'],
        tournamentsThisSeason: json['tournaments_this_season'] == null
            ? null
            : json['tournaments_this_season'],
        tournamentsTotal: json['tournaments_total'] == null
            ? null
            : json['tournaments_total'],
        comment: json['comment'] == null ? null : json['comment'],
  );

  /// Encodes [Team] object to json map
  Map<String, dynamic> toMap() =>
      {
        'idteam': idTeam,
        'name': name == null ? null : name,
        'town': town == null ? null : town,
        'region_name': regionName == null ? null : regionName,
        'country_name': countryName == null ? null : countryName,
        'tournaments_this_season':
            tournamentsThisSeason == null ? null : tournamentsThisSeason,
        'tournaments_total': tournamentsTotal == null ? null : tournamentsTotal,
        'comment': comment == null ? null : comment,
      };

  @override
  String toString() {
    return 'Team{idTeam: $idTeam, name: $name, town: $town, regionName: $regionName, countryName: $countryName, tournamentsThisSeason: $tournamentsThisSeason, tournamentsTotal: $tournamentsTotal, comment: $comment}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          idTeam == other.idTeam &&
          name == other.name &&
          town == other.town &&
          regionName == other.regionName &&
          countryName == other.countryName &&
          tournamentsThisSeason == other.tournamentsThisSeason &&
          tournamentsTotal == other.tournamentsTotal &&
          comment == other.comment;

  @override
  int get hashCode =>
      idTeam.hashCode ^
      name.hashCode ^
      town.hashCode ^
      regionName.hashCode ^
      countryName.hashCode ^
      tournamentsThisSeason.hashCode ^
      tournamentsTotal.hashCode ^
      comment.hashCode;
}
