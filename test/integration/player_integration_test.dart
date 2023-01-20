import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/player.dart';
import 'package:chgk_rating/src/models/player_team.dart';
import 'package:chgk_rating/src/models/player_tournament.dart';
import 'package:test/test.dart';

void main() {
  const int notFoundId = -1;
  const int playerId = 17579;
  final ChgkRating chgkRating = ChgkRating();

  group('getPlayerById', () {
    test('success', () async {
      final Player? player = await chgkRating.getPlayerById(playerId);
      assert(player != null);
    });

    test('empty', () async {
      final Player? player = await chgkRating.getPlayerById(notFoundId);
      assert(player == null);
    });
  });

  group('getPlayerBy search parameters', () {
    test('success', () async {
      final Iterable<Player> playerSearchResponse =
          await chgkRating.getPlayerBy(name: 'Андрей');
      assert(playerSearchResponse.isNotEmpty == true);
    });
  });

  group('getPlayerTeamList', () {
    test('success', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamList(playerId);
      assert(playerTeam.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamList(notFoundId);
      assert(playerTeam.isEmpty);
    });
  });

  group('getPlayerTournamentLastSeason', () {
    test('success', () async {
      final Iterable<PlayerTournament> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList(playerId);
      assert(playerTournamentResponseList.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTournament> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList(notFoundId);
      assert(playerTournamentResponseList.isEmpty);
    });
  });
}
