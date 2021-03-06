import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// {
/// "idtournament": "5021",
/// "name": "Синхрон-lite. Выпуск XXII",
/// "town": "Варшава",
/// "long_name": "Синхрон-lite. Выпуск XXII",
/// "date_start": "2019-02-08 18:55:00",
/// "date_end": "2019-02-12 18:55:00",
/// "tour_count": "3",
/// "tour_questions": "12",
/// "tour_ques_per_tour": "12",
/// "questions_total": "36",
/// "type_name": "Синхрон",
/// "main_payment_value": "4",
/// "main_payment_currency": "$",
/// "discounted_payment_value": "0",
/// "discounted_payment_currency": "",
/// "discounted_payment_reason": "Школьные и молодёжные команды.",
/// "tournament_in_rating": "1",
/// "date_requests_allowed_to": "2019-02-11 23:59:59",
/// "comment": "Комментарий",
/// "site_url": "https://chgk-is.livejournal.com/",
/// "archive": "1",
/// "date_archived_at": "2019-03-01 23:59:59",
/// "db_tags": ["tag"]
/// }
/// ```
@immutable
class TournamentDetails {
  const TournamentDetails({
    required this.idTournament,
    this.name,
    this.town,
    this.longName,
    this.dateStart,
    this.dateEnd,
    this.tourCount,
    this.tourQuestions,
    this.tourQuesPerTour,
    this.questionsTotal,
    this.typeName,
    this.mainPaymentValue,
    this.mainPaymentCurrency,
    this.discountedPaymentValue,
    this.discountedPaymentCurrency,
    this.discountedPaymentReason,
    this.tournamentInRating,
    this.dateRequestsAllowedTo,
    this.comment,
    this.siteUrl,
    this.archive,
    this.dateArchivedAt,
    this.dbTags,
  });

  final String idTournament;
  final String? name;
  final String? town;
  final String? longName;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final String? tourCount;
  final String? tourQuestions;
  final String? tourQuesPerTour;
  final String? questionsTotal;
  final String? typeName;
  final String? mainPaymentValue;
  final String? mainPaymentCurrency;
  final String? discountedPaymentValue;
  final String? discountedPaymentCurrency;
  final String? discountedPaymentReason;
  final String? tournamentInRating;
  final DateTime? dateRequestsAllowedTo;
  final String? comment;
  final String? siteUrl;
  final String? archive;
  final DateTime? dateArchivedAt;
  final List<String>? dbTags;

  /// Decodes [TournamentDetails] object from json string
  factory TournamentDetails.fromJson(String str) =>
      TournamentDetails.fromMap(json.decode(str));

  /// Encodes [TournamentDetails] object from to string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentDetails] object from json map
  factory TournamentDetails.fromMap(Map<String, dynamic> json) =>
      TournamentDetails(
        idTournament: json['idtournament'] == null ? -1 : json['idtournament'],
        name: json['name'] == null ? null : json['name'],
        town: json['town'] == null ? null : json['town'],
        longName: json['long_name'] == null ? null : json['long_name'],
        dateStart: json['date_start'] == null
            ? null
            : DateTime.parse(json['date_start']),
        dateEnd:
            json['date_end'] == null ? null : DateTime.parse(json['date_end']),
        tourCount: json['tour_count'] == null ? null : json['tour_count'],
        tourQuestions:
            json['tour_questions'] == null ? null : json['tour_questions'],
        tourQuesPerTour: json['tour_ques_per_tour'] == null
            ? null
            : json['tour_ques_per_tour'],
        questionsTotal:
        json['questions_total'] == null ? null : json['questions_total'],
        typeName: json['type_name'] == null ? null : json['type_name'],
        mainPaymentValue: json['main_payment_value'] == null
            ? null
            : json['main_payment_value'],
        mainPaymentCurrency: json['main_payment_currency'] == null
            ? null
            : json['main_payment_currency'],
        discountedPaymentValue: json['discounted_payment_value'] == null
            ? null
            : json['discounted_payment_value'],
        discountedPaymentCurrency: json['discounted_payment_currency'] == null
            ? null
            : json['discounted_payment_currency'],
        discountedPaymentReason: json['discounted_payment_reason'] == null
            ? null
            : json['discounted_payment_reason'],
        tournamentInRating: json['tournament_in_rating'] == null
            ? null
            : json['tournament_in_rating'],
        dateRequestsAllowedTo: json['date_requests_allowed_to'] == null
            ? null
            : DateTime.parse(json['date_requests_allowed_to']),
        comment: json['comment'] == null ? null : json['comment'],
        siteUrl: json['site_url'] == null ? null : json['site_url'],
        archive: json['archive'] == null ? null : json['archive'],
        dateArchivedAt: json['date_archived_at'] == null
            ? null
            : DateTime.parse(json['date_archived_at']),
        dbTags: json['db_tags'] == null
            ? null
            : List<String>.from(json['db_tags'].map((x) => x)),
      );

  /// Encodes [TournamentDetails] object to json map
  Map<String, dynamic> toMap() =>
      {
        'idtournament': idTournament,
        'name': name == null ? null : name,
        'town': town == null ? null : town,
        'long_name': longName == null ? null : longName,
        'date_start': dateStart == null ? null : dateStart?.toIso8601String(),
        'date_end': dateEnd == null ? null : dateEnd?.toIso8601String(),
        'tour_count': tourCount == null ? null : tourCount,
        'tour_questions': tourQuestions == null ? null : tourQuestions,
        'tour_ques_per_tour': tourQuesPerTour == null ? null : tourQuesPerTour,
        'questions_total': questionsTotal == null ? null : questionsTotal,
        'type_name': typeName == null ? null : typeName,
        'main_payment_value':
        mainPaymentValue == null ? null : mainPaymentValue,
        'main_payment_currency':
        mainPaymentCurrency == null ? null : mainPaymentCurrency,
        'discounted_payment_value':
        discountedPaymentValue == null ? null : discountedPaymentValue,
        'discounted_payment_currency': discountedPaymentCurrency == null
            ? null
            : discountedPaymentCurrency,
        'discounted_payment_reason':
        discountedPaymentReason == null ? null : discountedPaymentReason,
        'tournament_in_rating':
        tournamentInRating == null ? null : tournamentInRating,
        'date_requests_allowed_to': dateRequestsAllowedTo == null
            ? null
            : dateRequestsAllowedTo?.toIso8601String(),
        'comment': comment == null ? null : comment,
        'site_url': siteUrl == null ? null : siteUrl,
        'archive': archive == null ? null : archive,
        'date_archived_at':
            dateArchivedAt == null ? null : dateArchivedAt?.toIso8601String(),
        'db_tags': dbTags == null ? null : dbTags,
      };

  @override
  String toString() {
    return 'TournamentDetails{idTournament: $idTournament, name: $name, town: $town, longName: $longName, dateStart: $dateStart, dateEnd: $dateEnd, tourCount: $tourCount, tourQuestions: $tourQuestions, tourQuesPerTour: $tourQuesPerTour, questionsTotal: $questionsTotal, typeName: $typeName, mainPaymentValue: $mainPaymentValue, mainPaymentCurrency: $mainPaymentCurrency, discountedPaymentValue: $discountedPaymentValue, discountedPaymentCurrency: $discountedPaymentCurrency, discountedPaymentReason: $discountedPaymentReason, tournamentInRating: $tournamentInRating, dateRequestsAllowedTo: $dateRequestsAllowedTo, comment: $comment, siteUrl: $siteUrl, archive: $archive, dateArchivedAt: $dateArchivedAt, dbTags: $dbTags}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentDetails &&
          runtimeType == other.runtimeType &&
          idTournament == other.idTournament &&
          name == other.name &&
          town == other.town &&
          longName == other.longName &&
          dateStart == other.dateStart &&
          dateEnd == other.dateEnd &&
          tourCount == other.tourCount &&
          tourQuestions == other.tourQuestions &&
          tourQuesPerTour == other.tourQuesPerTour &&
          questionsTotal == other.questionsTotal &&
          typeName == other.typeName &&
          mainPaymentValue == other.mainPaymentValue &&
          mainPaymentCurrency == other.mainPaymentCurrency &&
          discountedPaymentValue == other.discountedPaymentValue &&
          discountedPaymentCurrency == other.discountedPaymentCurrency &&
          discountedPaymentReason == other.discountedPaymentReason &&
          tournamentInRating == other.tournamentInRating &&
          dateRequestsAllowedTo == other.dateRequestsAllowedTo &&
          comment == other.comment &&
          siteUrl == other.siteUrl &&
          archive == other.archive &&
          dateArchivedAt == other.dateArchivedAt &&
          dbTags == other.dbTags;

  @override
  int get hashCode =>
      idTournament.hashCode ^
      name.hashCode ^
      town.hashCode ^
      longName.hashCode ^
      dateStart.hashCode ^
      dateEnd.hashCode ^
      tourCount.hashCode ^
      tourQuestions.hashCode ^
      tourQuesPerTour.hashCode ^
      questionsTotal.hashCode ^
      typeName.hashCode ^
      mainPaymentValue.hashCode ^
      mainPaymentCurrency.hashCode ^
      discountedPaymentValue.hashCode ^
      discountedPaymentCurrency.hashCode ^
      discountedPaymentReason.hashCode ^
      tournamentInRating.hashCode ^
      dateRequestsAllowedTo.hashCode ^
      comment.hashCode ^
      siteUrl.hashCode ^
      archive.hashCode ^
      dateArchivedAt.hashCode ^
      dbTags.hashCode;
}
