import 'dart:convert';

import 'package:meta/meta.dart';

/// Response example:
/// ```json
/// [
/// {
///     "tour": "1",
///     "mask": [
///         "1", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0"
///     ]
/// },
/// {
///     "tour": "2",
///     "mask": [
///         "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0"
///     ]
/// },
/// {
///     "tour": "3",
///     "mask": [
///         "1", "1", "0", "0", "1", "1", "0", "0", "1", "1", "1", "1"
///     ]
/// },
/// {
///     "tour": "4",
///     "mask": [
///         "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1"
///     ]
/// }
/// ]
/// ```
@immutable
class TournamentResults {
  const TournamentResults({
    this.tour,
    this.mask,
  });

  final String? tour;
  final List<String>? mask;

  /// Decodes [TournamentResults] object from json string
  factory TournamentResults.fromJson(String str) =>
      TournamentResults.fromMap(json.decode(str));

  /// Encodes [TournamentResults] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentResults] object from json map
  factory TournamentResults.fromMap(Map<String, dynamic> json) =>
      TournamentResults(
        tour: json['tour'] == null ? null : json['tour'],
        mask: json['mask'] == null
            ? null
            : List<String>.from(json['mask'].map((x) => x)),
      );

  /// Encodes [TournamentResults] object to json map
  Map<String, dynamic> toMap() => {
        'tour': tour == null ? null : tour,
        'mask': mask == null ? null : mask,
      };

  @override
  String toString() {
    return 'TournamentResults{tour: $tour, mask: $mask}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentResults &&
          runtimeType == other.runtimeType &&
          tour == other.tour &&
          mask == other.mask;

  @override
  int get hashCode => tour.hashCode ^ mask.hashCode;
}
