import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chgk_rating_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
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

  group('getTeamById', () {
    test('empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}'))
          .thenThrow(notFoundError);
      final Team? team = await chgkRating.getTeamById(mockTeam.idTeam);
      expect(team, null);
    });

    test('fail', () async {
      try {
        await chgkRating.getTeamById(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('fail response', () async {
      try {
        when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}'))
            .thenThrow(DioError(requestOptions: RequestOptions(path: '')));
        await chgkRating.getTeamById(mockTeam.idTeam);
      } on DioError catch (e) {
        assert(e is DioError);
      }
    });

    test('success', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}')).thenAnswer(
          (_) async => Response<List<dynamic>>(
              data: [mockTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Team? team = await chgkRating.getTeamById(mockTeam.idTeam);
      expect(team, mockTeam);
    });
  });

  group('getTeamBy search parameters ', () {
    test('success', () async {
      const TeamSearch mockTeamSearch = TeamSearch();
      when(mockDio.get('/teams.$extensionJson/search',
          queryParameters: <String, dynamic>{
            'name': mockTeam.name,
            'town': mockTeam.town,
            'region_name': mockTeam.regionName,
            'country_name': mockTeam.countryName
          })).thenAnswer((_) async => Response<Map<String, dynamic>>(
          data: mockTeamSearch.toMap(),
          requestOptions: RequestOptions(path: '')));
      final TeamSearch teamSearch = await chgkRating.getTeamBy(
          name: mockTeam.name,
          town: mockTeam.town,
          regionName: mockTeam.regionName,
          countryName: mockTeam.countryName);
      expect(teamSearch, mockTeamSearch);
    });
  });

  group('getTeamRatingLatest', () {
    test('fail input teamId', () async {
      try {
        await chgkRating.getTeamRatingById(' ', releaseId);
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('not found', () async {
      when(mockDio.get(
              '/teams.$extensionJson/${mockTeam.idTeam}/rating/$releaseId'))
          .thenThrow(notFoundError);
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(mockTeam.idTeam, releaseId);
      expect(teamRating, null);
    });

    test('empty', () async {
      when(mockDio.get(
              '/teams.$extensionJson/${mockTeam.idTeam}/rating/$releaseId'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(mockTeam.idTeam, releaseId);
      expect(teamRating, null);
    });

    test('success', () async {
      const TeamRating mockTeamRating = TeamRating();
      when(mockDio.get(
              '/teams.$extensionJson/${mockTeam.idTeam}/rating/$releaseId'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockTeamRating.toMap(),
              requestOptions: RequestOptions(path: '')));
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(mockTeam.idTeam, releaseId);
      expect(teamRating, mockTeamRating);
    });
  });

  group('getTeamRatingList', () {
    test('fail', () async {
      try {
        await chgkRating.getTeamRatingList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/rating'))
          .thenThrow(notFoundError);
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(mockTeam.idTeam);
      expect(teamRatingList, <TeamRating>[]);
    });

    test('success', () async {
      const TeamRating mockTeamRating = TeamRating();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockTeamRating.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(mockTeam.idTeam);
      expect(teamRatingList, <TeamRating>[mockTeamRating]);
    });
  });

  group('getTeamPlayersList', () {
    test('fail', () async {
      try {
        await chgkRating.getTeamPlayersList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps'))
          .thenThrow(notFoundError);
      final Iterable<TeamPlayers> playerTeamList =
          await chgkRating.getTeamPlayersList(mockTeam.idTeam);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('success', () async {
      const TeamPlayers mockTeamPlayers = TeamPlayers();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: <String, dynamic>{'123': mockTeamPlayers.toMap()},
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList(mockTeam.idTeam);
      expect(teamPlayersList, <TeamPlayers>[mockTeamPlayers]);
    });
  });

  group('getTeamPlayersLastSeason', () {
    test('fail', () async {
      try {
        await chgkRating.getTeamPlayersLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps/last'))
          .thenThrow(notFoundError);
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(mockTeam.idTeam);
      expect(teamPlayers, null);
    });

    test('success', () async {
      const TeamPlayers mockTeamPlayers = TeamPlayers();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps/last'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockTeamPlayers.toMap(),
              requestOptions: RequestOptions(path: '')));
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(mockTeam.idTeam);
      expect(teamPlayers, mockTeamPlayers);
    });
  });

  group('getTeamTournamentLast', () {
    test('getTeamTournamentLast fail', () async {
      try {
        await chgkRating.getTeamTournamentLast(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamTournamentLast empty', () async {
      when(mockDio
              .get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments/last'))
          .thenThrow(notFoundError);
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast(mockTeam.idTeam);
      expect(teamTournament, null);
    });

    test('getTeamTournamentLast success', () async {
      const TeamTournament mockTeamTournament = TeamTournament();
      when(mockDio
              .get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments/last'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockTeamTournament.toMap(),
              requestOptions: RequestOptions(path: '')));
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast(mockTeam.idTeam);
      expect(teamTournament, mockTeamTournament);
    });
  });

  group('getTeamTournamentList', () {
    test('fail', () async {
      try {
        await chgkRating.getTeamTournamentList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments'))
          .thenThrow(notFoundError);
      final Iterable<TeamTournament> teamTournamentsList =
          await chgkRating.getTeamTournamentList(mockTeam.idTeam);
      expect(teamTournamentsList, <TeamTournament>[]);
    });

    test('success', () async {
      const TeamTournament mockTeamTournament = TeamTournament();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: <String, dynamic>{'123': mockTeamTournament.toMap()},
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamTournament> teamTournamentList =
          await chgkRating.getTeamTournamentList(mockTeam.idTeam);
      expect(teamTournamentList, <TeamTournament>[mockTeamTournament]);
    });
  });
}
