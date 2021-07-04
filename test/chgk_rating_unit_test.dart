import 'package:chgk_rating/chgk_rating.dart';
import 'package:test/test.dart';

void main() {
  group('Utils test', () {
    test('singletonCheck', () {
      final ChgkRating chgkRating1 = ChgkRating();
      final ChgkRating chgkRating2 = ChgkRating();
      assert(identical(chgkRating1, chgkRating2));
    });
  });
}
