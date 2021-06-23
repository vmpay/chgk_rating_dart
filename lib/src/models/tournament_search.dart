import 'dart:convert';

import 'tournament.dart';

/// Response example:
/// ```json
/// {
/// "items": [
///     {
///         "idtournament": "6431",
///         "name": "Онлайн: 22:00 MSK / KYIV  \"Триптих. Лето\" (NEW!)",
///         "date_start": "2021-06-04 22:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Обычный",
///         "archive": "2021-06-04 22:00:00",
///         "date_archived_at": "2021-06-04 22:00:00"
///     },
///     {
///         "idtournament": "6621",
///         "name": "Онлайн: 22:00 MSK / KYIV \"Молодежный чемпионат Приволжья\" (NEW!)",
///         "date_start": "2021-06-08 22:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Обычный",
///         "archive": "2021-06-04 22:00:00",
///         "date_archived_at": "2021-06-04 22:00:00"
///     }
/// ],
/// "total_items": "6122",
/// "current_items": "1-5"
/// }
/// ```
class TournamentSearch {
  TournamentSearch({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Tournament>? items;
  final String? totalItems;
  final String? currentItems;

  /// Decodes [TournamentSearch] object from json string
  factory TournamentSearch.fromJson(String str) =>
      TournamentSearch.fromMap(json.decode(str));

  /// Encodes [TournamentSearch] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TournamentSearch] object from json map
  factory TournamentSearch.fromMap(Map<String, dynamic> json) =>
      TournamentSearch(
        items: json['items'] == null
            ? null
            : List<Tournament>.from(
                json['items'].map((x) => Tournament.fromMap(x))),
        totalItems: json['total_items'] == null ? null : json['total_items'],
        currentItems:
            json['current_items'] == null ? null : json['current_items'],
      );

  /// Encodes [TournamentSearch] object to json map
  Map<String, dynamic> toMap() => {
        'items': items == null ? null : items,
        'total_items': totalItems == null ? null : totalItems,
        'current_items': currentItems == null ? null : currentItems,
      };

  @override
  String toString() {
    return 'TournamentSearch{items: $items, totalItems: $totalItems, currentItems: $currentItems}';
  }
}
