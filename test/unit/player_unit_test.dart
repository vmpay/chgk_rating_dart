import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/constants.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chgk_rating_unit_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  const Player mockPlayer = Player(
      idPlayer: '17579',
      surname: 'surname',
      name: 'name',
      patronymic: 'patronymic',
      comment: 'comment',
      dbChgkInfoTag: 'dbChgkInfoTag');
  final MockDio mockDio = MockDio();

  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('getPlayerById', () {
    test('empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Player? player =
          await chgkRating.getPlayerById(mockPlayer.idPlayer);
      expect(player, null);
    });

    test('fail', () async {
      try {
        await chgkRating.getPlayerById(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('success', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: <Map<String, dynamic>>[mockPlayer.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Player? player =
          await chgkRating.getPlayerById(mockPlayer.idPlayer);
      expect(player, mockPlayer);
    });
  });

  group('getPlayerBy search parameters', () {
    test('success', () async {
      const PlayerSearch mockPlayerSearch = PlayerSearch();
      when(mockDio.get('/players.$extensionJson/search',
          queryParameters: <String, dynamic>{
            'surname': mockPlayer.surname
          })).thenAnswer((_) async => Response<Map<String, dynamic>>(
          data: mockPlayerSearch.toMap(),
          requestOptions: RequestOptions(path: '')));
      final PlayerSearch playerSearch =
          await chgkRating.getPlayerBy(surname: mockPlayer.surname);
      expect(playerSearch, mockPlayerSearch);
    });
  });

  group('getPlayerRatingLatest', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerRatingLatest(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/rating/last'))
          .thenAnswer((_) async => Response<bool>(
              data: false, requestOptions: RequestOptions(path: '')));
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest(mockPlayer.idPlayer);
      expect(playerRating, null);
    });

    test('success', () async {
      const PlayerRating mockPlayerRating = PlayerRating();
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/rating/last'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockPlayerRating.toMap(),
              requestOptions: RequestOptions(path: '')));
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest(mockPlayer.idPlayer);
      expect(playerRating, mockPlayerRating);
    });
  });

  group('getPlayerRatingList', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerRatingList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerRating> playerRatingList =
          await chgkRating.getPlayerRatingList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerRating>[]);
    });

    test('success', () async {
      const PlayerRating mockPlayerRating = PlayerRating();
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerRating.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerRating> playerRatingList =
          await chgkRating.getPlayerRatingList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerRating>[mockPlayerRating]);
    });
  });

  group('getPlayerTeamList', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerTeamList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/teams'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('success', () async {
      final PlayerTeam mockPlayerTeam = PlayerTeam(
          idPlayer: mockPlayer.idPlayer, idTeam: mockPlayer.idPlayer);
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/teams'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[mockPlayerTeam]);
    });
  });

  group('getPlayerTeamLastSeason', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerTeamLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio
              .get('/players.$extensionJson/${mockPlayer.idPlayer}/teams/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamLastSeason(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('success', () async {
      final PlayerTeam mockPlayerTeam = PlayerTeam(
          idPlayer: mockPlayer.idPlayer, idTeam: mockPlayer.idPlayer);
      when(mockDio
              .get('/players.$extensionJson/${mockPlayer.idPlayer}/teams/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamLastSeason(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[mockPlayerTeam]);
    });
  });

  group('getPlayerTournamentLastSeason', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerTournamentLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(mockPlayer.idPlayer);
      expect(playerTournamentResponse, null);
    });

    test('success', () async {
      const PlayerTournamentResponse mockPlayerTournamentResponse =
          PlayerTournamentResponse();
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments/last'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockPlayerTournamentResponse.toMap(),
              requestOptions: RequestOptions(path: '')));
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(mockPlayer.idPlayer);
      expect(playerTournamentResponse, mockPlayerTournamentResponse);
    });
  });

  group('getPlayerTournamentList', () {
    test('fail', () async {
      try {
        await chgkRating.getPlayerTournamentList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournamentResponse> playerTournamentResponse =
          await chgkRating.getPlayerTournamentList(mockPlayer.idPlayer);
      expect(playerTournamentResponse, <PlayerTournamentResponse>[]);
    });

    test('success', () async {
      const PlayerTournamentResponse mockPlayerTournamentResponse =
          PlayerTournamentResponse();
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
                  data: <String, dynamic>{
                    '1': mockPlayerTournamentResponse.toMap()
                  },
                  requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournamentResponse> playerTournamentResponse =
          await chgkRating.getPlayerTournamentList(mockPlayer.idPlayer);
      expect(playerTournamentResponse,
          <PlayerTournamentResponse>[mockPlayerTournamentResponse]);
    });
  });
}
