import 'package:chgk_rating/chgk_rating.dart';
import 'package:test/test.dart';

void main() {
  const String notFoundId = '-1';
  const String teamId = '58380';
  const String tournamentId = '5021';
  final ChgkRating chgkRating = ChgkRating();

  group('getTournamentDetails', () {
    test('success', () async {
      final TournamentDetails? tournamentDetails =
          await chgkRating.getTournamentDetails(tournamentId);
      assert(tournamentDetails != null);
    });

    test('empty', () async {
      final TournamentDetails? tournamentDetails =
          await chgkRating.getTournamentDetails(notFoundId);
      assert(tournamentDetails == null);
    });
  });

  group('getTournamentBy search parameters', () {
    test('success', () async {
      final TournamentSearch tournamentSearch =
          await chgkRating.getTournamentBy(name: 'Синхрон-lite. Выпуск XXII');
      assert(tournamentSearch.items?.isNotEmpty == true);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      final Iterable<TournamentTeamResults> tournamentResult =
          await chgkRating.getTournamentResults(tournamentId);
      assert(tournamentResult.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentTeamResults> tournamentResult =
          await chgkRating.getTournamentResults(notFoundId);
      assert(tournamentResult.isEmpty);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayers =
          await chgkRating.getTournamentTeamPlayersByTeam(tournamentId, teamId);
      assert(tournamentTeamPlayers.isNotEmpty);
    });

    test('edge empty', () async {
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayers =
          await chgkRating.getTournamentTeamPlayersByTeam(
              notFoundId, notFoundId);
      assert(tournamentTeamPlayers.isEmpty);
    });

    test('corner tournament empty', () async {
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayers =
          await chgkRating.getTournamentTeamPlayersByTeam(notFoundId, teamId);
      assert(tournamentTeamPlayers.isEmpty);
    });

    test('corner team empty', () async {
      final Iterable<TournamentTeamPlayer> tournamentTeamPlayers =
          await chgkRating.getTournamentTeamPlayersByTeam(
              tournamentId, notFoundId);
      assert(tournamentTeamPlayers.isEmpty);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      final Iterable<TournamentTeam> tournamentTeam =
          await chgkRating.getTournamentTeamPlayers(tournamentId);
      assert(tournamentTeam.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentTeam> tournamentTeam =
          await chgkRating.getTournamentTeamPlayers(notFoundId);
      assert(tournamentTeam.isEmpty);
    });
  });

  group('getTournamentResultsByTeam', () {
    test('success', () async {
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(tournamentId, teamId);
      assert(tournamentResults.isNotEmpty);
    });

    test('edge empty', () async {
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(notFoundId, notFoundId);
      assert(tournamentResults.isEmpty);
    });

    test('corner tournament empty', () async {
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(notFoundId, teamId);
      assert(tournamentResults.isEmpty);
    });

    test('corner team empty', () async {
      final Iterable<TournamentResults> tournamentResults =
          await chgkRating.getTournamentResultsByTeam(tournamentId, notFoundId);
      assert(tournamentResults.isEmpty);
    });
  });

  group('getTournamentControversialQuestions', () {
    test('success', () async {
      final Iterable<TournamentControversial> tournamentControversial =
          await chgkRating.getTournamentControversialQuestions(tournamentId);
      assert(tournamentControversial.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentControversial> tournamentControversial =
          await chgkRating.getTournamentControversialQuestions(notFoundId);
      assert(tournamentControversial.isEmpty);
    });
  });

  group('getTournamentAppealQuestions', () {
    test('success', () async {
      final Iterable<TournamentAppeal> tournamentAppeal =
          await chgkRating.getTournamentAppealQuestions(tournamentId);
      assert(tournamentAppeal.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentAppeal> tournamentAppeal =
          await chgkRating.getTournamentAppealQuestions(notFoundId);
      assert(tournamentAppeal.isEmpty);
    });
  });
}
