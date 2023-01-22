import 'dart:convert';

/// Team response example:
/// ```json
/// {
///    "id": 26777,
///    "name": "Утечка мозгов",
///    "town": {
///        "id": 197,
///        "name": "Минск",
///        "region": {
///            "id": 84,
///            "name": "Минск",
///            "country": {
///                "id": 5,
///                "name": "Беларусь"
///            }
///        },
///        "country": {
///            "id": 5,
///            "name": "Беларусь"
///        }
///    }
/// }
/// ```
class Team {
  Team({
    required this.id,
    required this.name,
    required this.town,
  });

  final int id;
  final String name;
  final Town? town;

  Team copyWith({
    required int id,
    required String name,
    required Town? town,
  }) =>
      Team(
        id: id,
        name: name,
        town: town,
      );

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        town: json["town"] != null ? Town.fromJson(json["town"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "town": town?.toJson(),
      };

  static Iterable<Team> decodeList(List<dynamic> list) =>
      list.map((dynamic e) => Team.fromRawJson(e));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          town == other.town;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ town.hashCode;

  @override
  String toString() {
    return 'Team{id: $id, name: $name, town: $town}';
  }
}

/// Town data model
/// ```json
/// {
///   "id": 197,
///   "name": "Минск",
///   "region": {
///     "id": 84,
///     "name": "Минск",
///     "country": {
///       "id": 5,
///       "name": "Беларусь"
///     }
///   },
///   "country": {
///     "id": 5,
///     "name": "Беларусь"
///   }
/// }
/// ```
class Town {
  Town({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
  });

  final int id;
  final String name;
  final Town? region;
  final Country? country;

  Town copyWith({
    required int id,
    required String name,
    required Town? region,
    required Country? country,
  }) =>
      Town(
        id: id,
        name: name,
        region: region ?? this.region,
        country: country ?? this.country,
      );

  factory Town.fromRawJson(String str) => Town.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Town.fromJson(Map<String, dynamic> json) => Town(
        id: json["id"],
        name: json["name"],
        region: json["region"] == null ? null : Town.fromJson(json["region"]),
        country:
            json["country"] != null ? Country.fromJson(json["country"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region?.toJson(),
        "country": country?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Town &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          region == other.region &&
          country == other.country;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ region.hashCode ^ country.hashCode;

  @override
  String toString() {
    return 'Town{id: $id, name: $name, region: $region, country: $country}';
  }
}

/// Country data model
/// ```json
/// {
///   "id": 5,
///   "name": "Беларусь"
/// }
/// ```
class Country {
  Country({
    required this.id,
    required this.name,
  });

  final int id;
  final String? name;

  Country copyWith({
    required int id,
    required String? name,
  }) =>
      Country(
        id: id,
        name: name ?? this.name,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Country{id: $id, name: $name}';
  }
}
