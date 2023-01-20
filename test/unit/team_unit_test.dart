import 'package:chgk_rating/chgk_rating.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chgk_rating_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final Team mockTeam = Team(
      id: 26777,
      name: 'name',
      town: Town(
          id: 197,
          name: 'name',
          region: Town(
              id: 84,
              name: 'name',
              region: null,
              country: Country(id: 5, name: 'name')),
          country: Country(id: 5, name: 'name')));
  final DioError notFoundError = DioError(
      requestOptions: RequestOptions(path: ''),
      response: Response<dynamic>(
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));
  final MockDio mockDio = MockDio();

  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('getTeamById', () {
    test('empty', () async {
      when(mockDio.get('/teams/${mockTeam.id}')).thenThrow(notFoundError);
      final Team? team = await chgkRating.getTeamById(mockTeam.id);
      expect(team, null);
    });

    test('fail response', () async {
      try {
        when(mockDio.get('/teams/${mockTeam.id}'))
            .thenThrow(DioError(requestOptions: RequestOptions(path: '')));
        await chgkRating.getTeamById(mockTeam.id);
      } on DioError catch (e) {
        assert(e is DioError);
      }
    });

    test('success', () async {
      when(mockDio.get('/teams/${mockTeam.id}')).thenAnswer((_) async =>
          Response<String>(
              data: mockTeam.toRawJson(),
              requestOptions: RequestOptions(path: '')));
      final Team? team = await chgkRating.getTeamById(mockTeam.id);
      expect(team, mockTeam);
    });
  });

  group('getTeamBy search parameters ', () {
    test('success', () async {
      final Iterable<Team> mockTeamSearch = <Team>[mockTeam];
      when(mockDio.get('/teams',
              queryParameters: <String, dynamic>{'name': mockTeam.name}))
          .thenAnswer((_) async => Response<List<String>>(
              data: <String>[mockTeam.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<Team> teamSearch =
          await chgkRating.getTeamBy(name: mockTeam.name);
      expect(teamSearch, mockTeamSearch);
    });
  });

  group('getTeamPlayersList', () {
    test('empty', () async {
      when(mockDio.get('/teams/${mockTeam.id}/seasons')).thenAnswer((_) async =>
          Response<List<String>>(
              data: <String>[], requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getTeamPlayersList(mockTeam.id);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('success', () async {
      final PlayerTeam mockTeamPlayers = PlayerTeam(
          idPlayer: mockTeam.id,
          idSeason: mockTeam.id,
          idTeam: mockTeam.id,
          dateAdded: null,
          dateRemoved: null,
          playerNumber: 0);
      when(mockDio.get('/teams/${mockTeam.id}/seasons')).thenAnswer((_) async =>
          Response<List<String>>(
              data: <String>[mockTeamPlayers.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> teamPlayersList =
          await chgkRating.getTeamPlayersList(mockTeam.id);
      expect(teamPlayersList, <PlayerTeam>[mockTeamPlayers]);
    });
  });

  group('getTeamTournamentList', () {
    test('empty', () async {
      when(mockDio.get('/teams/${mockTeam.id}/tournaments')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[], requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournament> teamTournamentsList =
          await chgkRating.getTeamTournamentList(mockTeam.id);
      expect(teamTournamentsList, <PlayerTournament>[]);
    });

    test('success', () async {
      final PlayerTournament mockTeamTournament =
          PlayerTournament(idPlayer: 5, idTeam: 5, idTournament: 5);
      when(mockDio.get('/teams/${mockTeam.id}/tournaments')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[mockTeamTournament.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournament> teamTournamentList =
          await chgkRating.getTeamTournamentList(mockTeam.id);
      expect(teamTournamentList, <PlayerTournament>[mockTeamTournament]);
    });
  });
}
