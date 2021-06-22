library chgk_rating;

import 'package:chgk_rating/constants.dart';
import 'package:chgk_rating/ext.dart';
import 'package:chgk_rating/models/player.dart';
import 'package:chgk_rating/models/player_rating.dart';
import 'package:chgk_rating/models/player_search.dart';
import 'package:chgk_rating/models/player_team.dart';
import 'package:chgk_rating/models/player_tournament.dart';
import 'package:chgk_rating/models/team.dart';
import 'package:chgk_rating/models/team_players.dart';
import 'package:chgk_rating/models/team_rating.dart';
import 'package:chgk_rating/models/team_search.dart';
import 'package:chgk_rating/models/team_tournament.dart';
import 'package:chgk_rating/models/tournament_details.dart';
import 'package:chgk_rating/models/tournament_results.dart';
import 'package:chgk_rating/models/tournament_search.dart';
import 'package:chgk_rating/models/tournament_team_players.dart';
import 'package:chgk_rating/models/tournament_team_results.dart';
import 'package:dio/dio.dart';

// TODO paging
// TODO edge cases false/null/empty responses
// TODO interface
// TODO error classification
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
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId');
    final Iterable<Player> playerList =
        (response.data as List<dynamic>).map((e) => Player.fromMap(e));
    return playerList.firstOrNull;
  }

  Future<PlayerSearch> getPlayerBy(
      {String? name, String? surname, String? patronymic}) async {
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
    final Response response = await _dio.get('/players.$extensionJson/search',
        queryParameters: queryParameters);
    return PlayerSearch.fromMap(response.data);
  }

  Future<PlayerRating> getPlayerRatingLatest(int playerId) async =>
      PlayerRating.fromMap(
          (await _dio.get('/players.$extensionJson/$playerId/rating/last'))
              .data);

  Future<Iterable<PlayerRating>> getPlayerRatingList(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/rating');
    final Iterable<PlayerRating> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerRating.fromMap(e));
    return playerRatingList;
  }

  Future<Iterable<PlayerTeam>> getPlayerTeamList(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/teams');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  Future<Iterable<PlayerTeam>> getPlayerTeamLastSeason(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/teams/last');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  Future<PlayerTournamentResponse> getPlayerTournamentLastSeason(
          int playerId) async =>
      PlayerTournamentResponse.fromMap(
          (await _dio.get('/players.$extensionJson/$playerId/tournaments/last'))
              .data);

  Future<Iterable<PlayerTournamentResponse>> getPlayerTournamentList(
      int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/tournaments');
    final Iterable<PlayerTournamentResponse> playerTournamentList =
        (response.data as Map<String, dynamic>)
            .values
            .map((e) => PlayerTournamentResponse.fromMap(e));
    return playerTournamentList;
  }

  Future<Team?> getTeamById(int teamId) async {
    final Response response = await _dio.get('/teams.$extensionJson/$teamId');
    return (response.data as List<dynamic>)
        .map((e) => Team.fromMap(e))
        .firstOrNull;
  }

  Future<TeamSearch> getTeamBy(
      {String? name,
      String? town,
      String? regionName,
      String? countryName}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    if (town != null) {
      queryParameters.addAll(<String, dynamic>{'town': town});
    }
    if (regionName != null) {
      queryParameters.addAll(<String, dynamic>{'region_name': regionName});
    }
    if (countryName != null) {
      queryParameters.addAll(<String, dynamic>{'country_name': countryName});
    }
    return TeamSearch.fromMap(
        (await _dio.get('/teams.$extensionJson/search',
            queryParameters: queryParameters))
        .data);
  }

  Future<TeamRating> getTeamRatingById(int teamId, int releaseId) async =>
      TeamRating.fromMap(
          (await _dio.get('/teams/$teamId/rating/$releaseId')).data);

  Future<Iterable<TeamRating>> getTeamRatingList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/rating')).data as List<dynamic>)
          .map((e) => TeamRating.fromMap(e));

  Future<TeamPlayers?> getTeamPlayersLastSeason(int teamId) async =>
      TeamPlayers.fromMap((await _dio.get('/teams/$teamId/recaps/last')).data);

  Future<Iterable<TeamPlayers>> getTeamPlayersList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/recaps')).data as Map<String, dynamic>)
          .values
          .map((e) => TeamPlayers.fromMap(e));

  Future<TeamTournament?> getTeamTournamentLast(int teamId) async =>
      TeamTournament.fromMap(
          (await _dio.get('/teams/$teamId/tournaments/last')).data);

  Future<Iterable<TeamTournament>> getTeamTournamentList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/tournaments')).data
              as Map<String, dynamic>)
          .values
          .map((e) => TeamTournament.fromMap(e));

  Future<TournamentDetails?> getTournamentDetails(int tournamentId) async =>
      ((await _dio.get('/tournaments/$tournamentId')).data as List<dynamic>)
          .map((e) => TournamentDetails.fromMap(e))
          .firstOrNull;

  Future<TournamentSearch> getTournamentBy(
      {String? name, String? typeName, String? archive}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    if (typeName != null) {
      queryParameters.addAll(<String, dynamic>{'type_name': typeName});
    }
    if (archive != null) {
      queryParameters.addAll(<String, dynamic>{'archive': archive});
    }
    return TournamentSearch.fromMap((await _dio.get(
            '/tournaments.$extensionJson/search',
            queryParameters: queryParameters))
        .data);
  }

  Future<Iterable<TournamentTeamResults>> getTournamentResults(
          int tournamentId) async =>
      ((await _dio.get('/tournaments/$tournamentId/list')).data
              as List<dynamic>)
          .map((e) => TournamentTeamResults.fromMap(e));

  Future<Iterable<TournamentTeamPlayer>> getTournamentTeamPlayersByTeam(
          int tournamentId, int teamId) async =>
      ((await _dio.get('/tournaments/$tournamentId/recaps/$teamId')).data
              as List<dynamic>)
          .map((e) => TournamentTeamPlayer.fromMap(e));

  Future<Iterable<TournamentTeam>> getTournamentTeamPlayers(
          int tournamentId) async =>
      ((await _dio.get('/tournaments/$tournamentId/recaps')).data
              as List<dynamic>)
          .map((e) => TournamentTeam.fromMap(e));

  Future<Iterable<TournamentResults>> getTournamentResultsByTeam(
          int tournamentId, int teamId) async =>
      ((await _dio.get('/tournaments/$tournamentId/results/$teamId')).data
              as List<dynamic>)
          .map((e) => TournamentResults.fromMap(e));
}
