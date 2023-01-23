import 'dart:convert';

import 'package:chgk_rating/chgk_rating.dart';
import 'package:collection/collection.dart';

/// Tournament response example:
/// ```json
/// {
///     "id": 3779,
///     "name": "Балтийский берег. 5 игра",
///     "lastEditDate": "2017-05-02T00:00:00+03:00",
///     "dateStart": "2017-04-21T19:05:00+03:00",
///     "dateEnd": "2017-04-25T19:00:00+03:00",
///     "type": {
///         "id": 3,
///         "name": "Синхрон"
///     },
///     "season": "/seasons/50",
///     "orgcommittee": [
///         {
///             "id": 23030,
///             "name": "Марина",
///             "patronymic": "",
///             "surname": "Ножнина"
///         }
///     ],
///     "synchData": {
///         "dateRequestsAllowedTo": "2017-04-24T23:59:59+03:00",
///         "resultFixesTo": "2017-05-08T23:59:59+03:00",
///         "resultsRecapsTo": "2017-04-27T23:59:59+03:00",
///         "allowAppealCancel": true,
///         "allowNarratorErrorAppeal": false,
///         "archive": true,
///         "dateArchivedAt": "2017-05-12T23:59:59+03:00",
///         "dateDownloadQuestionsFrom": "2017-04-20T00:00:00+03:00",
///         "dateDownloadQuestionsTo": "2017-04-25T19:00:00+03:00",
///         "hideQuestionsTo": "2017-04-25T23:59:59+03:00",
///         "hideResultsTo": "2017-04-25T23:59:59+03:00",
///         "allVerdictsDone": null,
///         "instantControversial": false
///     },
///     "mainPayment": 2,
///     "discountedPayment": 0,
///     "discountedPaymentReason": "Максимальная плата, которая взимается с игровой площадки за все пять игр Турнира, равна 200 EUR. ",
///     "currency": "e",
///     "editors": [
///         {
///             "id": 32118,
///             "name": "Алексей",
///             "patronymic": "Владиславович",
///             "surname": "Трефилов"
///         },
///         {
///             "id": 32124,
///             "name": "Мария",
///             "patronymic": "Алексеевна",
///             "surname": "Трефилова"
///         }
///     ],
///     "difficultyForecast": 0,
///     "maiiAegis": false,
///     "maiiAegisUpdatedAt": "2021-09-19T05:29:28.938689Z",
///     "maiiRating": false,
///     "maiiRatingUpdatedAt": "2021-09-19T05:29:28.938689Z",
///     "questionQty": {
///         "1": 12,
///         "2": 12,
///         "3": 12
///     }
/// }
/// ```
class Tournament {
  Tournament({
    required this.id,
    required this.name,
    required this.lastEditDate,
    required this.dateStart,
    required this.dateEnd,
    required this.type,
    required this.season,
    required this.orgCommittee,
    required this.syncData,
    required this.mainPayment,
    required this.discountedPayment,
    required this.discountedPaymentReason,
    required this.currency,
    required this.editors,
    required this.difficultyForecast,
    required this.maiiAegis,
    required this.maiiAegisUpdatedAt,
    required this.maiiRating,
    required this.maiiRatingUpdatedAt,
    required this.questionQty,
  });

  final int id;
  final String name;
  final DateTime lastEditDate;
  final DateTime dateStart;
  final DateTime dateEnd;
  final Type? type;
  final String? season;
  final List<Player> orgCommittee;
  final SynchData? syncData;
  final int? mainPayment;
  final int? discountedPayment;
  final String? discountedPaymentReason;
  final String currency;
  final List<Player> editors;
  final int? difficultyForecast;
  final bool maiiAegis;
  final DateTime? maiiAegisUpdatedAt;
  final bool maiiRating;
  final DateTime? maiiRatingUpdatedAt;
  final Map<String, int>? questionQty;

  Tournament copyWith({
    required int id,
    required String name,
    required DateTime lastEditDate,
    required DateTime dateStart,
    required DateTime dateEnd,
    required Type? type,
    required String? season,
    required List<Player> orgcommittee,
    required SynchData? synchData,
    required int? mainPayment,
    required int? discountedPayment,
    required String? discountedPaymentReason,
    required String currency,
    required List<Player> editors,
    required int? difficultyForecast,
    required bool maiiAegis,
    required DateTime? maiiAegisUpdatedAt,
    required bool maiiRating,
    required DateTime? maiiRatingUpdatedAt,
    required Map<String, int>? questionQty,
  }) =>
      Tournament(
        id: id,
        name: name,
        lastEditDate: lastEditDate,
        dateStart: dateStart,
        dateEnd: dateEnd,
        type: type,
        season: season,
        orgCommittee: orgcommittee,
        syncData: synchData,
        mainPayment: mainPayment,
        discountedPayment: discountedPayment,
        discountedPaymentReason: discountedPaymentReason,
        currency: currency,
        editors: editors,
        difficultyForecast: difficultyForecast,
        maiiAegis: maiiAegis,
        maiiAegisUpdatedAt: maiiAegisUpdatedAt,
        maiiRating: maiiRating,
        maiiRatingUpdatedAt: maiiRatingUpdatedAt,
        questionQty: questionQty,
      );

  factory Tournament.fromRawJson(String str) =>
      Tournament.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        id: json["id"],
        name: json["name"],
        lastEditDate: DateTime.parse(json["lastEditDate"]),
        dateStart: DateTime.parse(json["dateStart"]),
        dateEnd: DateTime.parse(json["dateEnd"]),
        type: json["type"] != null ? Type.fromJson(json["type"]) : null,
        season: json["season"],
        orgCommittee: json["orgcommittee"] != null
            ? List<Player>.from(
                json["orgcommittee"].map((x) => Player.fromJson(x)))
            : <Player>[],
        syncData: json["synchData"] != null
            ? SynchData.fromJson(json["synchData"])
            : null,
        mainPayment: json["mainPayment"],
        discountedPayment: json["discountedPayment"],
        discountedPaymentReason: json["discountedPaymentReason"],
        currency: json["currency"],
        editors: json["editors"] != null
            ? List<Player>.from(json["editors"].map((x) => Player.fromJson(x)))
            : <Player>[],
        difficultyForecast: json["difficultyForecast"],
        maiiAegis: json["maiiAegis"],
        maiiAegisUpdatedAt: json["maiiAegisUpdatedAt"] != null
            ? DateTime.parse(json["maiiAegisUpdatedAt"])
            : null,
        maiiRating: json["maiiRating"],
        maiiRatingUpdatedAt: json["maiiRatingUpdatedAt"] != null
            ? DateTime.parse(json["maiiRatingUpdatedAt"])
            : null,
        questionQty: json["questionQty"] != null
            ? Map.from(json["questionQty"])
                .map((k, v) => MapEntry<String, int>(k, v))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastEditDate": lastEditDate.toIso8601String(),
        "dateStart": dateStart.toIso8601String(),
        "dateEnd": dateEnd.toIso8601String(),
        "type": type?.toJson(),
        "season": season,
        "orgcommittee": List<dynamic>.from(orgCommittee.map((x) => x.toJson())),
        "synchData": syncData?.toJson(),
        "mainPayment": mainPayment,
        "discountedPayment": discountedPayment,
        "discountedPaymentReason": discountedPaymentReason,
        "currency": currency,
        "editors": List<dynamic>.from(editors.map((x) => x.toJson())),
        "difficultyForecast": difficultyForecast,
        "maiiAegis": maiiAegis,
        "maiiAegisUpdatedAt": maiiAegisUpdatedAt?.toIso8601String(),
        "maiiRating": maiiRating,
        "maiiRatingUpdatedAt": maiiRatingUpdatedAt?.toIso8601String(),
        "questionQty": questionQty != null
            ? Map.from(questionQty!)
                .map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
      };

  static Iterable<Tournament> decodeList(List<dynamic> list) =>
      list.map((dynamic e) => Tournament.fromJson(e));

  @override
  bool operator ==(Object other) {
    final Function eq = const DeepCollectionEquality().equals;
    return identical(this, other) ||
        other is Tournament &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            lastEditDate == other.lastEditDate &&
            dateStart == other.dateStart &&
            dateEnd == other.dateEnd &&
            type == other.type &&
            season == other.season &&
            eq(orgCommittee, other.orgCommittee) &&
            syncData == other.syncData &&
            mainPayment == other.mainPayment &&
            discountedPayment == other.discountedPayment &&
            discountedPaymentReason == other.discountedPaymentReason &&
            currency == other.currency &&
            eq(editors, other.editors) &&
            difficultyForecast == other.difficultyForecast &&
            maiiAegis == other.maiiAegis &&
            maiiAegisUpdatedAt == other.maiiAegisUpdatedAt &&
            maiiRating == other.maiiRating &&
            maiiRatingUpdatedAt == other.maiiRatingUpdatedAt &&
            eq(questionQty, other.questionQty);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      lastEditDate.hashCode ^
      dateStart.hashCode ^
      dateEnd.hashCode ^
      type.hashCode ^
      season.hashCode ^
      orgCommittee.hashCode ^
      syncData.hashCode ^
      mainPayment.hashCode ^
      discountedPayment.hashCode ^
      discountedPaymentReason.hashCode ^
      currency.hashCode ^
      editors.hashCode ^
      difficultyForecast.hashCode ^
      maiiAegis.hashCode ^
      maiiAegisUpdatedAt.hashCode ^
      maiiRating.hashCode ^
      maiiRatingUpdatedAt.hashCode ^
      questionQty.hashCode;

  @override
  String toString() {
    return 'Tournament{id: $id, name: $name, lastEditDate: $lastEditDate, dateStart: $dateStart, dateEnd: $dateEnd, type: $type, season: $season, orgCommittee: $orgCommittee, syncData: $syncData, mainPayment: $mainPayment, discountedPayment: $discountedPayment, discountedPaymentReason: $discountedPaymentReason, currency: $currency, editors: $editors, difficultyForecast: $difficultyForecast, maiiAegis: $maiiAegis, maiiAegisUpdatedAt: $maiiAegisUpdatedAt, maiiRating: $maiiRating, maiiRatingUpdatedAt: $maiiRatingUpdatedAt, questionQty: $questionQty}';
  }
}

/// SynchData data model
/// ```json
/// {
///   "dateRequestsAllowedTo": "2017-04-24T23:59:59+03:00",
///   "resultFixesTo": "2017-05-08T23:59:59+03:00",
///   "resultsRecapsTo": "2017-04-27T23:59:59+03:00",
///   "allowAppealCancel": true,
///   "allowNarratorErrorAppeal": false,
///   "archive": true,
///   "dateArchivedAt": "2017-05-12T23:59:59+03:00",
///   "dateDownloadQuestionsFrom": "2017-04-20T00:00:00+03:00",
///   "dateDownloadQuestionsTo": "2017-04-25T19:00:00+03:00",
///   "hideQuestionsTo": "2017-04-25T23:59:59+03:00",
///   "hideResultsTo": "2017-04-25T23:59:59+03:00",
///   "allVerdictsDone": null,
///   "instantControversial": false
/// }
/// ```
class SynchData {
  SynchData({
    required this.dateRequestsAllowedTo,
    required this.resultFixesTo,
    required this.resultsRecapsTo,
    required this.allowAppealCancel,
    required this.allowNarratorErrorAppeal,
    required this.archive,
    required this.dateArchivedAt,
    required this.dateDownloadQuestionsFrom,
    required this.dateDownloadQuestionsTo,
    required this.hideQuestionsTo,
    required this.hideResultsTo,
    required this.allVerdictsDone,
    required this.instantControversial,
  });

  final DateTime? dateRequestsAllowedTo;
  final DateTime? resultFixesTo;
  final DateTime? resultsRecapsTo;
  final bool allowAppealCancel;
  final bool? allowNarratorErrorAppeal;
  final bool archive;
  final DateTime? dateArchivedAt;
  final DateTime? dateDownloadQuestionsFrom;
  final DateTime? dateDownloadQuestionsTo;
  final DateTime? hideQuestionsTo;
  final DateTime? hideResultsTo;
  final DateTime? allVerdictsDone;
  final bool instantControversial;

  SynchData copyWith({
    required DateTime? dateRequestsAllowedTo,
    required DateTime? resultFixesTo,
    required DateTime? resultsRecapsTo,
    required bool allowAppealCancel,
    required bool? allowNarratorErrorAppeal,
    required bool archive,
    required DateTime? dateArchivedAt,
    required DateTime? dateDownloadQuestionsFrom,
    required DateTime? dateDownloadQuestionsTo,
    required DateTime? hideQuestionsTo,
    required DateTime? hideResultsTo,
    required DateTime? allVerdictsDone,
    required bool instantControversial,
  }) =>
      SynchData(
        dateRequestsAllowedTo: dateRequestsAllowedTo,
        resultFixesTo: resultFixesTo,
        resultsRecapsTo: resultsRecapsTo,
        allowAppealCancel: allowAppealCancel,
        allowNarratorErrorAppeal: allowNarratorErrorAppeal,
        archive: archive,
        dateArchivedAt: dateArchivedAt,
        dateDownloadQuestionsFrom: dateDownloadQuestionsFrom,
        dateDownloadQuestionsTo: dateDownloadQuestionsTo,
        hideQuestionsTo: hideQuestionsTo,
        hideResultsTo: hideResultsTo,
        allVerdictsDone: allVerdictsDone,
        instantControversial: instantControversial,
      );

  factory SynchData.fromRawJson(String str) =>
      SynchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SynchData.fromJson(Map<String, dynamic> json) => SynchData(
        dateRequestsAllowedTo: json["dateRequestsAllowedTo"] != null
            ? DateTime.parse(json["dateRequestsAllowedTo"])
            : null,
        resultFixesTo: json["resultFixesTo"] != null
            ? DateTime.parse(json["resultFixesTo"])
            : null,
        resultsRecapsTo: json["resultsRecapsTo"] != null
            ? DateTime.parse(json["resultsRecapsTo"])
            : null,
        allowAppealCancel: json["allowAppealCancel"],
        allowNarratorErrorAppeal: json["allowNarratorErrorAppeal"],
        archive: json["archive"],
        dateArchivedAt: json["dateArchivedAt"] != null
            ? DateTime.parse(json["dateArchivedAt"])
            : null,
        dateDownloadQuestionsFrom: json["dateDownloadQuestionsFrom"] != null
            ? DateTime.parse(json["dateDownloadQuestionsFrom"])
            : null,
        dateDownloadQuestionsTo: json["dateDownloadQuestionsTo"] != null
            ? DateTime.parse(json["dateDownloadQuestionsTo"])
            : null,
        hideQuestionsTo: json["hideQuestionsTo"] != null
            ? DateTime.parse(json["hideQuestionsTo"])
            : null,
        hideResultsTo: json["hideResultsTo"] != null
            ? DateTime.parse(json["hideResultsTo"])
            : null,
        allVerdictsDone: json["allVerdictsDone"] != null
            ? DateTime.parse(json["allVerdictsDone"])
            : null,
        instantControversial: json["instantControversial"],
      );

  Map<String, dynamic> toJson() => {
        "dateRequestsAllowedTo": dateRequestsAllowedTo?.toIso8601String(),
        "resultFixesTo": resultFixesTo?.toIso8601String(),
        "resultsRecapsTo": resultsRecapsTo?.toIso8601String(),
        "allowAppealCancel": allowAppealCancel,
        "allowNarratorErrorAppeal": allowNarratorErrorAppeal,
        "archive": archive,
        "dateArchivedAt": dateArchivedAt?.toIso8601String(),
        "dateDownloadQuestionsFrom":
            dateDownloadQuestionsFrom?.toIso8601String(),
        "dateDownloadQuestionsTo": dateDownloadQuestionsTo?.toIso8601String(),
        "hideQuestionsTo": hideQuestionsTo?.toIso8601String(),
        "hideResultsTo": hideResultsTo?.toIso8601String(),
        "allVerdictsDone": allVerdictsDone?.toIso8601String(),
        "instantControversial": instantControversial,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SynchData &&
          runtimeType == other.runtimeType &&
          dateRequestsAllowedTo == other.dateRequestsAllowedTo &&
          resultFixesTo == other.resultFixesTo &&
          resultsRecapsTo == other.resultsRecapsTo &&
          allowAppealCancel == other.allowAppealCancel &&
          allowNarratorErrorAppeal == other.allowNarratorErrorAppeal &&
          archive == other.archive &&
          dateArchivedAt == other.dateArchivedAt &&
          dateDownloadQuestionsFrom == other.dateDownloadQuestionsFrom &&
          dateDownloadQuestionsTo == other.dateDownloadQuestionsTo &&
          hideQuestionsTo == other.hideQuestionsTo &&
          hideResultsTo == other.hideResultsTo &&
          allVerdictsDone == other.allVerdictsDone &&
          instantControversial == other.instantControversial;

  @override
  int get hashCode =>
      dateRequestsAllowedTo.hashCode ^
      resultFixesTo.hashCode ^
      resultsRecapsTo.hashCode ^
      allowAppealCancel.hashCode ^
      allowNarratorErrorAppeal.hashCode ^
      archive.hashCode ^
      dateArchivedAt.hashCode ^
      dateDownloadQuestionsFrom.hashCode ^
      dateDownloadQuestionsTo.hashCode ^
      hideQuestionsTo.hashCode ^
      hideResultsTo.hashCode ^
      allVerdictsDone.hashCode ^
      instantControversial.hashCode;

  @override
  String toString() {
    return 'SynchData{dateRequestsAllowedTo: $dateRequestsAllowedTo, resultFixesTo: $resultFixesTo, resultsRecapsTo: $resultsRecapsTo, allowAppealCancel: $allowAppealCancel, allowNarratorErrorAppeal: $allowNarratorErrorAppeal, archive: $archive, dateArchivedAt: $dateArchivedAt, dateDownloadQuestionsFrom: $dateDownloadQuestionsFrom, dateDownloadQuestionsTo: $dateDownloadQuestionsTo, hideQuestionsTo: $hideQuestionsTo, hideResultsTo: $hideResultsTo, allVerdictsDone: $allVerdictsDone, instantControversial: $instantControversial}';
  }
}

/// Tournament type data model
/// ```json
/// {
///   "id": 3,
///   "name": "Синхрон"
/// }
/// ```
class Type {
  Type({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  Type copyWith({
    required int id,
    required String name,
  }) =>
      Type(
        id: id,
        name: name,
      );

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
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
      other is Type &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Type{id: $id, name: $name}';
  }
}
