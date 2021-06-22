import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/models/player.dart';
import 'package:chgk_rating/models/player_rating.dart';
import 'package:chgk_rating/models/player_search_response.dart';
import 'package:chgk_rating/models/player_team.dart';
import 'package:chgk_rating/models/player_tournament.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int playerId = 17579;
  final ChgkRating chgkRating = ChgkRating();

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
    final PlayerSearchResponse playerSearchResponse =
        await chgkRating.getPlayerBy(name: 'Андрей', patronymic: 'Васильевич');
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
}
