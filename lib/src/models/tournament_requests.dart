import 'dart:convert';

import 'package:collection/collection.dart';

import 'player.dart';
import 'team.dart';
import 'tournament.dart';
import 'tournament_results.dart';

/// Token response example:
/// ```json
/// [
///   {
///     "id": 32231,
///     "status": "A",
///     "venue": {
///       "id": 3051,
///       "name": "Хельсинки",
///       "town": {
///         "id": 364,
///         "name": "Хельсинки",
///         "country": {
///           "id": 27,
///           "name": "Финляндия"
///         }
///       },
///       "type": {
///         "id": 1,
///         "name": "Постоянная"
///       },
///       "urls": [
///         "http://www.chgk.fi",
///         "https://www.facebook.com/chgk.fi",
///         "https://chgk-fi.livejournal.com/"
///       ]
///     },
///     "representative": {
///       "id": 5720,
///       "name": "Иван",
///       "patronymic": "Владимирович",
///       "surname": "Власов",
///       "dbChgkInfoTag": ""
///     },
///     "narrator": {
///       "id": 19620,
///       "name": "Наталия",
///       "patronymic": "Владимировна",
///       "surname": "Мальгина",
///       "dbChgkInfoTag": ""
///     },
///     "approximateTeamsCount": 11,
///     "issuedAt": "2017-03-26T20:36:33+03:00",
///     "dateStart": "2017-04-22T18:00:00+03:00",
///     "narrators": [
///       {
///         "id": 19620,
///         "name": "Наталия",
///         "patronymic": "Владимировна",
///         "surname": "Мальгина",
///         "dbChgkInfoTag": ""
///       }
///     ],
///     "tournamentId": 3779
///   },
/// ]
/// ```
class TournamentRequests {
  TournamentRequests({
    required this.id,
    required this.status,
    required this.venue,
    required this.representative,
    required this.narrator,
    required this.narrators,
    required this.approximateTeamsCount,
    required this.issuedAt,
    required this.dateStart,
    required this.tournamentId,
  });

  final int id;
  final QuestionStatus status;
  final Venue? venue;
  final Player? representative;
  final Player? narrator;
  final List<Player> narrators;
  final int? approximateTeamsCount;
  final DateTime? issuedAt;
  final DateTime? dateStart;
  final int tournamentId;

  TournamentRequests copyWith({
    required int id,
    required QuestionStatus status,
    required Venue? venue,
    required Player? representative,
    required Player? narrator,
    required List<Player> narrators,
    required int? approximateTeamsCount,
    required DateTime? issuedAt,
    required DateTime? dateStart,
    required int tournamentId,
  }) =>
      TournamentRequests(
        id: id,
        status: status,
        venue: venue ?? this.venue,
        representative: representative ?? this.representative,
        narrator: narrator ?? this.narrator,
        narrators: narrators,
        approximateTeamsCount:
            approximateTeamsCount ?? this.approximateTeamsCount,
        issuedAt: issuedAt ?? this.issuedAt,
        dateStart: dateStart ?? this.dateStart,
        tournamentId: tournamentId,
      );

  factory TournamentRequests.fromRawJson(String str) =>
      TournamentRequests.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TournamentRequests.fromJson(Map<String, dynamic> json) =>
      TournamentRequests(
        id: json["id"],
        status: statusValues.map[json["status"]]!,
        venue: json["venue"] != null ? Venue.fromJson(json["venue"]) : null,
        representative: json["representative"] != null
            ? Player.fromJson(json["representative"])
            : null,
        narrator:
            json["narrator"] != null ? Player.fromJson(json["narrator"]) : null,
        narrators: json["narrators"] != null
            ? List<Player>.from(
                json["narrators"].map((x) => Player.fromJson(x)))
            : <Player>[],
        approximateTeamsCount: json["approximateTeamsCount"],
        issuedAt:
            json["issuedAt"] != null ? DateTime.parse(json["issuedAt"]) : null,
        dateStart: json["dateStart"] != null
            ? DateTime.parse(json["dateStart"])
            : null,
        tournamentId: json["tournamentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": statusValues.reverse[status],
        "venue": venue?.toJson(),
        "representative": representative?.toJson(),
        "narrator": narrator?.toJson(),
        "narrators": List<dynamic>.from(narrators.map((x) => x.toJson())),
        "approximateTeamsCount": approximateTeamsCount,
        "issuedAt": issuedAt?.toIso8601String(),
        "dateStart": dateStart?.toIso8601String(),
        "tournamentId": tournamentId,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentRequests &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          venue == other.venue &&
          representative == other.representative &&
          narrator == other.narrator &&
          const DeepCollectionEquality().equals(narrators, other.narrators) &&
          approximateTeamsCount == other.approximateTeamsCount &&
          issuedAt == other.issuedAt &&
          dateStart == other.dateStart &&
          tournamentId == other.tournamentId;

  @override
  int get hashCode =>
      id.hashCode ^
      status.hashCode ^
      venue.hashCode ^
      representative.hashCode ^
      narrator.hashCode ^
      narrators.hashCode ^
      approximateTeamsCount.hashCode ^
      issuedAt.hashCode ^
      dateStart.hashCode ^
      tournamentId.hashCode;

  @override
  String toString() {
    return 'TournamentRequests{id: $id, status: $status, venue: $venue, representative: $representative, narrator: $narrator, narrators: $narrators, approximateTeamsCount: $approximateTeamsCount, issuedAt: $issuedAt, dateStart: $dateStart, tournamentId: $tournamentId}';
  }
}

/// Venue data model
/// ```json
/// {
///   "id": 3051,
///   "name": "Хельсинки",
///   "town": {
///     "id": 364,
///     "name": "Хельсинки",
///     "country": {
///       "id": 27,
///       "name": "Финляндия"
///     }
///   },
///   "type": {
///     "id": 1,
///     "name": "Постоянная"
///   }
/// }
class Venue {
  Venue({
    required this.id,
    required this.name,
    required this.town,
    required this.type,
    required this.address,
    required this.urls,
  });

  final int id;
  final String name;
  final Town? town;
  final Type? type;
  final String? address;
  final List<String> urls;

  Venue copyWith({
    required int id,
    required String name,
    required Town? town,
    required Type? type,
    required String? address,
    required List<String> urls,
  }) =>
      Venue(
        id: id,
        name: name,
        town: town ?? this.town,
        type: type ?? this.type,
        address: address,
        urls: urls,
      );

  factory Venue.fromRawJson(String str) => Venue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
        town: json["town"] != null ? Town.fromJson(json["town"]) : null,
        type: json["type"] != null ? Type.fromJson(json["type"]) : null,
        address: json["address"],
        urls: List<String>.from(json["urls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "town": town?.toJson(),
        "type": type?.toJson(),
        "address": address,
        "urls": List<dynamic>.from(urls.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venue &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          town == other.town &&
          type == other.type &&
          address == other.address &&
          const DeepCollectionEquality().equals(urls, other.urls);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      town.hashCode ^
      type.hashCode ^
      address.hashCode ^
      urls.hashCode;

  @override
  String toString() {
    return 'Venue{id: $id, name: $name, town: $town, type: $type, address: $address, urls: $urls}';
  }
}
