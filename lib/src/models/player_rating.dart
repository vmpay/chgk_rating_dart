/// Response example:
/// {
/// "idplayer": "147205",
/// "idteam": "58380",
/// "idseason": "50",
/// "is_captain": "0",
/// "added_since": "2017-04-21"
/// }
///
import 'dart:convert';

class PlayerRating {
  PlayerRating({
    this.idplayer,
    this.idrelease,
    this.rating,
    this.ratingPosition,
    this.date,
    this.tournamentsInYear,
    this.tournamentCountTotal,
  });

  final String? idplayer;
  final String? idrelease;
  final String? rating;
  final String? ratingPosition;
  final DateTime? date;
  final String? tournamentsInYear;
  final String? tournamentCountTotal;

  factory PlayerRating.fromJson(String str) =>
      PlayerRating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerRating.fromMap(Map<String, dynamic> json) => PlayerRating(
        idplayer: json["idplayer"] == null ? null : json["idplayer"],
        idrelease: json["idrelease"] == null ? null : json["idrelease"],
        rating: json["rating"] == null ? null : json["rating"],
        ratingPosition:
            json["rating_position"] == null ? null : json["rating_position"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        tournamentsInYear: json["tournaments_in_year"] == null
            ? null
            : json["tournaments_in_year"],
        tournamentCountTotal: json["tournament_count_total"] == null
            ? null
            : json["tournament_count_total"],
      );

  Map<String, dynamic> toMap() => {
        "idplayer": idplayer == null ? null : idplayer,
        "idrelease": idrelease == null ? null : idrelease,
        "rating": rating == null ? null : rating,
        "rating_position": ratingPosition == null ? null : ratingPosition,
        "date": date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "tournaments_in_year":
            tournamentsInYear == null ? null : tournamentsInYear,
        "tournament_count_total":
            tournamentCountTotal == null ? null : tournamentCountTotal,
      };

  @override
  String toString() {
    return 'PlayerRating{idplayer: $idplayer, idrelease: $idrelease, rating: $rating, ratingPosition: $ratingPosition, date: $date, tournamentsInYear: $tournamentsInYear, tournamentCountTotal: $tournamentCountTotal}';
  }
}
