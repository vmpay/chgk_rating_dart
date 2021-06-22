library chgk_rating;

import 'package:chgk_rating/constants.dart';
import 'package:chgk_rating/ext.dart';
import 'package:chgk_rating/models/player.dart';
import 'package:chgk_rating/models/player_rating.dart';
import 'package:chgk_rating/models/player_search_response.dart';
import 'package:chgk_rating/models/player_team.dart';
import 'package:chgk_rating/models/player_tournament.dart';
import 'package:dio/dio.dart';

// TODO paging
// TODO edge cases false/null/empty responses
class ChgkRating {
  static final ChgkRating _chgkRating = ChgkRating._internal();

  factory ChgkRating() => _chgkRating;

  ChgkRating._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: defaultTimeout,
    sendTimeout: defaultTimeout,
    connectTimeout: defaultTimeout,
  ))
    ..interceptors.add(LogInterceptor());

  Future<Player?> getPlayerById(int playerId) async {
    final Response response = await _dio.get('/players.json/$playerId');
    final Iterable<Player> playerList =
    (response.data as List<dynamic>).map((e) => Player.fromMap(e));
    return playerList.firstOrNull;
  }

  Future<PlayerSearchResponse> getPlayerBy({String? name, String? surname, String? patronymic}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    if (surname != null) {
      queryParameters.addAll(<String, dynamic>{'surname': surname});
    }
    if (patronymic != null) {
      queryParameters.addAll(<String, dynamic>{'patronymic': patronymic});
    }
    final Response response = await _dio.get('/players.json/search',
        queryParameters: queryParameters);
    return PlayerSearchResponse.fromMap(response.data);
  }

  Future<PlayerRating> getPlayerRatingLatest(int playerId) async =>
      PlayerRating.fromMap(
          (await _dio.get('/players.json/$playerId/rating/last')).data);

  Future<Iterable<PlayerRating>> getPlayerRatingList(int playerId) async {
    final Response response = await _dio.get('/players.json/$playerId/rating');
    final Iterable<PlayerRating> playerRatingList =
    (response.data as List<dynamic>).map((e) => PlayerRating.fromMap(e));
    return playerRatingList;
  }

  Future<Iterable<PlayerTeam>> getPlayerTeamList(int playerId) async {
    final Response response = await _dio.get('/players.json/$playerId/teams');
    final Iterable<PlayerTeam> playerRatingList =
    (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  Future<Iterable<PlayerTeam>> getPlayerTeamLastSeason(int playerId) async {
    final Response response =
    await _dio.get('/players.json/$playerId/teams/last');
    final Iterable<PlayerTeam> playerRatingList =
    (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  Future<PlayerTournamentResponse> getPlayerTournamentLastSeason(int playerId) async =>
      PlayerTournamentResponse.fromMap(
          (await _dio.get('/players.json/$playerId/tournaments/last')).data);

  Future<Iterable<PlayerTournamentResponse>> getPlayerTournamentList(int playerId) async {
    final Response response =
    await _dio.get('/players.json/$playerId/tournaments');
    final Iterable<PlayerTournamentResponse> playerTournamentList =
    (response.data as Map<String, dynamic>)
        .values
        .map((e) => PlayerTournamentResponse.fromMap(e));
    return playerTournamentList;
  }
}
