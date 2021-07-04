import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chgk_rating_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  const TournamentDetails mockTournamentDetails =
      TournamentDetails(idTournament: '5021');
  const Tournament mockTournament = Tournament(
      idTournament: '5021', name: 'name', typeName: 'Обычный', archive: '1');

  const Team mockTeam = Team(
      idTeam: '58380',
      name: 'name',
      town: 'town',
      regionName: 'regionName',
      countryName: 'countryName',
      tournamentsThisSeason: 'tournamentsThisSeason',
      tournamentsTotal: 'tournamentsTotal',
      comment: 'comment');
  const int releaseId = 123;
  final DioError notFoundError = DioError(
      requestOptions: RequestOptions(path: ''),
      error: 'Http status error [404]');

  final MockDio mockDio = MockDio();
  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('getTournamentDetails', () {
    test('success', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournamentDetails.idTournament}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentDetails.toMap()],
              requestOptions: RequestOptions(path: '')));
      final TournamentDetails? tournamentDetails = await chgkRating
          .getTournamentDetails(mockTournamentDetails.idTournament);
      expect(tournamentDetails, mockTournamentDetails);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournamentDetails.idTournament}'))
          .thenThrow(notFoundError);
      final TournamentDetails? tournamentDetails = await chgkRating
          .getTournamentDetails(mockTournamentDetails.idTournament);
      expect(tournamentDetails, null);
    });

    test('fail', () async {
      try {
        await chgkRating.getTournamentDetails(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentBy search parameters', () {
    test('success', () async {
      const TournamentSearch mockTournamentSearch = TournamentSearch();
      when(mockDio.get('/tournaments.$extensionJson/search',
          queryParameters: <String, dynamic>{
            'name': mockTournament.name,
            'type_name': mockTournament.typeName,
            'archive': mockTournament.archive
          })).thenAnswer((_) async => Response<Map<String, dynamic>>(
          data: mockTournamentSearch.toMap(),
          requestOptions: RequestOptions(path: '')));
      final TournamentSearch tournamentSearch =
          await chgkRating.getTournamentBy(
              name: mockTournament.name,
              typeName: mockTournament.typeName,
              archive: mockTournament.archive);
      expect(tournamentSearch, mockTournamentSearch);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      const TournamentTeamResults tournamentTeamResults =
          TournamentTeamResults();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/list'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[tournamentTeamResults.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentTeamResults> tournamentTeamResultsList =
          await chgkRating.getTournamentResults(mockTournament.idTournament);
      expect(tournamentTeamResultsList,
          <TournamentTeamResults>[tournamentTeamResults]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/list'))
          .thenThrow(notFoundError);
      final Iterable<TournamentTeamResults> tournamentDetails =
          await chgkRating.getTournamentResults(mockTournament.idTournament);
      expect(tournamentDetails, <TournamentTeamResults>[]);
    });

    test('fail', () async {
      try {
        await chgkRating.getTournamentResults(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentTeamPlayersByTeam', () {
    test('success', () async {
      const TournamentTeamPlayer mockTournamentTeamPlayer =
          TournamentTeamPlayer();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps/${mockTeam.idTeam}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentTeamPlayer.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayer =
          await chgkRating.getTournamentTeamPlayersByTeam(
              mockTournament.idTournament, mockTeam.idTeam);
      expect(tournamentTeamPlayer,
          <TournamentTeamPlayer>[mockTournamentTeamPlayer]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps/${mockTeam.idTeam}'))
          .thenThrow(notFoundError);
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayer =
          await chgkRating.getTournamentTeamPlayersByTeam(
              mockTournament.idTournament, mockTeam.idTeam);
      expect(tournamentTeamPlayer, <TournamentTeamResults>[]);
    });

    test('edge fail', () async {
      try {
        await chgkRating.getTournamentTeamPlayersByTeam(' ', ' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('corner tournament fail', () async {
      try {
        await chgkRating.getTournamentTeamPlayersByTeam(
            mockTournament.idTournament, ' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('corner team fail', () async {
      try {
        await chgkRating.getTournamentTeamPlayersByTeam(' ', mockTeam.idTeam);
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentTeamPlayers', () {
    test('success', () async {
      const TournamentTeam mockTournamentTeam = TournamentTeam();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentTeam> tournamentTeam = await chgkRating
          .getTournamentTeamPlayers(mockTournament.idTournament);
      expect(tournamentTeam, <TournamentTeam>[mockTournamentTeam]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/recaps'))
          .thenThrow(notFoundError);
      final Iterable<TournamentTeam> tournamentTeam = await chgkRating
          .getTournamentTeamPlayers(mockTournament.idTournament);
      expect(tournamentTeam, <TournamentTeam>[]);
    });

    test('fail', () async {
      try {
        await chgkRating.getTournamentTeamPlayers(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentResultsByTeam', () {
    test('success', () async {
      const TournamentResults mockTournamentResults = TournamentResults();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/results/${mockTeam.idTeam}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentResults.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(
              mockTournament.idTournament, mockTeam.idTeam);
      expect(tournamentResults, <TournamentResults>[mockTournamentResults]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/results/${mockTeam.idTeam}'))
          .thenThrow(notFoundError);
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(
              mockTournament.idTournament, mockTeam.idTeam);
      expect(tournamentResults, <TournamentResults>[]);
    });

    test('edge fail', () async {
      try {
        await chgkRating.getTournamentResultsByTeam(' ', ' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('corner tournament fail', () async {
      try {
        await chgkRating.getTournamentResultsByTeam(
            mockTournament.idTournament, ' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('corner team fail', () async {
      try {
        await chgkRating.getTournamentResultsByTeam(' ', mockTeam.idTeam);
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentControversialQuestions', () {
    test('success', () async {
      const TournamentControversial mockTournamentControversial =
          TournamentControversial();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/controversials'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentControversial.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentControversial> controversials = await chgkRating
          .getTournamentControversialQuestions(mockTournament.idTournament);
      expect(controversials,
          <TournamentControversial>[mockTournamentControversial]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/controversials'))
          .thenThrow(notFoundError);
      final Iterable<TournamentControversial> controversials = await chgkRating
          .getTournamentControversialQuestions(mockTournament.idTournament);
      expect(controversials, <TournamentControversial>[]);
    });

    test('fail', () async {
      try {
        await chgkRating.getTournamentControversialQuestions(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });

  group('getTournamentAppealQuestions', () {
    test('success', () async {
      const TournamentAppeal mockTournamentAppeal = TournamentAppeal();
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/appeals'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockTournamentAppeal.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TournamentAppeal> appeal = await chgkRating
          .getTournamentAppealQuestions(mockTournament.idTournament);
      expect(appeal, <TournamentAppeal>[mockTournamentAppeal]);
    });

    test('empty', () async {
      when(mockDio.get(
              '/tournaments.$extensionJson/${mockTournament.idTournament}/appeals'))
          .thenThrow(notFoundError);
      final Iterable<TournamentAppeal> appeal = await chgkRating
          .getTournamentAppealQuestions(mockTournament.idTournament);
      expect(appeal, <TournamentAppeal>[]);
    });

    test('fail', () async {
      try {
        await chgkRating.getTournamentAppealQuestions(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });
  });
}
