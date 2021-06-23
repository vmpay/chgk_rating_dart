import 'package:chgk_rating/chgk_rating.dart';

/// This example shows how to fetch [Player] data with additional information
Future<void> main() async {
  final ChgkRating chgkRating = ChgkRating();

  /// Search for the player by [name] and [surname]
  final PlayerSearch playerSearch =
      await chgkRating.getPlayerBy(name: 'Денис', surname: 'Куценко');
  print('PlayerSearch data: $playerSearch');

  if (playerSearch.items?.isNotEmpty == true) {
    final Player player = playerSearch.items!.first;
    print('Player data: $player');
    final String playerId = player.idPlayer;

    /// Fetch the latest player's rating
    final PlayerRating? playerRating =
        await chgkRating.getPlayerRatingLatest(playerId);
    print('PlayerRating data: $playerRating');

    /// Fetch player's teams
    final Iterable<PlayerTeam> playerTeamList =
        await chgkRating.getPlayerTeamList(playerId);
    print('PlayerTeam list data: $playerTeamList');
    final String teamId =
        playerTeamList.isNotEmpty ? playerTeamList.first.idTeam : '58380';

    /// Fetch player's tournaments for the last season
    final PlayerTournamentResponse playerTournamentResponse =
        await chgkRating.getPlayerTournamentLastSeason(playerId);
    print('PlayerTournamentResponse data: $playerTournamentResponse');
    final String tournamentId =
        playerTournamentResponse.tournaments?.isNotEmpty == true
            ? playerTournamentResponse.tournaments!.first.idTournament
            : '5021';

    /// Fetch team data using [teamId]
    final Team? team = await chgkRating.getTeamById(teamId);
    print('Team data: $team');

    /// Fetch tournament details by [tournamentId]
    final TournamentDetails? tournamentDetails =
        await chgkRating.getTournamentDetails(tournamentId);
    print('TournamentDetails $tournamentDetails');
  }
}
