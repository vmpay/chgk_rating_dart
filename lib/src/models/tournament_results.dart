import 'dart:convert';

import 'package:collection/collection.dart';

import 'player.dart';
import 'team.dart';

/// Response example:
/// ```json
/// [
///    {
///        "team": {
///            "id": 56077,
///            "name": "Склеп с забавками",
///            "town": {
///                "id": 2088,
///                "name": "Краков"
///            }
///        },
///        "mask": "100000000000100000000000000000000000",
///        "current": {
///            "name": "Склеп с забавками",
///            "town": {
///                "id": 2088,
///                "name": "Краков"
///            }
///        },
///        "questionsTotal": 2,
///        "synchRequest": {
///            "id": 32635,
///            "venue": {
///                "id": 3360,
///                "name": "Краков"
///            },
///            "tournamentId": 3779
///        },
///        "rating": {
///            "inRating": false,
///            "b": 6,
///            "predictedPosition": 826,
///            "rt": 330,
///            "rb": 390,
///            "rg": 330,
///            "r": 242,
///            "bp": 77,
///            "d1": -36,
///            "d2": 0,
///            "d": -18
///        },
///        "position": 947.5,
///        "controversials": [
///            {
///                "id": 55355,
///                "questionNumber": 13,
///                "answer": "ловить рыбу",
///                "issuedAt": "2017-04-22T13:11:11+03:00",
///                "status": "A",
///                "comment": "Данный ответ можно считать эквивалентным авторскому",
///                "resolvedAt": null,
///                "appealJuryComment": null
///            }
///        ],
///        "flags": [
///            {
///                "id": 11,
///                "shortName": "Б",
///                "longName": "Балтийский зачёт"
///            }
///        ],
///        "teamMembers": [
///            {
///                "flag": "Б",
///                "usedRating": 1202,
///                "rating": 1203,
///                "player": {
///                    "id": 13051,
///                    "name": "Елена",
///                    "patronymic": "Юрьевна",
///                    "surname": "Калачиди"
///                }
///            },
///            {
///                "flag": "К",
///                "usedRating": 597,
///                "rating": 717,
///                "player": {
///                    "id": 6618,
///                    "name": "Николай",
///                    "patronymic": "Константинович",
///                    "surname": "Ганичев"
///                }
///            }
///        ]
///    }
///]
/// ```
class TournamentResults {
  TournamentResults({
    required this.team,
    required this.mask,
    required this.current,
    required this.questionsTotal,
    required this.synchRequest,
    required this.rating,
    required this.position,
    required this.controversials,
    required this.flags,
    required this.teamMembers,
  });

  final Team team;
  final String? mask;
  final Current current;
  final int? questionsTotal;
  final SynchRequest? synchRequest;
  final Rating? rating;
  final double? position;
  final List<Controversial> controversials;
  final List<Flag> flags;
  final List<TeamMember> teamMembers;

  TournamentResults copyWith({
    required Team team,
    required String? mask,
    required Current current,
    required int? questionsTotal,
    required SynchRequest? synchRequest,
    required Rating? rating,
    required double? position,
    required List<Controversial> controversials,
    required List<Flag> flags,
    required List<TeamMember> teamMembers,
  }) =>
      TournamentResults(
        team: team,
        mask: mask ?? this.mask,
        current: current,
        questionsTotal: questionsTotal ?? this.questionsTotal,
        synchRequest: synchRequest ?? this.synchRequest,
        rating: rating ?? this.rating,
        position: position ?? this.position,
        controversials: controversials,
        flags: flags,
        teamMembers: teamMembers,
      );

  factory TournamentResults.fromRawJson(String str) =>
      TournamentResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TournamentResults.fromJson(Map<String, dynamic> json) =>
      TournamentResults(
        team: Team.fromJson(json["team"]),
        mask: json["mask"],
        current: Current.fromJson(json["current"]),
        questionsTotal: json["questionsTotal"],
        synchRequest: json["synchRequest"] != null
            ? SynchRequest.fromJson(json["synchRequest"])
            : null,
        rating: json["rating"] != null ? Rating.fromJson(json["rating"]) : null,
        position: json["position"].toDouble(),
        controversials: List<Controversial>.from(
            json["controversials"].map((x) => Controversial.fromJson(x))),
        flags: List<Flag>.from(json["flags"].map((x) => Flag.fromJson(x))),
        teamMembers: List<TeamMember>.from(
            json["teamMembers"].map((x) => TeamMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "team": team.toJson(),
        "mask": mask,
        "current": current.toJson(),
        "questionsTotal": questionsTotal,
        "synchRequest": synchRequest?.toJson(),
        "rating": rating?.toJson(),
        "position": position,
        "controversials":
            List<dynamic>.from(controversials.map((x) => x.toJson())),
        "flags": List<dynamic>.from(flags.map((x) => x.toJson())),
        "teamMembers": List<dynamic>.from(teamMembers.map((x) => x.toJson())),
      };

  static Iterable<TournamentResults> decodeList(List<dynamic> list) =>
      list.map((dynamic e) => TournamentResults.fromRawJson(e));

  @override
  bool operator ==(Object other) {
    final Function eq = const DeepCollectionEquality().equals;
    return identical(this, other) ||
        other is TournamentResults &&
            runtimeType == other.runtimeType &&
            team == other.team &&
            mask == other.mask &&
            current == other.current &&
            questionsTotal == other.questionsTotal &&
            synchRequest == other.synchRequest &&
            rating == other.rating &&
            position == other.position &&
            eq(controversials, other.controversials) &&
            eq(flags, other.flags) &&
            eq(teamMembers, other.teamMembers);
  }

  @override
  int get hashCode =>
      team.hashCode ^
      mask.hashCode ^
      current.hashCode ^
      questionsTotal.hashCode ^
      synchRequest.hashCode ^
      rating.hashCode ^
      position.hashCode ^
      controversials.hashCode ^
      flags.hashCode ^
      teamMembers.hashCode;

  @override
  String toString() {
    return 'TournamentResults{team: $team, mask: $mask, current: $current, questionsTotal: $questionsTotal, synchRequest: $synchRequest, rating: $rating, position: $position, controversials: $controversials, flags: $flags, teamMembers: $teamMembers}';
  }
}

class Controversial {
  Controversial({
    required this.id,
    required this.questionNumber,
    required this.answer,
    required this.issuedAt,
    required this.status,
    required this.comment,
    required this.resolvedAt,
    required this.appealJuryComment,
  });

  final int id;
  final int questionNumber;
  final String answer;
  final DateTime? issuedAt;
  final QuestionStatus status;
  final String? comment;
  final DateTime? resolvedAt;
  final String? appealJuryComment;

  Controversial copyWith({
    required int id,
    required int questionNumber,
    required String answer,
    required DateTime? issuedAt,
    required QuestionStatus status,
    required String? comment,
    required DateTime? resolvedAt,
    required String? appealJuryComment,
  }) =>
      Controversial(
        id: id,
        questionNumber: questionNumber,
        answer: answer,
        issuedAt: issuedAt ?? this.issuedAt,
        status: status,
        comment: comment ?? this.comment,
        resolvedAt: resolvedAt ?? this.resolvedAt,
        appealJuryComment: appealJuryComment ?? this.appealJuryComment,
      );

  factory Controversial.fromRawJson(String str) =>
      Controversial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Controversial.fromJson(Map<String, dynamic> json) => Controversial(
        id: json["id"],
        questionNumber: json["questionNumber"],
        answer: json["answer"],
        issuedAt:
            json["issuedAt"] != null ? DateTime.parse(json["issuedAt"]) : null,
        status: statusValues.map[json["status"]]!,
        comment: json["comment"],
        resolvedAt: json["resolvedAt"] == null
            ? null
            : DateTime.parse(json["resolvedAt"]),
        appealJuryComment: json["appealJuryComment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionNumber": questionNumber,
        "answer": answer,
        "issuedAt": issuedAt?.toIso8601String(),
        "status": statusValues.reverse[status],
        "comment": comment,
        "resolvedAt": resolvedAt == null ? null : resolvedAt?.toIso8601String(),
        "appealJuryComment": appealJuryComment,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Controversial &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          questionNumber == other.questionNumber &&
          answer == other.answer &&
          issuedAt == other.issuedAt &&
          status == other.status &&
          comment == other.comment &&
          resolvedAt == other.resolvedAt &&
          appealJuryComment == other.appealJuryComment;

  @override
  int get hashCode =>
      id.hashCode ^
      questionNumber.hashCode ^
      answer.hashCode ^
      issuedAt.hashCode ^
      status.hashCode ^
      comment.hashCode ^
      resolvedAt.hashCode ^
      appealJuryComment.hashCode;

  @override
  String toString() {
    return 'Controversial{id: $id, questionNumber: $questionNumber, answer: $answer, issuedAt: $issuedAt, status: $status, comment: $comment, resolvedAt: $resolvedAt, appealJuryComment: $appealJuryComment}';
  }
}

class Current {
  Current({
    required this.name,
    required this.town,
  });

  final String name;
  final Town? town;

  Current copyWith({
    required String name,
    required Town town,
  }) =>
      Current(
        name: name,
        town: town,
      );

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        name: json["name"],
        town: json["town"] != null ? Town.fromJson(json["town"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "town": town?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Current &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          town == other.town;

  @override
  int get hashCode => name.hashCode ^ town.hashCode;

  @override
  String toString() {
    return 'Current{name: $name, town: $town}';
  }
}

class Flag {
  Flag({
    required this.id,
    required this.shortName,
    required this.longName,
  });

  final int id;
  final ShortName shortName;
  final String longName;

  Flag copyWith({
    required int id,
    required ShortName shortName,
    required String longName,
  }) =>
      Flag(
        id: id,
        shortName: shortName,
        longName: longName,
      );

  factory Flag.fromRawJson(String str) => Flag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
        id: json["id"],
        shortName: shortNameValues.map[json["shortName"]]!,
        longName: json["longName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shortName": shortNameValues.reverse[shortName],
        "longName": longName,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          shortName == other.shortName &&
          longName == other.longName;

  @override
  int get hashCode => id.hashCode ^ shortName.hashCode ^ longName.hashCode;

  @override
  String toString() {
    return 'Flag{id: $id, shortName: $shortName, longName: $longName}';
  }
}

enum ShortName { CAPTAIN, LEGIONAIRE, BASE }

final EnumValues<ShortName> shortNameValues = EnumValues<ShortName>(
    {"К": ShortName.CAPTAIN, "Б": ShortName.BASE, "Л": ShortName.LEGIONAIRE});

class Rating {
  Rating({
    required this.inRating,
    required this.b,
    required this.predictedPosition,
    required this.rt,
    required this.rb,
    required this.rg,
    required this.r,
    required this.bp,
    required this.d1,
    required this.d2,
    required this.d,
  });

  final bool inRating;
  final int b;
  final double predictedPosition;
  final int rt;
  final int rb;
  final int rg;
  final int r;
  final int bp;
  final int d1;
  final int d2;
  final int d;

  Rating copyWith({
    required bool inRating,
    required int b,
    required double predictedPosition,
    required int rt,
    required int rb,
    required int rg,
    required int r,
    required int bp,
    required int d1,
    required int d2,
    required int d,
  }) =>
      Rating(
        inRating: inRating,
        b: b,
        predictedPosition: predictedPosition,
        rb: rb,
        rt: rt,
        rg: rg,
        r: r,
        bp: bp,
        d1: d1,
        d2: d2,
        d: d,
      );

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        inRating: json["inRating"],
        b: json["b"],
        predictedPosition: json["predictedPosition"].toDouble(),
        rt: json["rt"],
        rb: json["rb"],
        rg: json["rg"],
        r: json["r"],
        bp: json["bp"],
        d1: json["d1"],
        d2: json["d2"],
        d: json["d"],
      );

  Map<String, dynamic> toJson() => {
        "inRating": inRating,
        "b": b,
        "predictedPosition": predictedPosition,
        "rt": rt,
        "rb": rb,
        "rg": rg,
        "r": r,
        "bp": bp,
        "d1": d1,
        "d2": d2,
        "d": d,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rating &&
          runtimeType == other.runtimeType &&
          inRating == other.inRating &&
          b == other.b &&
          predictedPosition == other.predictedPosition &&
          rt == other.rt &&
          rb == other.rb &&
          rg == other.rg &&
          r == other.r &&
          bp == other.bp &&
          d1 == other.d1 &&
          d2 == other.d2 &&
          d == other.d;

  @override
  int get hashCode =>
      inRating.hashCode ^
      b.hashCode ^
      predictedPosition.hashCode ^
      rt.hashCode ^
      rb.hashCode ^
      rg.hashCode ^
      r.hashCode ^
      bp.hashCode ^
      d1.hashCode ^
      d2.hashCode ^
      d.hashCode;

  @override
  String toString() {
    return 'Rating{inRating: $inRating, b: $b, predictedPosition: $predictedPosition, rt: $rt, rb: $rb, rg: $rg, r: $r, bp: $bp, d1: $d1, d2: $d2, d: $d}';
  }
}

class SynchRequest {
  SynchRequest({
    required this.id,
    required this.venue,
    required this.tournamentId,
  });

  final int id;
  final Town? venue;
  final int tournamentId;

  SynchRequest copyWith({
    required int id,
    required Town? venue,
    required int tournamentId,
  }) =>
      SynchRequest(
        id: id,
        venue: venue ?? this.venue,
        tournamentId: tournamentId,
      );

  factory SynchRequest.fromRawJson(String str) =>
      SynchRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SynchRequest.fromJson(Map<String, dynamic> json) => SynchRequest(
        id: json["id"],
        venue: json["venue"] != null ? Town.fromJson(json["venue"]) : null,
        tournamentId: json["tournamentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue": venue?.toJson(),
        "tournamentId": tournamentId,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SynchRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          venue == other.venue &&
          tournamentId == other.tournamentId;

  @override
  int get hashCode => id.hashCode ^ venue.hashCode ^ tournamentId.hashCode;

  @override
  String toString() {
    return 'SynchRequest{id: $id, venue: $venue, tournamentId: $tournamentId}';
  }
}

class TeamMember {
  TeamMember({
    required this.flag,
    required this.usedRating,
    required this.rating,
    required this.player,
  });

  final ShortName? flag;
  final int usedRating;
  final int rating;
  final Player player;

  TeamMember copyWith({
    required ShortName? flag,
    required int usedRating,
    required int rating,
    required Player player,
  }) =>
      TeamMember(
        flag: flag ?? this.flag,
        usedRating: usedRating,
        rating: rating,
        player: player,
      );

  factory TeamMember.fromRawJson(String str) =>
      TeamMember.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        flag: json["flag"] == null ? null : shortNameValues.map[json["flag"]],
        usedRating: json["usedRating"],
        rating: json["rating"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : shortNameValues.reverse[flag],
        "usedRating": usedRating,
        "rating": rating,
        "player": player.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamMember &&
          runtimeType == other.runtimeType &&
          flag == other.flag &&
          usedRating == other.usedRating &&
          rating == other.rating &&
          player == other.player;

  @override
  int get hashCode =>
      flag.hashCode ^ usedRating.hashCode ^ rating.hashCode ^ player.hashCode;

  @override
  String toString() {
    return 'TeamMember{flag: $flag, usedRating: $usedRating, rating: $rating, player: $player}';
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((String k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}

/// [A] - approved, [D] - declined, [N] - new
enum QuestionStatus { A, D, N }

/// [QuestionStatus.A] - approved, [QuestionStatus.D] - declined, [QuestionStatus.N] - new
final EnumValues<QuestionStatus> statusValues =
    EnumValues<QuestionStatus>(<String, QuestionStatus>{
  'A': QuestionStatus.A,
  'D': QuestionStatus.D,
  'N': QuestionStatus.N
});
