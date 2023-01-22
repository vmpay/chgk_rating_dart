import 'package:chgk_rating/chgk_rating.dart';

/// This example shows how to fetch [Player] data with additional information
Future<void> main() async {
  final ChgkRating chgkRating = ChgkRating();

  /// Search for the player by [name] and [surname]
  final Iterable<Player> playerSearch =
      await chgkRating.getPlayerBy(name: 'Денис', surname: 'Куценко');
  print('PlayerSearch data: $playerSearch');

  if (playerSearch.isNotEmpty) {
    final Player player = playerSearch.first;
    print('Player data: $player');
    final int playerId = player.id;

    /// Fetch player's teams
    final Iterable<PlayerTeam> playerTeamList =
        await chgkRating.getPlayerTeamList(playerId);
    print('PlayerTeam list data: $playerTeamList');
    final int teamId =
        playerTeamList.isNotEmpty ? playerTeamList.first.idTeam : 58380;

    /// Fetch player's tournaments for the last season
    final Iterable<PlayerTournament> playerTournamentResponse =
        await chgkRating.getPlayerTournamentList(playerId);
    print('PlayerTournamentResponse data: $playerTournamentResponse');
    final int tournamentId = playerTournamentResponse.isNotEmpty
        ? playerTournamentResponse.first.idTournament
        : 5021;

    /// Fetch team data using [teamId]
    final Team team = await chgkRating.getTeamById(teamId);
    print('Team data: $team');

    /// Fetch tournament details by [tournamentId]
    final Tournament tournamentDetails =
        await chgkRating.getTournamentDetails(tournamentId);
    print('TournamentDetails $tournamentDetails');

    /// Get user JWT token using email and password
    final TokenResponse? tokenResponse =
        await chgkRating.postToken('email@email.com', 'password');
    print('TokenResponse $tokenResponse');
  }
}
