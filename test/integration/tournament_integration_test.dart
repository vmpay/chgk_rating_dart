import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/error_response.dart';
import 'package:chgk_rating/src/models/tournament_appeals.dart';
import 'package:chgk_rating/src/models/tournament_requests.dart';
import 'package:chgk_rating/src/models/tournament_results.dart';
import 'package:test/test.dart';

void main() {
  const int notFoundId = -1;
  const int tournamentId = 5021;
  final ErrorResponse errorResponse = ErrorResponse(
      type: 'https:\/\/tools.ietf.org\/html\/rfc2616#section-10',
      title: 'An error occurred',
      detail: 'Not Found');
  final ChgkRating chgkRating = ChgkRating();

  group('getTournamentDetails', () {
    test('success', () async {
      final Tournament? tournamentDetails =
          await chgkRating.getTournamentDetails(tournamentId);
      assert(tournamentDetails != null);
    });

    test('empty', () async {
      expect(() => chgkRating.getTournamentDetails(notFoundId),
          throwsA(predicate((e) => e is ErrorResponse && e == errorResponse)));
    });
  });

  group('getTournamentBy search parameters', () {
    test('success', () async {
      final Iterable<Tournament> tournamentSearch =
          await chgkRating.getTournamentBy(name: 'Синхрон-lite. Выпуск XXII');
      assert(tournamentSearch.isNotEmpty == true);
    });
  });

  group('getTournamentResults', () {
    test('success', () async {
      final Iterable<TournamentResults> tournamentResult =
          await chgkRating.getTournamentResults(tournamentId);
      assert(tournamentResult.isNotEmpty);
    });

    test('empty', () async {
      expect(() => chgkRating.getTournamentResults(notFoundId),
          throwsA(predicate((e) => e is ErrorResponse)));
    });
  });

  group('getTournamentAppeals', () {
    test('success', () async {
      final Iterable<TournamentAppeals> tournamentAppeals =
          await chgkRating.getTournamentAppeals(tournamentId);
      assert(tournamentAppeals.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentAppeals> tournamentAppeals =
          await chgkRating.getTournamentAppeals(notFoundId);
      assert(tournamentAppeals.isEmpty);
    });
  });

  group('getTournamentRequests', () {
    test('success', () async {
      final Iterable<TournamentRequests> tournamentRequests =
          await chgkRating.getTournamentRequests(tournamentId);
      assert(tournamentRequests.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TournamentRequests> tournamentRequests =
          await chgkRating.getTournamentRequests(notFoundId);
      assert(tournamentRequests.isEmpty);
    });
  });
}
