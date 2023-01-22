import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/error_response.dart';
import 'package:test/test.dart';

void main() {
  const int notFoundId = -1;
  const int playerId = 17579;
  final ErrorResponse errorResponse = ErrorResponse(
      type: 'https://tools.ietf.org/html/rfc2616#section-10',
      title: 'An error occurred',
      detail: 'Not Found');
  final ChgkRating chgkRating = ChgkRating();

  group('getPlayerById', () {
    test('success', () async {
      final Player player = await chgkRating.getPlayerById(playerId);
      assert(player.id != notFoundId);
    });

    test('empty', () async {
      expect(() => chgkRating.getPlayerById(notFoundId),
          throwsA(predicate((Object? e) => e is ErrorResponse && e == errorResponse)));
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
