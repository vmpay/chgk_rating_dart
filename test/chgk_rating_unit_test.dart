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
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
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
          data: <Map<String, dynamic>>[mockPlayer.toMap()],
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
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('getPlayerTeamList success', () async {
      final PlayerTeam mockPlayerTeam =
          PlayerTeam(idPlayer: mockPlayer.idPlayer, idTeam: mockTeam.idTeam);
      when(mockDio.get('/players.$extensionJson/${mockPlayer.idPlayer}/teams'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamList(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[mockPlayerTeam]);
    });

    test('getPlayerTeamLastSeason fail', () async {
      try {
        await chgkRating.getPlayerTeamLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerTeamLastSeason empty', () async {
      when(mockDio
              .get('/players.$extensionJson/${mockPlayer.idPlayer}/teams/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamLastSeason(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('getPlayerTeamLastSeason success', () async {
      final PlayerTeam mockPlayerTeam =
          PlayerTeam(idPlayer: mockPlayer.idPlayer, idTeam: mockTeam.idTeam);
      when(mockDio
              .get('/players.$extensionJson/${mockPlayer.idPlayer}/teams/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockPlayerTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTeam> playerTeamList =
          await chgkRating.getPlayerTeamLastSeason(mockPlayer.idPlayer);
      expect(playerTeamList, <PlayerTeam>[mockPlayerTeam]);
    });

    test('getPlayerTournamentLastSeason fail', () async {
      try {
        await chgkRating.getPlayerTournamentLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerTournamentLastSeason empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments/last'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(mockPlayer.idPlayer);
      expect(playerTournamentResponse, null);
    });

    test('getPlayerTournamentLastSeason success', () async {
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

    test('getPlayerTournamentList fail', () async {
      try {
        await chgkRating.getPlayerTournamentList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getPlayerTournamentList empty', () async {
      when(mockDio.get(
              '/players.$extensionJson/${mockPlayer.idPlayer}/tournaments'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<PlayerTournamentResponse> playerTournamentResponse =
          await chgkRating.getPlayerTournamentList(mockPlayer.idPlayer);
      expect(playerTournamentResponse, <PlayerTournamentResponse>[]);
    });

    test('getPlayerTournamentList success', () async {
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

  group('Team', () {
    test('getTeamById empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}')).thenThrow(
          DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
      final Team? team = await chgkRating.getTeamById(mockTeam.idTeam);
      expect(team, null);
    });

    test('getTeamById fail', () async {
      try {
        await chgkRating.getTeamById(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamById fail response', () async {
      try {
        when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}'))
            .thenThrow(DioError(requestOptions: RequestOptions(path: '')));
        await chgkRating.getTeamById(mockTeam.idTeam);
      } on DioError catch (e) {
        assert(e is DioError);
      }
    });

    test('getTeamById success', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}')).thenAnswer(
          (_) async => Response<List<dynamic>>(
              data: [mockTeam.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Team? team = await chgkRating.getTeamById(mockTeam.idTeam);
      expect(team, mockTeam);
    });

    test('getTeamBy search parameters success', () async {
      const TeamSearch mockTeamSearch = TeamSearch();
      when(mockDio.get('/teams.$extensionJson/search',
              queryParameters: <String, dynamic>{'name': mockTeam.name}))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockTeamSearch.toMap(),
              requestOptions: RequestOptions(path: '')));
      final TeamSearch teamSearch =
          await chgkRating.getTeamBy(name: mockTeam.name);
      expect(teamSearch, mockTeamSearch);
    });

    test('getTeamRatingLatest fail input teamId', () async {
      try {
        await chgkRating.getTeamRatingById(' ', releaseId);
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamRatingLatest not found', () async {
      when(mockDio.get(
              '/teams.$extensionJson/${mockTeam.idTeam}/rating/$releaseId'))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(mockTeam.idTeam, releaseId);
      expect(teamRating, null);
    });

    test('getTeamRatingLatest empty', () async {
      when(mockDio.get(
              '/teams.$extensionJson/${mockTeam.idTeam}/rating/$releaseId'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(mockTeam.idTeam, releaseId);
      expect(teamRating, null);
    });

    test('getTeamRatingLatest success', () async {
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

    test('getTeamRatingList fail', () async {
      try {
        await chgkRating.getTeamRatingList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamRatingList empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(mockTeam.idTeam);
      expect(teamRatingList, <TeamRating>[]);
    });

    test('getTeamRatingList success', () async {
      const TeamRating mockTeamRating = TeamRating();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/rating'))
          .thenAnswer((_) async => Response<List<Map<String, dynamic>>>(
              data: <Map<String, dynamic>>[mockTeamRating.toMap()],
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(mockTeam.idTeam);
      expect(teamRatingList, <TeamRating>[mockTeamRating]);
    });

    test('getTeamPlayersList fail', () async {
      try {
        await chgkRating.getTeamPlayersList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamPlayersList empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps'))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
      final Iterable<TeamPlayers> playerTeamList =
          await chgkRating.getTeamPlayersList(mockTeam.idTeam);
      expect(playerTeamList, <PlayerTeam>[]);
    });

    test('getTeamPlayersList success', () async {
      const TeamPlayers mockTeamPlayers = TeamPlayers();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: <String, dynamic>{'123': mockTeamPlayers.toMap()},
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList(mockTeam.idTeam);
      expect(teamPlayersList, <TeamPlayers>[mockTeamPlayers]);
    });

    test('getTeamPlayersLastSeason fail', () async {
      try {
        await chgkRating.getTeamPlayersLastSeason(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamPlayersLastSeason empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps/last'))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(mockTeam.idTeam);
      expect(teamPlayers, null);
    });

    test('getTeamPlayersLastSeason success', () async {
      const TeamPlayers mockTeamPlayers = TeamPlayers();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/recaps/last'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: mockTeamPlayers.toMap(),
              requestOptions: RequestOptions(path: '')));
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(mockTeam.idTeam);
      expect(teamPlayers, mockTeamPlayers);
    });

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
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
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

    test('getTeamTournamentList fail', () async {
      try {
        await chgkRating.getTeamTournamentList(' ');
      } on FormatException catch (e) {
        assert(e is FormatException);
      }
    });

    test('getTeamTournamentList empty', () async {
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments'))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: ''),
              error: 'Http status error [404]'));
      final Iterable<TeamTournament> teamTournamentsList =
          await chgkRating.getTeamTournamentList(mockTeam.idTeam);
      expect(teamTournamentsList, <TeamTournament>[]);
    });

    test('getTeamTournamentList success', () async {
      const TeamTournament mockTeamTournament = TeamTournament();
      when(mockDio.get('/teams.$extensionJson/${mockTeam.idTeam}/tournaments'))
          .thenAnswer((_) async => Response<Map<String, dynamic>>(
              data: <String, dynamic>{'123': mockTeamTournament.toMap()},
              requestOptions: RequestOptions(path: '')));
      final Iterable<TeamTournament> teamTournamentList =
          await chgkRating.getTeamTournamentList(mockTeam.idTeam);
      print('mock $mockTeamTournament');
      print('real ${teamTournamentList.first}');
      expect(teamTournamentList, <TeamTournament>[mockTeamTournament]);
    });
  });
}
