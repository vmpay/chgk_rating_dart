import 'dart:convert';

import 'package:collection/collection.dart';

import 'player.dart';
import 'team.dart';
import 'tournament.dart';
import 'tournament_results.dart';

class TournamentRequests {
  TournamentRequests({
    required this.id,
    required this.status,
    required this.venue,
    required this.representative,
    required this.narrators,
    required this.approximateTeamsCount,
    required this.issuedAt,
    required this.tournamentId,
  });

  final int id;
  final QuestionStatus status;
  final Venue? venue;
  final Player? representative;
  final List<Player> narrators;
  final int? approximateTeamsCount;
  final DateTime? issuedAt;
  final int tournamentId;

  TournamentRequests copyWith({
    required int id,
    required QuestionStatus status,
    required Venue? venue,
    required Player? representative,
    required List<Player> narrators,
    required int? approximateTeamsCount,
    required DateTime? issuedAt,
    required int tournamentId,
  }) =>
      TournamentRequests(
        id: id,
        status: status,
        venue: venue ?? this.venue,
        representative: representative ?? this.representative,
        narrators: narrators,
        approximateTeamsCount:
            approximateTeamsCount ?? this.approximateTeamsCount,
        issuedAt: issuedAt ?? this.issuedAt,
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
        narrators:
            List<Player>.from(json["narrators"].map((x) => Player.fromJson(x))),
        approximateTeamsCount: json["approximateTeamsCount"],
        issuedAt:
            json["issuedAt"] != null ? DateTime.parse(json["issuedAt"]) : null,
        tournamentId: json["tournamentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": statusValues.reverse[status],
        "venue": venue?.toJson(),
        "representative": representative?.toJson(),
        "narrators": List<dynamic>.from(narrators.map((x) => x.toJson())),
        "approximateTeamsCount": approximateTeamsCount,
        "issuedAt": issuedAt?.toIso8601String(),
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
          const DeepCollectionEquality().equals(narrators, other.narrators) &&
          approximateTeamsCount == other.approximateTeamsCount &&
          issuedAt == other.issuedAt &&
          tournamentId == other.tournamentId;

  @override
  int get hashCode =>
      id.hashCode ^
      status.hashCode ^
      venue.hashCode ^
      representative.hashCode ^
      narrators.hashCode ^
      approximateTeamsCount.hashCode ^
      issuedAt.hashCode ^
      tournamentId.hashCode;

  @override
  String toString() {
    return 'TournamentRequests{id: $id, status: $status, venue: $venue, representative: $representative, narrators: $narrators, approximateTeamsCount: $approximateTeamsCount, issuedAt: $issuedAt, tournamentId: $tournamentId}';
  }
}

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
