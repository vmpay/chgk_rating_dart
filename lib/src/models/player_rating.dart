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
class PlayerRating {
  const PlayerRating({
    this.idPlayer,
    this.idRelease,
    this.rating,
    this.ratingPosition,
    this.date,
    this.tournamentsInYear,
    this.tournamentCountTotal,
  });

  final String? idPlayer;
  final String? idRelease;
  final String? rating;
  final String? ratingPosition;
  final DateTime? date;
  final String? tournamentsInYear;
  final String? tournamentCountTotal;

  /// Decodes [PlayerRating] object from json string
  factory PlayerRating.fromJson(String str) =>
      PlayerRating.fromMap(json.decode(str));

  /// Encodes [PlayerRating] object to json String
  String toJson() => json.encode(toMap());

  /// Decodes [PlayerRating] object from json map
  factory PlayerRating.fromMap(Map<String, dynamic> json) => PlayerRating(
        idPlayer: json['idplayer'] == null ? null : json['idplayer'],
        idRelease: json['idrelease'] == null ? null : json['idrelease'],
        rating: json['rating'] == null ? null : json['rating'],
        ratingPosition:
            json['rating_position'] == null ? null : json['rating_position'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        tournamentsInYear: json['tournaments_in_year'] == null
            ? null
            : json['tournaments_in_year'],
        tournamentCountTotal: json['tournament_count_total'] == null
            ? null
            : json['tournament_count_total'],
      );

  /// Encodes [PlayerRating] object to json map
  Map<String, dynamic> toMap() => {
        'idplayer': idPlayer == null ? null : idPlayer,
        'idrelease': idRelease == null ? null : idRelease,
        'rating': rating == null ? null : rating,
        'rating_position': ratingPosition == null ? null : ratingPosition,
        'date': date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        'tournaments_in_year':
            tournamentsInYear == null ? null : tournamentsInYear,
        'tournament_count_total':
            tournamentCountTotal == null ? null : tournamentCountTotal,
      };

  @override
  String toString() {
    return 'PlayerRating{idplayer: $idPlayer, idrelease: $idRelease, rating: $rating, ratingPosition: $ratingPosition, date: $date, tournamentsInYear: $tournamentsInYear, tournamentCountTotal: $tournamentCountTotal}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerRating &&
          runtimeType == other.runtimeType &&
          idPlayer == other.idPlayer &&
          idRelease == other.idRelease &&
          rating == other.rating &&
          ratingPosition == other.ratingPosition &&
          date == other.date &&
          tournamentsInYear == other.tournamentsInYear &&
          tournamentCountTotal == other.tournamentCountTotal;

  @override
  int get hashCode =>
      idPlayer.hashCode ^
      idRelease.hashCode ^
      rating.hashCode ^
      ratingPosition.hashCode ^
      date.hashCode ^
      tournamentsInYear.hashCode ^
      tournamentCountTotal.hashCode;
}
