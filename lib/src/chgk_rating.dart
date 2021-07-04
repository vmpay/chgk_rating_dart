import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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
  static final ChgkRating _chgkRatingService = ChgkRating._internal(
      Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: defaultTimeout,
    sendTimeout: defaultTimeout,
    connectTimeout: defaultTimeout,
  ))
        ..interceptors.add(LogInterceptor(
            requestHeader: false,
            responseHeader: true,
            requestBody: false,
            responseBody: true)));

  factory ChgkRating() => _chgkRatingService;

  ChgkRating._internal(this._dio);

  @visibleForTesting
  ChgkRating.init(this._dio);

  final Dio _dio;

  /// Requests [Player] object from server.
  ///
  /// Requires player identifier [playerId]. Returns player object [Player]
  /// in case of success or Null if player not found.
  /// Throws [FormatException] in case invalid input parameter [playerId] or
  /// [DioError] in case of network connection problems.
  Future<Player?> getPlayerById(String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<List<dynamic>> response =
        await _dio.get('/players.$extensionJson/$id');
    return response.data?.map((dynamic e) => Player.fromMap(e)).firstOrNull;
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
    final Response<dynamic> response = await _dio.get(
        '/players.$extensionJson/search',
        queryParameters: queryParameters);
    return PlayerSearch.fromMap(response.data);
  }

  /// Requests the latest player rating [PlayerRating] from server.
  ///
  /// Requires player identifier [playerId]. Returns player rating object
  /// [PlayerRating] in case of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<PlayerRating?> getPlayerRatingLatest(String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/rating/last');
    if (response.data is bool) {
      return null;
    } else {
      return PlayerRating.fromMap(response.data);
    }
  }

  /// Requests historical player rating [PlayerRating] from server.
  ///
  /// Requires player identifier [playerId]. Returns player rating objects
  /// [PlayerRating] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerRating>> getPlayerRatingList(String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/rating');
    final Iterable<PlayerRating> playerRatingList =
        (response.data as List<dynamic>)
            .map((dynamic e) => PlayerRating.fromMap(e));
    return playerRatingList;
  }

  /// Requests player teams [PlayerTeam] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player team objects
  /// [PlayerTeam] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getPlayerTeamList(String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/teams');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>)
            .map((dynamic e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  /// Requests player teams [PlayerTeam] list for the last season from server.
  ///
  /// Requires player identifier [playerId]. Returns player team objects
  /// [PlayerTeam] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getPlayerTeamLastSeason(String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/teams/last');
    final Iterable<PlayerTeam> playerRatingList =
        (response.data as List<dynamic>)
            .map((dynamic e) => PlayerTeam.fromMap(e));
    return playerRatingList;
  }

  /// Requests player tournaments [PlayerTournament] list for the last season
  /// from server.
  ///
  /// Requires player identifier [playerId]. Returns player tournament object
  /// [PlayerTournamentResponse] in case of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<PlayerTournamentResponse?> getPlayerTournamentLastSeason(
      String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/tournaments/last');
    if (response.data is Iterable) {
      return null;
    } else {
      return PlayerTournamentResponse.fromMap(response.data);
    }
  }

  /// Requests player tournaments [PlayerTournament] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player tournament objects
  /// [PlayerTournamentResponse] list in case of success or empty list
  /// if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTournamentResponse>> getPlayerTournamentList(
      String playerId) async {
    final int id = playerId.parseIdOrThrow;
    final Response<dynamic> response =
        await _dio.get('/players.$extensionJson/$id/tournaments');
    if (response.data is Iterable) {
      return <PlayerTournamentResponse>[];
    } else {
      return (response.data as Map<String, dynamic>)
          .values
          .map((dynamic e) => PlayerTournamentResponse.fromMap(e));
    }
  }

  /// Requests [Team] object from server.
  ///
  /// Requires team identifier [teamId]. Returns team object [Team]
  /// in case of success or Null if team not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Team?> getTeamById(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id');
      return (response.data as List<dynamic>)
          .map((dynamic e) => Team.fromMap(e))
          .firstOrNull;
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return null;
      } else {
        rethrow;
      }
    }
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
  Future<TeamRating?> getTeamRatingById(String teamId, int releaseId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/rating/$releaseId');
      if (response.data is Iterable) {
        return null;
      } else {
        return TeamRating.fromMap(response.data);
      }
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return null;
      } else {
        rethrow;
      }
    }
  }

  /// Requests historical team ratings [TeamRating] list from server.
  ///
  /// Requires team identifier [teamId]. Returns team rating objects
  /// [TeamRating] list in case of success or empty list if team rating not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamRating>> getTeamRatingList(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/rating');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TeamRating.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TeamRating>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests team players [TeamPlayers] for the latest season from server.
  ///
  /// Requires team identifier [teamId]. Returns team players object
  /// [TeamPlayers] in case of success or Null if team players not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TeamPlayers?> getTeamPlayersLastSeason(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/recaps/last');
      return TeamPlayers.fromMap(response.data);
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return null;
      } else {
        rethrow;
      }
    }
  }

  /// Requests team players [TeamPlayers] list from server.
  ///
  /// Requires team identifier [teamId]. Returns team players objects
  /// [TeamPlayers] list in case of success or empty list
  /// if team players not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamPlayers>> getTeamPlayersList(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/recaps');
      return (response.data as Map<String, dynamic>)
          .values
          .map((dynamic e) => TeamPlayers.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TeamPlayers>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests the latest team tournament [TeamTournament] from server.
  ///
  /// Requires team identifier [teamId]. Returns team tournament object
  /// [TeamTournament] in case of success or Null if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TeamTournament?> getTeamTournamentLast(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/tournaments/last');
      return TeamTournament.fromMap(response.data);
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return null;
      } else {
        rethrow;
      }
    }
  }

  /// Requests historical team tournament [TeamTournament] from server.
  ///
  /// Requires team identifier [teamId]. Returns team tournament object
  /// [TeamTournament] list in case of success or empty list
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TeamTournament>> getTeamTournamentList(String teamId) async {
    final int id = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/teams.$extensionJson/$id/tournaments');
      return (response.data as Map<String, dynamic>)
          .values
          .map((dynamic e) => TeamTournament.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TeamTournament>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament details [TournamentDetails] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament details
  /// object [TournamentDetails] in case of success or Null
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<TournamentDetails?> getTournamentDetails(String tournamentId) async {
    final int id = tournamentId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/tournaments.$extensionJson/$id');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentDetails.fromMap(e))
          .firstOrNull;
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return null;
      } else {
        rethrow;
      }
    }
  }

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
      String tournamentId) async {
    final int id = tournamentId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/tournaments.$extensionJson/$id/list');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentTeamResults.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentTeamResults>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament team players [TournamentTeamPlayer] from server.
  ///
  /// Requires tournament identifier [tournamentId] and team identifier [teamId].
  /// Returns tournament team players object [TournamentTeamPlayer] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentTeamPlayer>> getTournamentTeamPlayersByTeam(
      String tournamentId, String teamId) async {
    final int idTournament = tournamentId.parseIdOrThrow;
    final int idTeam = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response = await _dio
          .get('/tournaments.$extensionJson/$idTournament/recaps/$idTeam');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentTeamPlayer.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentTeamPlayer>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament teams [TournamentTeam] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament teams
  /// object [TournamentTeam] list in case of success or empty list
  /// if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentTeam>> getTournamentTeamPlayers(
      String tournamentId) async {
    final int id = tournamentId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/tournaments.$extensionJson/$id/recaps');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentTeam.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentTeam>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament team result [TournamentResults] from server.
  ///
  /// Requires tournament identifier [tournamentId] and team identifier [teamId].
  /// Returns tournament team result objects [TournamentResults] list
  /// in case of success or empty list if tournament team result not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentResults>> getTournamentResultsByTeam(
      String tournamentId, String teamId) async {
    final int idTournament = tournamentId.parseIdOrThrow;
    final int idTeam = teamId.parseIdOrThrow;
    try {
      final Response<dynamic> response = await _dio
          .get('/tournaments.$extensionJson/$idTournament/results/$idTeam');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentResults.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentResults>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament controversial questions [TournamentControversial] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// controversial questions object [TournamentControversial] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentControversial>> getTournamentControversialQuestions(
      String tournamentId) async {
    final int id = tournamentId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/tournaments.$extensionJson/$id/controversials');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentControversial.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentControversial>[];
      } else {
        rethrow;
      }
    }
  }

  /// Requests tournament appeal questions [TournamentAppeal] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// appeal questions object [TournamentAppeal] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentAppeal>> getTournamentAppealQuestions(
      String tournamentId) async {
    final int id = tournamentId.parseIdOrThrow;
    try {
      final Response<dynamic> response =
          await _dio.get('/tournaments.$extensionJson/$id/appeals');
      return (response.data as List<dynamic>)
          .map((dynamic e) => TournamentAppeal.fromMap(e));
    } on DioError catch (e) {
      if (e.message.isNotFoundError) {
        return <TournamentAppeal>[];
      } else {
        rethrow;
      }
    }
  }
}
