/// Response example:
/// {
/// "idteam": "58380",
/// "idrelease": "1283",
/// "rating": "672",
/// "rating_position": "9999",
/// "date": "2017-04-20",
/// "tech_rating": "840",
/// "formula": "b"
/// }
import 'dart:convert';

class TeamRating {
  TeamRating({
    this.idteam,
    this.idrelease,
    this.rating,
    this.ratingPosition,
    this.date,
    this.techRating,
    this.formula,
  });

  final String? idteam;
  final String? idrelease;
  final String? rating;
  final String? ratingPosition;
  final DateTime? date;
  final String? techRating;
  final String? formula;

  factory TeamRating.fromJson(String str) =>
      TeamRating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamRating.fromMap(Map<String, dynamic> json) => TeamRating(
        idteam: json["idteam"] == null ? null : json["idteam"],
        idrelease: json["idrelease"] == null ? null : json["idrelease"],
        rating: json["rating"] == null ? null : json["rating"],
        ratingPosition:
            json["rating_position"] == null ? null : json["rating_position"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        techRating: json["tech_rating"] == null ? null : json["tech_rating"],
        formula: json["formula"] == null ? null : json["formula"],
      );

  Map<String, dynamic> toMap() => {
        "idteam": idteam == null ? null : idteam,
        "idrelease": idrelease == null ? null : idrelease,
        "rating": rating == null ? null : rating,
        "rating_position": ratingPosition == null ? null : ratingPosition,
        "date": date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "tech_rating": techRating == null ? null : techRating,
        "formula": formula == null ? null : formula,
      };

  @override
  String toString() {
    return 'TeamRating{idteam: $idteam, idrelease: $idrelease, rating: $rating, ratingPosition: $ratingPosition, date: $date, techRating: $techRating, formula: $formula}';
  }
}
