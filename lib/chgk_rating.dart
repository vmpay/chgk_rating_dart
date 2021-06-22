library chgk_rating;

import 'src/chgk_rating_service.dart';
import 'src/models/player.dart';
import 'src/models/player_rating.dart';
import 'src/models/player_search.dart';
import 'src/models/player_team.dart';
import 'src/models/player_tournament.dart';
import 'src/models/team.dart';
import 'src/models/team_players.dart';
import 'src/models/team_rating.dart';
import 'src/models/team_search.dart';
import 'src/models/team_tournament.dart';
import 'src/models/tournament_appeal.dart';
import 'src/models/tournament_controversial.dart';
import 'src/models/tournament_details.dart';
import 'src/models/tournament_results.dart';
import 'src/models/tournament_search.dart';
import 'src/models/tournament_team_players.dart';
import 'src/models/tournament_team_results.dart';

// TODO documentation
class ChgkRating {
  static final ChgkRating _chgkRating = ChgkRating._internal();

  factory ChgkRating() => _chgkRating;

  ChgkRating._internal();

  final ChgkRatingService _chgkRatingService = ChgkRatingService();

  /// Documentation goes here
  Future<Player?> getPlayerById(int playerId) =>
      _chgkRatingService.getPlayerById(playerId);

  Future<PlayerSearch> getPlayerBy(
          {String? name, String? surname, String? patronymic}) =>
      _chgkRatingService.getPlayerBy(
          name: name, surname: surname, patronymic: patronymic);

  Future<PlayerRating> getPlayerRatingLatest(int playerId) =>
      _chgkRatingService.getPlayerRatingLatest(playerId);

  Future<Iterable<PlayerRating>> getPlayerRatingList(int playerId) =>
      _chgkRatingService.getPlayerRatingList(playerId);

  Future<Iterable<PlayerTeam>> getPlayerTeamList(int playerId) =>
      _chgkRatingService.getPlayerTeamList(playerId);

  Future<Iterable<PlayerTeam>> getPlayerTeamLastSeason(int playerId) =>
      _chgkRatingService.getPlayerTeamLastSeason(playerId);

  Future<PlayerTournamentResponse> getPlayerTournamentLastSeason(
          int playerId) =>
      _chgkRatingService.getPlayerTournamentLastSeason(playerId);

  Future<Iterable<PlayerTournamentResponse>> getPlayerTournamentList(
          int playerId) =>
      _chgkRatingService.getPlayerTournamentList(playerId);

  Future<Team?> getTeamById(int teamId) =>
      _chgkRatingService.getTeamById(teamId);

  Future<TeamSearch> getTeamBy(
          {String? name,
          String? town,
          String? regionName,
          String? countryName}) =>
      _chgkRatingService.getTeamBy(
          name: name,
          town: town,
          regionName: regionName,
          countryName: countryName);

  Future<TeamRating> getTeamRatingById(int teamId, int releaseId) =>
      _chgkRatingService.getTeamRatingById(teamId, releaseId);

  Future<Iterable<TeamRating>> getTeamRatingList(int teamId) =>
      _chgkRatingService.getTeamRatingList(teamId);

  Future<TeamPlayers?> getTeamPlayersLastSeason(int teamId) =>
      _chgkRatingService.getTeamPlayersLastSeason(teamId);

  Future<Iterable<TeamPlayers>> getTeamPlayersList(int teamId) =>
      _chgkRatingService.getTeamPlayersList(teamId);

  Future<TeamTournament?> getTeamTournamentLast(int teamId) =>
      _chgkRatingService.getTeamTournamentLast(teamId);

  Future<Iterable<TeamTournament>> getTeamTournamentList(int teamId) =>
      _chgkRatingService.getTeamTournamentList(teamId);

  Future<TournamentDetails?> getTournamentDetails(int tournamentId) =>
      _chgkRatingService.getTournamentDetails(tournamentId);

  Future<TournamentSearch> getTournamentBy(
          {String? name, String? typeName, String? archive}) =>
      _chgkRatingService.getTournamentBy(
          name: name, typeName: typeName, archive: archive);

  Future<Iterable<TournamentTeamResults>> getTournamentResults(
          int tournamentId) =>
      _chgkRatingService.getTournamentResults(tournamentId);

  Future<Iterable<TournamentTeamPlayer>> getTournamentTeamPlayersByTeam(
          int tournamentId, int teamId) =>
      _chgkRatingService.getTournamentTeamPlayersByTeam(tournamentId, teamId);

  Future<Iterable<TournamentTeam>> getTournamentTeamPlayers(int tournamentId) =>
      _chgkRatingService.getTournamentTeamPlayers(tournamentId);

  Future<Iterable<TournamentResults>> getTournamentResultsByTeam(
          int tournamentId, int teamId) =>
      _chgkRatingService.getTournamentResultsByTeam(tournamentId, teamId);

  Future<Iterable<TournamentControversial>> getTournamentControversialQuestions(
          int tournamentId) =>
      _chgkRatingService.getTournamentControversialQuestions(tournamentId);

  Future<Iterable<TournamentAppeal>> getTournamentAppealQuestions(
          int tournamentId) =>
      _chgkRatingService.getTournamentAppealQuestions(tournamentId);
}
