import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/tournament_results.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chgk_rating_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final DateTime dateTime = DateTime.parse('2021-12-21T23:59:06+03:00');
  final Player mockPlayer = Player(
      id: 14544, name: 'name', patronymic: 'patronymic', surname: 'surname');
  final Tournament mockTournamentDetails = Tournament(
      id: 5027,
      name: 'name',
      lastEditDate: dateTime,
      dateStart: dateTime,
      dateEnd: dateTime,
      type: Type(id: 3, name: 'Синхрон'),
      season: '/seasons/56',
      orgCommittee: <Player>[mockPlayer],
      syncData: SynchData(
          dateRequestsAllowedTo: dateTime,
          resultFixesTo: dateTime,
          resultsRecapsTo: dateTime,
          allowAppealCancel: false,
          allowNarratorErrorAppeal: false,
          archive: false,
          dateArchivedAt: dateTime,
          dateDownloadQuestionsFrom: dateTime,
          dateDownloadQuestionsTo: dateTime,
          hideQuestionsTo: dateTime,
          hideResultsTo: dateTime,
          allVerdictsDone: dateTime,
          instantControversial: false),
      mainPayment: 450,
      discountedPayment: 0,
      discountedPaymentReason: 'Школьные команды',
      currency: 'currency',
      editors: <Player>[mockPlayer],
      difficultyForecast: 4,
      maiiAegis: false,
      maiiAegisUpdatedAt: dateTime,
      maiiRating: false,
      maiiRatingUpdatedAt: dateTime,
      questionQty: {'1': 12, '2': 12});
  final DioError notFoundError = DioError(
      requestOptions: RequestOptions(path: ''),
      response: Response<dynamic>(
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));
  final MockDio mockDio = MockDio();
  final TournamentResults mockTournamentResults = TournamentResults(
      team: Team(
        id: 26777,
        name: 'name',
        town: Town(id: 197, name: 'name', region: null, country: null),
      ),
      mask: "110101001101101111000000000101001000",
      current: Current(
          name: 'name',
          town: Town(id: 197, name: 'name', region: null, country: null)),
      questionsTotal: 15,
      synchRequest: SynchRequest(
          id: 32635,
          venue: Town(id: 197, name: 'name', region: null, country: null),
          tournamentId: 3779),
      rating: Rating(
          inRating: false,
          b: 705,
          predictedPosition: 57,
          rt: 4464,
          rb: 0,
          rg: 4464,
          r: 0,
          bp: 1041,
          d1: -168,
          d2: 3,
          d: -83),
      position: 207,
      controversials: [
        Controversial(
            id: 55357,
            questionNumber: 9,
            answer: 'answer',
            issuedAt: dateTime,
            status: QuestionStatus.D,
            comment: 'Comment',
            resolvedAt: dateTime,
            appealJuryComment: 'jury comment')
      ],
      flags: [
        Flag(id: 11, shortName: ShortName.BASE, longName: 'Long name')
      ],
      teamMembers: [
        TeamMember(
            flag: ShortName.CAPTAIN,
            usedRating: 2149,
            rating: 2154,
            player: mockPlayer)
      ]);

  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('getTournamentDetails', () {
    test('success', () async {
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}')).thenAnswer(
          (_) async => Response<String>(
              data: mockTournamentDetails.toRawJson(),
              requestOptions: RequestOptions(path: '')));
      final Tournament? tournament =
          await chgkRating.getTournamentDetails(mockTournamentDetails.id);
      expect(tournament, mockTournamentDetails);
    });

    test('empty', () async {
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}'))
          .thenThrow(notFoundError);
      final Tournament? tournamentDetails =
          await chgkRating.getTournamentDetails(mockTournamentDetails.id);
      expect(tournamentDetails, null);
    });
  });

  group('getTournamentBy search parameters', () {
    test('success', () async {
      final Iterable<Tournament> mockTournamentSearch = [mockTournamentDetails];
      when(mockDio.get('/tournaments', queryParameters: <String, dynamic>{
        'name': mockTournamentDetails.name,
        'type': mockTournamentDetails.type?.name
      })).thenAnswer((_) async => Response<List<String>>(
          data: <String>[mockTournamentDetails.toRawJson()],
          requestOptions: RequestOptions(path: '')));
      final Iterable<Tournament> tournamentSearch =
          await chgkRating.getTournamentBy(
              name: mockTournamentDetails.name,
              typeName: mockTournamentDetails.type?.name);
      expect(tournamentSearch, mockTournamentSearch);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      final Iterable<TournamentResults> tournamentTeamResults = [
        mockTournamentResults
      ];
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}/results'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <String>[mockTournamentResults.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentResults> tournamentTeamResultsList =
          await chgkRating.getTournamentResults(mockTournamentDetails.id);
      expect(tournamentTeamResultsList.first, tournamentTeamResults.first);
    });

    test('empty', () async {
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}/results'))
          .thenThrow(notFoundError);
      final Iterable<TournamentResults> tournamentDetails =
          await chgkRating.getTournamentResults(mockTournamentDetails.id);
      expect(tournamentDetails, <TournamentResults>[]);
    });
  });

  // group('getTournamentTeamPlayersByTeam', () {
  //   test('success', () async {
  //     const TournamentTeamPlayer mockTournamentTeamPlayer =
  //         TournamentTeamPlayer();
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps/${mockTeam.idTeam}'))
  //         .thenAnswer((_) async => Response<List<dynamic>>(
  //             data: <Map<String, dynamic>>[mockTournamentTeamPlayer.toMap()],
  //             requestOptions: RequestOptions(path: '')));
  //     final Iterable<TournamentTeamPlayer> tournamentTeamPlayer =
  //         await chgkRating.getTournamentTeamPlayersByTeam(
  //             mockTournament.idTournament, mockTeam.idTeam);
  //     expect(tournamentTeamPlayer,
  //         <TournamentTeamPlayer>[mockTournamentTeamPlayer]);
  //   });
  //
  //   test('empty', () async {
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps/${mockTeam.idTeam}'))
  //         .thenThrow(notFoundError);
  //     final Iterable<TournamentTeamPlayer> tournamentTeamPlayer =
  //         await chgkRating.getTournamentTeamPlayersByTeam(
  //             mockTournament.idTournament, mockTeam.idTeam);
  //     expect(tournamentTeamPlayer, <TournamentTeamResults>[]);
  //   });
  //
  //   test('edge fail', () async {
  //     try {
  //       await chgkRating.getTournamentTeamPlayersByTeam(' ', ' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  //
  //   test('corner tournament fail', () async {
  //     try {
  //       await chgkRating.getTournamentTeamPlayersByTeam(
  //           mockTournament.idTournament, ' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  //
  //   test('corner team fail', () async {
  //     try {
  //       await chgkRating.getTournamentTeamPlayersByTeam(' ', mockTeam.idTeam);
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  // });
  //
  // group('getTournamentTeamPlayers', () {
  //   test('success', () async {
  //     const TournamentTeam mockTournamentTeam = TournamentTeam();
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps'))
  //         .thenAnswer((_) async => Response<List<dynamic>>(
  //             data: <Map<String, dynamic>>[mockTournamentTeam.toMap()],
  //             requestOptions: RequestOptions(path: '')));
  //     final Iterable<TournamentTeam> tournamentTeam = await chgkRating
  //         .getTournamentTeamPlayers(mockTournament.idTournament);
  //     expect(tournamentTeam, <TournamentTeam>[mockTournamentTeam]);
  //   });
  //
  //   test('empty', () async {
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps'))
  //         .thenThrow(notFoundError);
  //     final Iterable<TournamentTeam> tournamentTeam = await chgkRating
  //         .getTournamentTeamPlayers(mockTournament.idTournament);
  //     expect(tournamentTeam, <TournamentTeam>[]);
  //   });
  //
  //   test('fail', () async {
  //     try {
  //       await chgkRating.getTournamentTeamPlayers(' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  // });
  //
  // group('getTournamentResultsByTeam', () {
  //   test('success', () async {
  //     const TournamentResults mockTournamentResults = TournamentResults();
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/results/${mockTeam.idTeam}'))
  //         .thenAnswer((_) async => Response<List<dynamic>>(
  //             data: <Map<String, dynamic>>[mockTournamentResults.toMap()],
  //             requestOptions: RequestOptions(path: '')));
  //     final Iterable<TournamentResults> tournamentResults =
  //         await chgkRating.getTournamentResultsByTeam(
  //             mockTournament.idTournament, mockTeam.idTeam);
  //     expect(tournamentResults, <TournamentResults>[mockTournamentResults]);
  //   });
  //
  //   test('empty', () async {
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/results/${mockTeam.idTeam}'))
  //         .thenThrow(notFoundError);
  //     final Iterable<TournamentResults> tournamentResults =
  //         await chgkRating.getTournamentResultsByTeam(
  //             mockTournament.idTournament, mockTeam.idTeam);
  //     expect(tournamentResults, <TournamentResults>[]);
  //   });
  //
  //   test('edge fail', () async {
  //     try {
  //       await chgkRating.getTournamentResultsByTeam(' ', ' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  //
  //   test('corner tournament fail', () async {
  //     try {
  //       await chgkRating.getTournamentResultsByTeam(
  //           mockTournament.idTournament, ' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  //
  //   test('corner team fail', () async {
  //     try {
  //       await chgkRating.getTournamentResultsByTeam(' ', mockTeam.idTeam);
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  // });
  //
  // group('getTournamentControversialQuestions', () {
  //   test('success', () async {
  //     const TournamentControversial mockTournamentControversial =
  //         TournamentControversial();
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/controversials'))
  //         .thenAnswer((_) async => Response<List<dynamic>>(
  //             data: <Map<String, dynamic>>[mockTournamentControversial.toMap()],
  //             requestOptions: RequestOptions(path: '')));
  //     final Iterable<TournamentControversial> controversials = await chgkRating
  //         .getTournamentControversialQuestions(mockTournament.idTournament);
  //     expect(controversials,
  //         <TournamentControversial>[mockTournamentControversial]);
  //   });
  //
  //   test('empty', () async {
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/controversials'))
  //         .thenThrow(notFoundError);
  //     final Iterable<TournamentControversial> controversials = await chgkRating
  //         .getTournamentControversialQuestions(mockTournament.idTournament);
  //     expect(controversials, <TournamentControversial>[]);
  //   });
  //
  //   test('fail', () async {
  //     try {
  //       await chgkRating.getTournamentControversialQuestions(' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  // });
  //
  // group('getTournamentAppealQuestions', () {
  //   test('success', () async {
  //     const TournamentAppeal mockTournamentAppeal = TournamentAppeal();
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/appeals'))
  //         .thenAnswer((_) async => Response<List<dynamic>>(
  //             data: <Map<String, dynamic>>[mockTournamentAppeal.toMap()],
  //             requestOptions: RequestOptions(path: '')));
  //     final Iterable<TournamentAppeal> appeal = await chgkRating
  //         .getTournamentAppealQuestions(mockTournament.idTournament);
  //     expect(appeal, <TournamentAppeal>[mockTournamentAppeal]);
  //   });
  //
  //   test('empty', () async {
  //     when(mockDio.get(
  //             '/tournaments.$extensionJson/${mockTournament.idTournament}/appeals'))
  //         .thenThrow(notFoundError);
  //     final Iterable<TournamentAppeal> appeal = await chgkRating
  //         .getTournamentAppealQuestions(mockTournament.idTournament);
  //     expect(appeal, <TournamentAppeal>[]);
  //   });
  //
  //   test('fail', () async {
  //     try {
  //       await chgkRating.getTournamentAppealQuestions(' ');
  //     } on FormatException catch (e) {
  //       assert(e is FormatException);
  //     }
  //   });
  // });
}
