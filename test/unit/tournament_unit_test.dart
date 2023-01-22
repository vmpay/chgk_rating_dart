import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/error_response.dart';
import 'package:chgk_rating/src/models/tournament_appeals.dart';
import 'package:chgk_rating/src/models/tournament_requests.dart';
import 'package:chgk_rating/src/models/tournament_results.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'player_unit_test.mocks.dart';

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
        data:
            '{"type":"https:\/\/tools.ietf.org\/html\/rfc2616#section-10","title":"An error occurred","detail":"Not Found"}',
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
  final ErrorResponse errorResponse = ErrorResponse(
      type: 'https:\/\/tools.ietf.org\/html\/rfc2616#section-10',
      title: 'An error occurred',
      detail: 'Not Found');

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
      expect(() => chgkRating.getTournamentDetails(mockTournamentDetails.id),
          throwsA(predicate((e) => e is ErrorResponse && e == errorResponse)));
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
      expect(() => chgkRating.getTournamentResults(mockTournamentDetails.id),
          throwsA(predicate((e) => e is ErrorResponse && e == errorResponse)));
    });
  });

  group('getTournament Appeal Questions', () {
    test('success', () async {
      final TournamentAppeals mockTournamentAppeal = TournamentAppeals(
          id: 5811,
          idTournament: mockTournamentDetails.id,
          type: AppealType.A,
          issuedAt: null,
          status: QuestionStatus.D,
          appeal: null,
          comment: null,
          overriddenBy: null,
          questionNumber: 29,
          answer: null);
      final Iterable<TournamentAppeals> mockTournamentAppeals = [
        mockTournamentAppeal
      ];
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}/appeals'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockTournamentAppeal.toJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentAppeals> tournamentAppeals =
          await chgkRating.getTournamentAppeals(mockTournamentDetails.id);
      expect(tournamentAppeals, mockTournamentAppeals);
    });
  });

  group('getTournament Requests', () {
    test('success', () async {
      final TournamentRequests mockTournamentRequest = TournamentRequests(
          id: 32231,
          status: QuestionStatus.A,
          venue: Venue(
              id: 3218,
              name: 'name',
              town: Town(
                  id: 197,
                  name: 'name',
                  region: null,
                  country: Country(id: 1, name: 'name')),
              type: Type(id: 3, name: 'Синхрон'),
              address: 'address',
              urls: ['urls']),
          representative: mockPlayer,
          narrator: mockPlayer,
          narrators: [mockPlayer],
          approximateTeamsCount: 8,
          issuedAt: dateTime,
          dateStart: dateTime,
          tournamentId: mockTournamentDetails.id);
      final Iterable<TournamentRequests> mockTournamentRequests = [
        mockTournamentRequest
      ];
      when(mockDio.get('/tournaments/${mockTournamentDetails.id}/requests'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockTournamentRequest.toJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentRequests> tournamentRequests =
          await chgkRating.getTournamentRequests(mockTournamentDetails.id);
      expect(tournamentRequests, mockTournamentRequests);
    });
  });
}
