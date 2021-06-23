/// Response example:
/// [
/// {
///     "tour": "1",
///     "mask": [
///         "1",
///         "1",
///         "1",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0"
///     ]
/// },
/// {
///     "tour": "2",
///     "mask": [
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "1",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0"
///     ]
/// },
/// {
///     "tour": "3",
///     "mask": [
///         "1",
///         "1",
///         "0",
///         "0",
///         "1",
///         "1",
///         "0",
///         "0",
///         "1",
///         "1",
///         "1",
///         "1"
///     ]
/// },
/// {
///     "tour": "4",
///     "mask": [
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "0",
///         "1"
///     ]
/// }
/// ]
import 'dart:convert';

class TournamentResults {
  TournamentResults({
    this.tour,
    this.mask,
  });

  final String? tour;
  final List<String>? mask;

  factory TournamentResults.fromJson(String str) =>
      TournamentResults.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TournamentResults.fromMap(Map<String, dynamic> json) =>
      TournamentResults(
        tour: json['tour'] == null ? null : json['tour'],
        mask: json['mask'] == null
            ? null
            : List<String>.from(json['mask'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'tour': tour == null ? null : tour,
        'mask': mask == null ? null : mask,
      };

  @override
  String toString() {
    return 'TournamentResults{tour: $tour, mask: $mask}';
  }
}
