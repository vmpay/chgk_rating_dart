import 'package:chgk_rating/chgk_rating.dart';
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
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int playerId = 17579;
  const int teamId = 58380;
  const int releaseId = 1330;
  final ChgkRating chgkRating = ChgkRating();

  group('Player test group', () {
    test('singletonCheck', () {
      final ChgkRating chgkRating1 = ChgkRating();
      final ChgkRating chgkRating2 = ChgkRating();
      assert(identical(chgkRating1, chgkRating2));
    });

    test('getPlayerById', () async {
      final Player? player = await chgkRating.getPlayerById(playerId);
      print('Player $player');
    });

    test('getPlayerBy', () async {
      final PlayerSearch playerSearchResponse = await chgkRating.getPlayerBy(
          name: 'Андрей', patronymic: 'Васильевич');
      print('PlayerSearchResponse $playerSearchResponse');
    });

    test('getPlayerRatingLatest', () async {
      final PlayerRating playerRating =
          await chgkRating.getPlayerRatingLatest(playerId);
      print('PlayerRating $playerRating');
    });

    test('getPlayerRatingList', () async {
      final Iterable<PlayerRating> playerRating =
          await chgkRating.getPlayerRatingList(playerId);
      print('PlayerRatingList ${playerRating.take(5)}');
    });

    test('getPlayerTeamList', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamList(playerId);
      print('PlayerRatingList ${playerTeam.take(5)}');
    });

    test('getPlayerTeamLastSeason', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamLastSeason(playerId);
      print('PlayerRatingList $playerTeam');
    });

    test('getPlayerTournamentLastSeason', () async {
      final PlayerTournamentResponse playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(playerId);
      print('PlayerTournamentResponse $playerTournamentResponse');
    });

    test('getPlayerTournamentLastSeason', () async {
      final Iterable<PlayerTournamentResponse> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList(playerId);
      print('PlayerTournamentResponseList $playerTournamentResponseList');
    });
  });

  group('Team test group', () {
    test('getTeamById', () async {
      final Team? team = await chgkRating.getTeamById(teamId);
      print('Team $team');
    });

    test('getTeamBy', () async {
      final TeamSearch teamSearch = await chgkRating.getTeamBy(name: 'Олег с');
      print('TeamSearch $teamSearch');
    });

    test('getTeamRatingById', () async {
      final TeamRating teamRating =
          await chgkRating.getTeamRatingById(teamId, releaseId);
      print('TeamRating $teamRating');
    });

    test('getTeamRatingList', () async {
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(teamId);
      print('TeamRatingList ${teamRatingList.take(5)}');
    });

    test('getTeamPlayersLastSeason', () async {
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(teamId);
      print('TeamPlayers $teamPlayers');
    });

    test('getTeamPlayersList', () async {
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList(teamId);
      print('TeamPlayersList $teamPlayersList');
    });

    test('getTeamTournamentLast', () async {
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast(teamId);
      print('TeamTournament $teamTournament');
    });

    test('getTeamTournamentList', () async {
      final Iterable<TeamTournament> teamTournament =
          await chgkRating.getTeamTournamentList(teamId);
      print('TeamTournament $teamTournament');
    });
  });
}
