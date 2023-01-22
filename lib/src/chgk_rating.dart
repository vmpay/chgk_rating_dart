import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'constants.dart';
import 'models/error_response.dart';
import 'models/player.dart';
import 'models/player_team.dart';
import 'models/player_tournament.dart';
import 'models/team.dart';
import 'models/token_request.dart';
import 'models/token_response.dart';
import 'models/tournament.dart';
import 'models/tournament_appeals.dart';
import 'models/tournament_requests.dart';
import 'models/tournament_results.dart';

/// Dart wrapper client for the competitive
/// What? Where? When? rating [WebAPIRating](https://api.rating.chgk.net/)
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
      ..interceptors.add(
        LogInterceptor(
            requestHeader: false,
            responseHeader: true,
            requestBody: false,
            responseBody: true),
      )
      ..options.headers['accept'] = 'application/json'
      ..options.headers['Content-Type'] = 'application/json',
  );

  factory ChgkRating() => _chgkRatingService;

  ChgkRating._internal(this._dio);

  @visibleForTesting
  ChgkRating.init(this._dio);

  final Dio _dio;

  /// Requests [Player] object from server.
  ///
  /// Requires player identifier [playerId]. Returns player object [Player]
  /// in case of success
  /// Throws [DioError] in case of network connection problems or
  /// [ErrorResponse] in case of parsable error
  Future<Player> getPlayerById(int playerId) async {
    try {
      final Response<String> response = await _dio.get('/players/$playerId');
      return Player.fromRawJson(response.data!);
    } on DioError catch (e) {
      try {
        throw ErrorResponse.fromRawJson(e.response?.data);
      } on TypeError catch (_) {
        throw e;
      }
    }
  }

  /// Searches for players [Player] on server.
  ///
  /// Performs search by any of the optional parameters: [name], [surname].
  /// Returns [Player] list in case of success
  /// or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<Player>> getPlayerBy({String? name, String? surname}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    if (surname != null) {
      queryParameters.addAll(<String, dynamic>{'surname': surname});
    }

    final Response<List<dynamic>> response =
        await _dio.get('/players', queryParameters: queryParameters);
    return Player.decodeList(response.data!);
  }

  /// Requests player teams [PlayerTeam] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player team objects
  /// [PlayerTeam] list in case of success or empty list if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getPlayerTeamList(int playerId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/players/$playerId/seasons');
    return PlayerTeam.decodeList(response.data!);
  }

  /// Requests player tournaments [PlayerTournament] list from server.
  ///
  /// Requires player identifier [playerId]. Returns player tournament objects
  /// [PlayerTournament] list in case of success or empty list
  /// if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTournament>> getPlayerTournamentList(
      int playerId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/players/$playerId/tournaments');
    return PlayerTournament.decodeList(response.data!);
  }

  /// Requests [Team] object from server.
  ///
  /// Requires team identifier [teamId]. Returns team object [Team]
  /// in case of success or Null if team not found.
  /// Throws [DioError] in case of network connection problems or
  /// [ErrorResponse] in case of parsable error
  Future<Team> getTeamById(int teamId) async {
    try {
      final Response<String> response = await _dio.get('/teams/$teamId');
      return Team.fromRawJson(response.data!);
    } on DioError catch (e) {
      try {
        throw ErrorResponse.fromRawJson(e.response?.data);
      } on TypeError catch (_) {
        throw e;
      }
    }
  }

  /// Searches for team [Team] on server.
  ///
  /// Performs search by any of the optional parameters: [name].
  /// Returns team list [Team] in case of success or Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<Team>> getTeamBy({String? name}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    return Team.decodeList(
        (await _dio.get('/teams', queryParameters: queryParameters)).data);
  }

  /// Requests team players [PlayerTeam] list from server.
  ///
  /// Requires team identifier [teamId]. Returns team players objects
  /// [PlayerTeam] list in case of success or empty list
  /// if team players not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTeam>> getTeamPlayersList(int teamId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/teams/$teamId/seasons');
    return PlayerTeam.decodeList(response.data!);
  }

  /// Requests historical team tournament [PlayerTournament] from server.
  ///
  /// Requires team identifier [teamId]. Returns team tournament object
  /// [PlayerTournament] list in case of success or empty list
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<PlayerTournament>> getTeamTournamentList(int teamId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/teams/$teamId/tournaments');
    return PlayerTournament.decodeList(response.data!);
  }

  /// Requests tournament details [Tournament] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament details
  /// object [Tournament] in case of success or Null
  /// if team tournament not found.
  /// Throws [DioError] in case of network connection problems or
  /// [ErrorResponse] in case of parsable error
  Future<Tournament> getTournamentDetails(int tournamentId) async {
    try {
      final Response<String> response =
          await _dio.get('/tournaments/$tournamentId');
      return Tournament.fromRawJson(response.data!);
    } on DioError catch (e) {
      try {
        throw ErrorResponse.fromRawJson(e.response?.data);
      } on TypeError catch (_) {
        throw e;
      }
    }
  }

  /// Searches for tournament [Tournament] on server.
  ///
  /// Performs search by any of the optional parameters: [name], [typeName].
  /// Returns player object [Tournament] list in case of success or
  /// Null if player not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<Tournament>> getTournamentBy(
      {String? name, String? typeName}) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    if (name != null) {
      queryParameters.addAll(<String, dynamic>{'name': name});
    }
    if (typeName != null) {
      queryParameters.addAll(<String, dynamic>{'type': typeName});
    }
    final Response<List<dynamic>> response =
        await _dio.get('/tournaments', queryParameters: queryParameters);
    return Tournament.decodeList(response.data!);
  }

  /// Requests tournament results [TournamentResults] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament team
  /// results object [TournamentResults] list in case of success or
  /// empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems or
  /// [ErrorResponse] in case of parsable error
  Future<Iterable<TournamentResults>> getTournamentResults(
      int tournamentId) async {
    try {
      final Response<List<dynamic>> response =
          await _dio.get('/tournaments/$tournamentId/results');
      return TournamentResults.decodeList(response.data!);
    } on DioError catch (e) {
      try {
        throw ErrorResponse.fromRawJson(e.response?.data);
      } on TypeError catch (_) {
        throw e;
      }
    }
  }

  /// Requests tournament appeal questions [TournamentAppeals] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// appeal questions [TournamentAppeals] list
  /// in case of success or empty list if tournament results not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentAppeals>> getTournamentAppeals(
      int tournamentId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/tournaments/$tournamentId/appeals');
    return List<TournamentAppeals>.from(
        response.data!.map((dynamic e) => TournamentAppeals.fromJson(e)));
  }

  /// Requests tournament team requests [TournamentRequests] from server.
  ///
  /// Requires tournament identifier [tournamentId]. Returns tournament
  /// team requests [TournamentRequests] list
  /// in case of success or empty list if tournament team requests not found.
  /// Throws [DioError] in case of network connection problems.
  Future<Iterable<TournamentRequests>> getTournamentRequests(
      int tournamentId) async {
    final Response<List<dynamic>> response =
        await _dio.get('/tournaments/$tournamentId/requests');
    return List<TournamentRequests>.from(
        response.data!.map((dynamic e) => TournamentRequests.fromJson(e)));
  }

  /// Requests jwt token [TokenResponse] from server.
  ///
  /// Requires [email] and [password]. Returns player object [TokenResponse]
  /// in case of success
  /// Throws [DioError] in case of network connection problems or
  /// null in case of Unauthorised server response
  Future<TokenResponse?> postToken(String email, String password) async {
    try {
      final Response<String> response = await _dio.post('/authentication_token',
          data: TokenRequest(email: email, password: password).toRawJson());
      return TokenResponse.fromRawJson(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return null;
      } else {
        rethrow;
      }
    }
  }
}
