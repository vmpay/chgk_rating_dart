import 'package:chgk_rating/chgk_rating.dart';
import 'package:test/test.dart';

void main() {
  const int notFoundId = -1;
  const int teamId = 58380;
  final ChgkRating chgkRating = ChgkRating();

  group('getTeamById', () {
    test('success', () async {
      final Team? team = await chgkRating.getTeamById(teamId);
      assert(team != null);
    });

    test('empty', () async {
      final Team? team = await chgkRating.getTeamById(notFoundId);
      assert(team == null);
    });
  });

  group('getTeamBy search parameters', () {
    test('success', () async {
      final Iterable<Team> teamSearch =
          await chgkRating.getTeamBy(name: 'Олег с');
      assert(teamSearch.isNotEmpty == true);
    });
  });

  group('getTeamPlayersList', () {
    test('success', () async {
      final Iterable<PlayerTeam> teamPlayersList =
          await chgkRating.getTeamPlayersList(teamId);
      assert(teamPlayersList.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTeam> teamPlayersList =
          await chgkRating.getTeamPlayersList(notFoundId);
      assert(teamPlayersList.isEmpty);
    });
  });

  group('getTeamTournamentList', () {
    test('success', () async {
      final Iterable<PlayerTournament> teamTournament =
          await chgkRating.getTeamTournamentList(teamId);
      assert(teamTournament.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<PlayerTournament> teamTournament =
          await chgkRating.getTeamTournamentList(notFoundId);
      assert(teamTournament.isEmpty);
    });
  });
}
