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
  const int teamId = 58380;

  final MockDio mockDio = MockDio();
  final ChgkRating chgkRating = ChgkRating.init(mockDio);

  group('Utils test', () {
    test('singletonCheck', () {
      final ChgkRating chgkRating1 = ChgkRating();
      final ChgkRating chgkRating2 = ChgkRating();
      assert(identical(chgkRating1, chgkRating2));
    });
  });

  group('Player', () {
    test('getPlayerById empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: [], requestOptions: RequestOptions(path: '')));
      final Player? player =
          await chgkRating.getPlayerById(mockPlayer.idPlayer);
      expect(player, null);
    });

    test('getPlayerById fail', () async {
      try {
        await chgkRating.getPlayerById(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerById success', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}'))
          .thenAnswer((_) async => Response<List<dynamic>>(
              data: [mockPlayer.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Player? player =
          await chgkRating.getPlayerById(mockPlayer.idPlayer);
      expect(player, mockPlayer);
    });

    test('getPlayerBy search parameters success', () async {
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

    test('getPlayerRatingLatest fail', () async {
      try {
        await chgkRating.getPlayerRatingLatest(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerRatingLatest empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/rating/last'))
          .thenAnswer((_) async => Response<bool>(
              data: false, requestOptions: RequestOptions(path: '')));
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest(mockPlayer.idPlayer);
      expect(playerRating, null);
    });

    test('getPlayerRatingLatest success', () async {
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

    test('getPlayerRatingList fail', () async {
      try {
        await chgkRating.getPlayerRatingList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerRatingList empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerRating> playerRatingList =
          await chgkRating.getPlayerRatingList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerRating>[]);
    });

    test('getPlayerRatingList success', () async {
      const PlayerRating mockPlayerRating = PlayerRating();
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerRating.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerRating> playerRatingList =
          await chgkRating.getPlayerRatingList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerRating>[mockPlayerRating]);
    });

    test('getPlayerTeamList fail', () async {
      try {
        await chgkRating.getPlayerTeamList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerTeamList empty', () async {
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/teams'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerRatingList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerTeam>[]);
    });

    test('getPlayerTeamList success', () async {
      final PlayerTeam mockPlayerTeam =
          PlayerTeam(idPlayer: mockPlayer.idPlayer, idTeam: '$teamId');
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/teams'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerRatingList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerRatingList, <PlayerTeam>[mockPlayerTeam]);
    });
  });
}
