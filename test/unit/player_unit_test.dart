import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/error_response.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'player_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final Player mockPlayer = Player(
      id: 17579, name: 'name', patronymic: 'patronymic', surname: 'surname');
  final MockDio mockDio = MockDio();
  final ErrorResponse errorResponse = ErrorResponse(
      type: 'https:\/\/tools.ietf.org\/html\/rfc2616#section-10',
      title: 'An error occurred',
      detail: 'Not Found');
  const String errorData =
      '{"type":"https:\/\/tools.ietf.org\/html\/rfc2616#section-10","title":"An error occurred","detail":"Not Found"}';

  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('getPlayerById', () {
    test('empty', () async {
      when(mockDio.get('/players/${mockPlayer.id}')).thenThrow(DioError(
          response: Response<dynamic>(
              data: errorData,
              statusCode: 404,
              requestOptions: RequestOptions(path: '')),
          requestOptions: RequestOptions(path: '')));
      expect(() => chgkRating.getPlayerById(mockPlayer.id),
          throwsA(predicate((e) => e is ErrorResponse && e == errorResponse)));
    });

    test('fail', () async {
      when(mockDio.get('/players/${mockPlayer.id}'))
          .thenThrow(DioError(requestOptions: RequestOptions(path: '')));
      try {
        await chgkRating.getPlayerById(mockPlayer.id);
      } on DioError catch (e) {
        assert(e is DioError);
      }
    });

    test('success', () async {
      when(mockDio.get('/players/${mockPlayer.id}')).thenAnswer((_) async =>
          Response<String>(
              data: mockPlayer.toRawJson(),
              requestOptions: RequestOptions(path: '')));
      final Player? player = await chgkRating.getPlayerById(mockPlayer.id);
      expect(player, mockPlayer);
    });
  });

  group('getPlayerBy search parameters', () {
    test('success', () async {
      final Iterable<Player> mockPlayerSearch = <Player>[mockPlayer];
      when(mockDio.get('/players', queryParameters: <String, dynamic>{
        'surname': mockPlayer.surname
      })).thenAnswer((_) async => Response<List<String>>(
          data: <String>[mockPlayer.toRawJson()],
          requestOptions: RequestOptions(path: '')));
      final Iterable<Player> playerSearch =
          await chgkRating.getPlayerBy(surname: mockPlayer.surname);
      expect(playerSearch, mockPlayerSearch);
    });
  });

  group('getPlayerTeamList', () {
    test('empty', () async {
      when(mockDio.get('/players/${mockPlayer.id}/seasons')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[], requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.id);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('success', () async {
      final PlayerTeam mockPlayerTeam = PlayerTeam(
          idPlayer: mockPlayer.id,
          idSeason: mockPlayer.id,
          idTeam: mockPlayer.id,
          dateAdded: null,
          dateRemoved: null,
          playerNumber: 0);
      when(mockDio.get('/players/${mockPlayer.id}/seasons')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[mockPlayerTeam.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.id);
      expect(playerTeamList, <PlayerTeam>[mockPlayerTeam]);
    });
  });

  group('getPlayerTournamentList', () {
    test('empty', () async {
      when(mockDio.get('/players/${mockPlayer.id}/tournaments')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[], requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournament> playerTournamentResponse =
          await chgkRating.getPlayerTournamentList(mockPlayer.id);
      expect(playerTournamentResponse, <PlayerTournament>[]);
    });

    test('success', () async {
      final PlayerTournament mockPlayerTournamentResponse = PlayerTournament(
          idPlayer: mockPlayer.id,
          idTeam: mockPlayer.id,
          idTournament: mockPlayer.id);
      when(mockDio.get('/players/${mockPlayer.id}/tournaments')).thenAnswer(
          (_) async => Response<List<String>>(
              data: <String>[mockPlayerTournamentResponse.toRawJson()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournament> playerTournamentResponse =
          await chgkRating.getPlayerTournamentList(mockPlayer.id);
      expect(playerTournamentResponse,
          <PlayerTournament>[mockPlayerTournamentResponse]);
    });
  });
}
