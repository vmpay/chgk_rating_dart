import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/player.dart';
import 'package:chgk_rating/src/models/player_rating.dart';
import 'package:chgk_rating/src/models/player_search.dart';
import 'package:chgk_rating/src/models/player_team.dart';
import 'package:chgk_rating/src/models/player_tournament.dart';
import 'package:test/test.dart';

void main() {
  const String notFoundId = '-1';
  const String playerId = '17579';
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
      final PlayerSearch playerSearchResponse = await chgkRating.getPlayerBy(
          name: 'Андрей', patronymic: 'Васильевич');
      assert(playerSearchResponse.items?.isNotEmpty == true);
    });
  });

  group('getPlayerRatingLatest', () {
    test('success', () async {
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest(playerId);
      assert(playerRating != null);
    });

    test('empty', () async {
      final PlayerRating? playerRating =
          await chgkRating.getPlayerRatingLatest(notFoundId);
      assert(playerRating == null);
    });
  });

  group('getPlayerRatingList', () {
    test('success', () async {
      final Iterable<PlayerRating> playerRating =
          await chgkRating.getPlayerRatingList(playerId);
      assert(playerRating.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerRating> playerRating =
          await chgkRating.getPlayerRatingList(notFoundId);
      assert(playerRating.isEmpty);
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

  group('getPlayerTeamLastSeason', () {
    test('success', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamLastSeason(playerId);
      assert(playerTeam.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTeam> playerTeam =
          await chgkRating.getPlayerTeamLastSeason(notFoundId);
      assert(playerTeam.isEmpty);
    });
  });

  group('getPlayerTournamentLastSeason', () {
    test('success', () async {
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(playerId);
      assert(playerTournamentResponse != null);
    });

    test('empty', () async {
      final PlayerTournamentResponse? playerTournamentResponse =
          await chgkRating.getPlayerTournamentLastSeason(notFoundId);
      assert(playerTournamentResponse == null);
    });
  });

  group('getPlayerTournamentLastSeason', () {
    test('success', () async {
      final Iterable<PlayerTournamentResponse> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList(playerId);
      assert(playerTournamentResponseList.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTournamentResponse> playerTournamentResponseList =
          await chgkRating.getPlayerTournamentList(notFoundId);
      assert(playerTournamentResponseList.isEmpty);
    });
  });
}
