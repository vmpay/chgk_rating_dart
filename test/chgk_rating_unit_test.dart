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
  });
}
