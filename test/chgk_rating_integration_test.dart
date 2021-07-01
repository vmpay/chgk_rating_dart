import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/player.dart';
import 'package:chgk_rating/src/models/player_rating.dart';
import 'package:chgk_rating/src/models/player_search.dart';
import 'package:chgk_rating/src/models/player_team.dart';
import 'package:chgk_rating/src/models/player_tournament.dart';
import 'package:chgk_rating/src/models/team.dart';
import 'package:chgk_rating/src/models/team_players.dart';
import 'package:chgk_rating/src/models/team_rating.dart';
import 'package:chgk_rating/src/models/team_search.dart';
import 'package:chgk_rating/src/models/team_tournament.dart';
import 'package:chgk_rating/src/models/tournament_appeal.dart';
import 'package:chgk_rating/src/models/tournament_controversial.dart';
import 'package:chgk_rating/src/models/tournament_details.dart';
import 'package:chgk_rating/src/models/tournament_results.dart';
import 'package:chgk_rating/src/models/tournament_search.dart';
import 'package:chgk_rating/src/models/tournament_team_players.dart';
import 'package:chgk_rating/src/models/tournament_team_results.dart';
import 'package:test/test.dart';

void main() {
  const int playerId = 17579;
  const int teamId = 58380;
  const int tournamentId = 5021;
  const int releaseId = 1330;
  final ChgkRating chgkRating = ChgkRating();

  group('Player test group', () {
    test('getPlayerById', () async {
      final Player? player = await chgkRating.getPlayerById('$playerId');
      print('Player $player');
    });

    test('getPlayerBy search parameters', () async {
      final PlayerSearch playerSearchResponse = await chgkRating.getPlayerBy(
          name: 'Андрей', patronymic: 'Васильевич');
      print('PlayerSearchResponse $playerSearchResponse');
    });

    test('getPlayerRatingLatest', () async {
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest('$playerId');
      print('PlayerRating $playerRating');
    });

    test('getPlayerRatingList', () async {
      final Iterable<PlayerRating> playerRating =
          await chgkRating.getPlayerRatingList('$playerId');
      print('PlayerRatingList ${playerRating.take(5)}');
    });

    test('getPlayerTeamList', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamList('$playerId');
      print('PlayerRatingList ${playerTeam.take(5)}');
    });

    test('getPlayerTeamLastSeason', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamLastSeason('$playerId');
      print('PlayerRatingList $playerTeam');
    });

    test('getPlayerTournamentLastSeason', () async {
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason('$playerId');
      print('PlayerTournamentResponse $playerTournamentResponse');
    });

    test('getPlayerTournamentLastSeason', () async {
      final Iterable<PlayerTournamentResponse> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList('$playerId');
      print('PlayerTournamentResponseList $playerTournamentResponseList');
    });
  });

  group('Team test group', () {
    test('getTeamById', () async {
      final Team? team = await chgkRating.getTeamById('$teamId');
      print('Team $team');
    });

    test('getTeamBy', () async {
      final TeamSearch teamSearch = await chgkRating.getTeamBy(name: 'Олег с');
      print('TeamSearch $teamSearch');
    });

    test('getTeamRatingById', () async {
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById('$teamId', releaseId);
      print('TeamRating $teamRating');
    });

    test('getTeamRatingList', () async {
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList('$teamId');
      print('TeamRatingList ${teamRatingList.take(5)}');
    });

    test('getTeamPlayersLastSeason', () async {
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason('$teamId');
      print('TeamPlayers $teamPlayers');
    });

    test('getTeamPlayersList', () async {
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList('$teamId');
      print('TeamPlayersList $teamPlayersList');
    });

    test('getTeamTournamentLast', () async {
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast('$teamId');
      print('TeamTournament $teamTournament');
    });

    test('getTeamTournamentList', () async {
      final Iterable<TeamTournament> teamTournament =
          await chgkRating.getTeamTournamentList('$teamId');
      print('TeamTournament $teamTournament');
    });
  });

  group('Tournament test group', () {
    test('getTournamentDetails', () async {
      final TournamentDetails? tournamentDetails =
          await chgkRating.getTournamentDetails('$tournamentId');
      print('TournamentDetails $tournamentDetails');
    });

    test('getTournamentBy', () async {
      final TournamentSearch tournamentSearch =
          await chgkRating.getTournamentBy(name: 'Синхрон-lite. Выпуск XXII');
      print('TournamentSearch $tournamentSearch');
    });

    test('getTournamentResults', () async {
      final Iterable<TournamentTeamResults> tournamentResult =
          await chgkRating.getTournamentResults('$tournamentId');
      print('tournamentResult ${tournamentResult.take(5)}');
    });

    test('getTournamentTeamPlayersByTeam', () async {
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayers =
          await chgkRating.getTournamentTeamPlayersByTeam(
              '$tournamentId', '$teamId');
      print('TournamentTeamPlayersList $tournamentTeamPlayers');
    });

    test('getTournamentTeamPlayers', () async {
      final Iterable<TournamentTeam> tournamentTeam =
          await chgkRating.getTournamentTeamPlayers('$tournamentId');
      print('TournamentTeam ${tournamentTeam.take(5)}');
    });

    test('getTournamentResultsByTeam', () async {
      final Iterable<TournamentResults> tournamentResults = await chgkRating
          .getTournamentResultsByTeam('$tournamentId', '$teamId');
      print('TournamentTeam $tournamentResults');
    });

    test('getTournamentControversialQuestions', () async {
      final Iterable<TournamentControversial> tournamentControversial =
          await chgkRating.getTournamentControversialQuestions('$tournamentId');
      print('TournamentControversial $tournamentControversial');
    });

    test('getTournamentAppealQuestions', () async {
      final Iterable<TournamentAppeal> tournamentAppeal =
          await chgkRating.getTournamentAppealQuestions('$tournamentId');
      print('TournamentAppeal $tournamentAppeal');
    });
  });
}
