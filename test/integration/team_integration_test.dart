import 'package:chgk_rating/chgk_rating.dart';
import 'package:test/test.dart';

void main() {
  const String notFoundId = '-1';
  const String teamId = '58380';
  const int releaseId = 1330;
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
      final TeamSearch teamSearch = await chgkRating.getTeamBy(name: 'Олег с');
      assert(teamSearch.items?.isNotEmpty == true);
    });
  });

  group('getTeamRatingById', () {
    test('success', () async {
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(teamId, releaseId);
      assert(teamRating != null);
    });

    test('not found', () async {
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(notFoundId, releaseId);
      assert(teamRating == null);
    });

    test('empty', () async {
      final TeamRating? teamRating =
          await chgkRating.getTeamRatingById(teamId, -1);
      assert(teamRating == null);
    });
  });

  group('getTeamRatingList', () {
    test('success', () async {
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(teamId);
      assert(teamRatingList.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TeamRating> teamRatingList =
          await chgkRating.getTeamRatingList(notFoundId);
      assert(teamRatingList.isEmpty);
    });
  });

  group('getTeamPlayersLastSeason', () {
    test('success', () async {
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(teamId);
      assert(teamPlayers != null);
    });

    test('empty', () async {
      final TeamPlayers? teamPlayers =
          await chgkRating.getTeamPlayersLastSeason(notFoundId);
      assert(teamPlayers == null);
    });
  });

  group('getTeamPlayersList', () {
    test('success', () async {
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList(teamId);
      assert(teamPlayersList.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TeamPlayers> teamPlayersList =
          await chgkRating.getTeamPlayersList(notFoundId);
      assert(teamPlayersList.isEmpty);
    });
  });

  group('getTeamTournamentLast', () {
    test('success', () async {
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast(teamId);
      assert(teamTournament != null);
    });

    test('empty', () async {
      final TeamTournament? teamTournament =
          await chgkRating.getTeamTournamentLast(notFoundId);
      assert(teamTournament == null);
    });
  });

  group('getTeamTournamentList', () {
    test('success', () async {
      final Iterable<TeamTournament> teamTournament =
          await chgkRating.getTeamTournamentList(teamId);
      assert(teamTournament.isNotEmpty);
    });

    test('empty', () async {
      final Iterable<TeamTournament> teamTournament =
          await chgkRating.getTeamTournamentList(notFoundId);
      assert(teamTournament.isEmpty);
    });
  });
}
