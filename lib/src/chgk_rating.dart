import 'package:dio/dio.dart';

import 'constants.dart';
import 'ext.dart';
import 'models/player.dart';
import 'models/player_rating.dart';
import 'models/player_search.dart';
import 'models/player_team.dart';
import 'models/player_tournament.dart';
import 'models/team.dart';
import 'models/team_players.dart';
import 'models/team_rating.dart';
import 'models/team_search.dart';
import 'models/team_tournament.dart';
import 'models/tournament_appeal.dart';
import 'models/tournament_controversial.dart';
import 'models/tournament_details.dart';
import 'models/tournament_results.dart';
import 'models/tournament_search.dart';
import 'models/tournament_team_players.dart';
import 'models/tournament_team_results.dart';

// TODO paging
// TODO edge cases false/null/empty responses
// TODO error classification
// TODO cities, countries, regions impl

/// Dart wrapper client for the competitive
/// What? Where? When? rating [WebAPIRating](https://rating.chgk.info/api-doc)
///
/// In order to start using this wrapper create an instance of this class
/// ```dart
///   ChgkRating chgkRating = ChgkRating();
/// ```
///
/// After initializing chgkRating you can request player data from the server
/// by calling
/// ```dart
///   Player? player = await chgkRating.getPlayerById(17579);
/// ```

class ChgkRating {
  static final ChgkRating _chgkRatingService = ChgkRating._internal();

  factory ChgkRating() => _chgkRatingService;

  ChgkRating._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: defaultTimeout,
    sendTimeout: defaultTimeout,
    connectTimeout: defaultTimeout,
  ))
    ..interceptors.add(LogInterceptor(
        requestHeader: false,
        responseHeader: true,
        requestBody: false,
        responseBody: true));

  /// Requests [Player] object from server.
  ///
  /// Requires player identifier [playerId]. Returns player object [Player]
  /// in case of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Player?> getPlayerById(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId');
    final Iterable<Player> playerList =
        (response.data as List<dynamic>).map((e) => Player.fromMap(e));
    return playerList.firstOrNull;
  }

  /// Searches for players [Player] on server.
  ///
  /// Performs search by any of the optional parameters: [name], [surname],
  /// [patronymic]. Returns player object [PlayerSearch] in case of success
  /// or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
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

  /// Requests the latest player rating [PlayerRating] from server.
  ///
  /// Requires player identifier [playerId]. Returns player rating object
  /// [PlayerRating] in case of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<PlayerRating?> getPlayerRatingLatest(int playerId) async =>
      PlayerRating.fromMap(
          (await _dio.get('/players.$extensionJson/$playerId/rating/last'))
              .data);

  /// Requests historical player rating [PlayerRating] from server.
  ///
  /// Requires player identifier [playerId]. Returns player rating objects
  /// [PlayerRating] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerRating>> getPlayerRatingList(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/rating');
    final Iterable<PlayerRating> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerRating.fromMap(e));
    return playerRatingList;
  }

  /// Requests player teams [PlayerTeam] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player team objects
  /// [PlayerTeam] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getPlayerTeamList(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/teams');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  /// Requests player teams [PlayerTeam] list for the last season from server.
  ///
  /// Requires player identifier [playerId]. Returns player team objects
  /// [PlayerTeam] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getPlayerTeamLastSeason(int playerId) async {
    final Response response =
        await _dio.get('/players.$extensionJson/$playerId/teams/last');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>).map((e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  /// Requests player tournaments [PlayerTournament] list for the last season
  /// from server.
  ///
  /// Requires player identifier [playerId]. Returns player tournament object
  /// [PlayerTournamentResponse] in case of success or empty list
  /// if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<PlayerTournamentResponse> getPlayerTournamentLastSeason(
          int playerId) async =>
      PlayerTournamentResponse.fromMap(
          (await _dio.get('/players.$extensionJson/$playerId/tournaments/last'))
              .data);

  /// Requests player tournaments [PlayerTournament] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player tournament objects
  /// [PlayerTournamentResponse] list in case of success or empty list
  /// if player not found.
  /// Throws [DioError] in case of network connection problems.
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

  /// Requests [Team] object from server.
  ///
  /// Requires team identifier [teamId]. Returns team object [Team]
  /// in case of success or Null if team not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Team?> getTeamById(int teamId) async {
    final Response response = await _dio.get('/teams.$extensionJson/$teamId');
    return (response.data as List<dynamic>)
        .map((e) => Team.fromMap(e))
        .firstOrNull;
  }

  /// Searches for team [Team] on server.
  ///
  /// Performs search by any of the optional parameters: [name], [town],
  /// [regionName], [countryName]. Returns player object [TeamSearch] in case
  /// of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
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
    return TeamSearch.fromMap((await _dio.get('/teams.$extensionJson/search',
            queryParameters: queryParameters))
        .data);
  }

  /// Requests team rating [TeamRating] from server.
  ///
  /// Requires team identifier [teamId] and release identifier [releaseId].
  /// Returns team rating object [TeamRating] in case of success or Null
  /// if team rating not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TeamRating?> getTeamRatingById(int teamId, int releaseId) async =>
      TeamRating.fromMap(
          (await _dio.get('/teams/$teamId/rating/$releaseId')).data);

  /// Requests historical team ratings [TeamRating] list from server.
  ///
  /// Requires team identifier [teamId]. Returns team rating objects
  /// [TeamRating] list in case of success or empty list if team rating not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamRating>> getTeamRatingList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/rating')).data as List<dynamic>)
          .map((e) => TeamRating.fromMap(e));

  /// Requests team players [TeamPlayers] for the latest season from server.
  ///
  /// Requires team identifier [teamId]. Returns team players object
  /// [TeamPlayers] in case of success or Null if team players not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TeamPlayers?> getTeamPlayersLastSeason(int teamId) async =>
      TeamPlayers.fromMap((await _dio.get('/teams/$teamId/recaps/last')).data);

  /// Requests team players [TeamPlayers] list from server.
  ///
  /// Requires team identifier [teamId]. Returns team players objects
  /// [TeamPlayers] list in case of success or empty list
  /// if team players not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamPlayers>> getTeamPlayersList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/recaps')).data as Map<String, dynamic>)
          .values
          .map((e) => TeamPlayers.fromMap(e));

  /// Requests the latest team tournament [TeamTournament] from server.
  ///
  /// Requires team identifier [teamId]. Returns team tournament object
  /// [TeamTournament] in case of success or Null if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TeamTournament?> getTeamTournamentLast(int teamId) async =>
      TeamTournament.fromMap(
          (await _dio.get('/teams/$teamId/tournaments/last')).data);

  /// Requests historical team tournament [TeamTournament] from server.
  ///
  /// Requires team identifier [teamId]. Returns team tournament object
  /// [TeamTournament] list in case of success or empty list
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamTournament>> getTeamTournamentList(int teamId) async =>
      ((await _dio.get('/teams/$teamId/tournaments')).data
              as Map<String, dynamic>)
          .values
          .map((e) => TeamTournament.fromMap(e));

  /// Requests tournament details [TournamentDetails] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament details
  /// object [TournamentDetails] in case of success or Null
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TournamentDetails?> getTournamentDetails(int tournamentId) async =>
      ((await _dio.get('/tournaments/$tournamentId')).data as List<dynamic>)
          .map((e) => TournamentDetails.fromMap(e))
          .firstOrNull;

  /// Searches for tournament [Tournament] on server.
  ///
  /// Performs search by any of the optional parameters: [name], [typeName],
  /// [archive]. Returns player object [TournamentSearch] in case of success or
  /// Null if player not found.
  /// Throws [DioError] in case of network connection problems.
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

  /// Requests tournament results [TournamentTeamResults] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament team
  /// results object [TournamentTeamResults] list in case of success or
  /// empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentTeamResults>> getTournamentResults(
          int tournamentId) async =>
      ((await _dio.get('/tournaments.$extensionJson/$tournamentId/list')).data
              as List<dynamic>)
          .map((e) => TournamentTeamResults.fromMap(e));

  /// Requests tournament team players [TournamentTeamPlayer] from server.
  ///
  /// Requires tournament identifier [tournamentId] and team identifier [teamId].
  /// Returns tournament team players object [TournamentTeamPlayer] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentTeamPlayer>> getTournamentTeamPlayersByTeam(
          int tournamentId, int teamId) async =>
      ((await _dio.get(
                  '/tournaments.$extensionJson/$tournamentId/recaps/$teamId'))
              .data as List<dynamic>)
          .map((e) => TournamentTeamPlayer.fromMap(e));

  /// Requests tournament teams [TournamentTeam] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament teams
  /// object [TournamentTeam] list in case of success or empty list
  /// if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentTeam>> getTournamentTeamPlayers(
          int tournamentId) async =>
      ((await _dio.get('/tournaments.$extensionJson/$tournamentId/recaps')).data
              as List<dynamic>)
          .map((e) => TournamentTeam.fromMap(e));

  /// Requests tournament team result [TournamentResults] from server.
  ///
  /// Requires tournament identifier [tournamentId] and team identifier [teamId].
  /// Returns tournament team result objects [TournamentResults] list
  /// in case of success or empty list if tournament team result not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentResults>> getTournamentResultsByTeam(
          int tournamentId, int teamId) async =>
      ((await _dio.get(
                  '/tournaments.$extensionJson/$tournamentId/results/$teamId'))
              .data as List<dynamic>)
          .map((e) => TournamentResults.fromMap(e));

  /// Requests tournament controversial questions [TournamentControversial] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// controversial questions object [TournamentControversial] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentControversial>> getTournamentControversialQuestions(
          int tournamentId) async =>
      ((await _dio.get(
                  '/tournaments.$extensionJson/$tournamentId/controversials'))
              .data as List<dynamic>)
          .map((e) => TournamentControversial.fromMap(e));

  /// Requests tournament appeal questions [TournamentAppeal] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// appeal questions object [TournamentAppeal] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentAppeal>> getTournamentAppealQuestions(
          int tournamentId) async =>
      ((await _dio.get('/tournaments.$extensionJson/$tournamentId/appeals'))
              .data as List<dynamic>)
          .map((e) => TournamentAppeal.fromMap(e));
}