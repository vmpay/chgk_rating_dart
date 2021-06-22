/// Response example:
/// {
/// "idteam": "3639",
/// "current_name": "Захидный полюс",
/// "base_name": "Захидный полюс",
/// "position": "2.5",
/// "questions_total": "21",
/// "mask": "111000001100010010110010100011001011010001001101",
/// "tech_rating_rt": "4212",
/// "tech_rating_rg": "4658",
/// "tech_rating_rb": "4506",
/// "rating_r": "5009",
/// "predicted_position": "4",
/// "bonus_b": "1076",
/// "diff_bonus": "59",
/// "included_in_rating": 1
/// }
import 'dart:convert';

class TournamentTeam {
  TournamentTeam({
    this.idteam,
    this.currentName,
    this.baseName,
    this.position,
    this.questionsTotal,
    this.mask,
    this.techRatingRt,
    this.techRatingRg,
    this.techRatingRb,
    this.ratingR,
    this.predictedPosition,
    this.bonusB,
    this.diffBonus,
    this.includedInRating,
  });

  final String? idteam;
  final String? currentName;
  final String? baseName;
  final String? position;
  final String? questionsTotal;
  final String? mask;
  final String? techRatingRt;
  final String? techRatingRg;
  final String? techRatingRb;
  final String? ratingR;
  final String? predictedPosition;
  final String? bonusB;
  final String? diffBonus;
  final int? includedInRating;

  factory TournamentTeam.fromJson(String str) =>
      TournamentTeam.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TournamentTeam.fromMap(Map<String, dynamic> json) => TournamentTeam(
        idteam: json["idteam"] == null ? null : json["idteam"],
        currentName: json["current_name"] == null ? null : json["current_name"],
        baseName: json["base_name"] == null ? null : json["base_name"],
        position: json["position"] == null ? null : json["position"],
        questionsTotal:
            json["questions_total"] == null ? null : json["questions_total"],
        mask: json["mask"] == null ? null : json["mask"],
        techRatingRt:
            json["tech_rating_rt"] == null ? null : json["tech_rating_rt"],
        techRatingRg:
            json["tech_rating_rg"] == null ? null : json["tech_rating_rg"],
        techRatingRb:
            json["tech_rating_rb"] == null ? null : json["tech_rating_rb"],
        ratingR: json["rating_r"] == null ? null : json["rating_r"],
        predictedPosition: json["predicted_position"] == null
            ? null
            : json["predicted_position"],
        bonusB: json["bonus_b"] == null ? null : json["bonus_b"],
        diffBonus: json["diff_bonus"] == null ? null : json["diff_bonus"],
        includedInRating: json["included_in_rating"] == null
            ? null
            : json["included_in_rating"],
      );

  Map<String, dynamic> toMap() => {
        "idteam": idteam == null ? null : idteam,
        "current_name": currentName == null ? null : currentName,
        "base_name": baseName == null ? null : baseName,
        "position": position == null ? null : position,
        "questions_total": questionsTotal == null ? null : questionsTotal,
        "mask": mask == null ? null : mask,
        "tech_rating_rt": techRatingRt == null ? null : techRatingRt,
        "tech_rating_rg": techRatingRg == null ? null : techRatingRg,
        "tech_rating_rb": techRatingRb == null ? null : techRatingRb,
        "rating_r": ratingR == null ? null : ratingR,
        "predicted_position":
            predictedPosition == null ? null : predictedPosition,
        "bonus_b": bonusB == null ? null : bonusB,
        "diff_bonus": diffBonus == null ? null : diffBonus,
        "included_in_rating":
            includedInRating == null ? null : includedInRating,
      };

  @override
  String toString() {
    return 'TournamentTeam{idteam: $idteam, currentName: $currentName, baseName: $baseName, position: $position, questionsTotal: $questionsTotal, mask: $mask, techRatingRt: $techRatingRt, techRatingRg: $techRatingRg, techRatingRb: $techRatingRb, ratingR: $ratingR, predictedPosition: $predictedPosition, bonusB: $bonusB, diffBonus: $diffBonus, includedInRating: $includedInRating}';
  }
}
