import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idteam": "58380",
/// "idrelease": "1283",
/// "rating": "672",
/// "rating_position": "9999",
/// "date": "2017-04-20",
/// "tech_rating": "840",
/// "formula": "b"
/// }
/// ```
@immutable
class TeamRating {
  const TeamRating({
    this.idTeam,
    this.idRelease,
    this.rating,
    this.ratingPosition,
    this.date,
    this.techRating,
    this.formula,
  });

  final String? idTeam;
  final String? idRelease;
  final String? rating;
  final String? ratingPosition;
  final DateTime? date;
  final String? techRating;
  final String? formula;

  /// Decodes [TeamRating] object from json string
  factory TeamRating.fromJson(String str) =>
      TeamRating.fromMap(json.decode(str));

  /// Encodes [TeamRating] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TeamRating] object from json map
  factory TeamRating.fromMap(Map<String, dynamic> json) => TeamRating(
        idTeam: json['idteam'] == null ? null : json['idteam'],
        idRelease: json['idrelease'] == null ? null : json['idrelease'],
        rating: json['rating'] == null ? null : json['rating'],
        ratingPosition:
            json['rating_position'] == null ? null : json['rating_position'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        techRating: json['tech_rating'] == null ? null : json['tech_rating'],
        formula: json['formula'] == null ? null : json['formula'],
      );

  /// Encodes [TeamRating] object to json map
  Map<String, dynamic> toMap() => {
        'idteam': idTeam == null ? null : idTeam,
        'idrelease': idRelease == null ? null : idRelease,
        'rating': rating == null ? null : rating,
        'rating_position': ratingPosition == null ? null : ratingPosition,
        'date': date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        'tech_rating': techRating == null ? null : techRating,
        'formula': formula == null ? null : formula,
      };

  @override
  String toString() {
    return 'TeamRating{idTeam: $idTeam, idRelease: $idRelease, rating: $rating, ratingPosition: $ratingPosition, date: $date, techRating: $techRating, formula: $formula}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamRating &&
          runtimeType == other.runtimeType &&
          idTeam == other.idTeam &&
          idRelease == other.idRelease &&
          rating == other.rating &&
          ratingPosition == other.ratingPosition &&
          date == other.date &&
          techRating == other.techRating &&
          formula == other.formula;

  @override
  int get hashCode =>
      idTeam.hashCode ^
      idRelease.hashCode ^
      rating.hashCode ^
      ratingPosition.hashCode ^
      date.hashCode ^
      techRating.hashCode ^
      formula.hashCode;
}
