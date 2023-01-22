import 'package:chgk_rating/chgk_rating.dart';
import 'package:chgk_rating/src/models/token_response.dart';
import 'package:test/test.dart';

void main() {
  final ChgkRating chgkRating = ChgkRating();

  group('postToken', () {
    // test('success', () async {
    //   final TokenResponse? tokenResponse =
    //       await chgkRating.postToken('', '');
    //   assert(tokenResponse != null);
    // });

    test('empty', () async {
      final TokenResponse? tokenResponse = await chgkRating.postToken('', '');
      assert(tokenResponse == null);
    });
  });
}
