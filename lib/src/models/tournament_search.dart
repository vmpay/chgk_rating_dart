/// Response example:
/// {
/// "items": [
///     {
///         "idtournament": "6431",
///         "name": "Онлайн: 22:00 MSK / KYIV  \"Триптих. Лето\" (NEW!)",
///         "date_start": "2021-06-04 22:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Обычный",
///         "archive": null,
///         "date_archived_at": null
///     },
///     {
///         "idtournament": "6621",
///         "name": "Онлайн: 22:00 MSK / KYIV \"Молодежный чемпионат Приволжья\" (NEW!)",
///         "date_start": "2021-06-08 22:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Обычный",
///         "archive": null,
///         "date_archived_at": null
///     },
///     {
///         "idtournament": "7004",
///         "name": "Онлайн: 22:00 MSK / KYIV Лига Старта 26 - май",
///         "date_start": "2021-05-08 22:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Обычный",
///         "archive": null,
///         "date_archived_at": null
///     },
///     {
///         "idtournament": "7178",
///         "name": "Молодежный чемпионат ПФО. Первый этап",
///         "date_start": "2021-05-24 12:00:00",
///         "date_end": "0000-00-00 00:00:00",
///         "type_name": "Асинхрон",
///         "archive": "1",
///         "date_archived_at": "2021-05-22 00:00:00"
///     },
///     {
///         "idtournament": "1999",
///         "name": "Тульский фестиваль",
///         "date_start": "1992-09-08 00:00:00",
///         "date_end": "1992-09-10 00:00:00",
///         "type_name": "Обычный",
///         "archive": null,
///         "date_archived_at": null
///     }
/// ],
/// "total_items": "6122",
/// "current_items": "1-5"
/// }
import 'dart:convert';

import 'tournament.dart';

class TournamentSearch {
  TournamentSearch({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Tournament>? items;
  final String? totalItems;
  final String? currentItems;

  factory TournamentSearch.fromJson(String str) =>
      TournamentSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
