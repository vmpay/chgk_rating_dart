import 'dart:convert';

import 'package:meta/meta.dart';

import 'team.dart';

/// Response example:
/// ```json
/// {
/// "items": [
///     {
///         "idteam": "58380",
///         "name": "Олег с мышами",
///         "town": "Варшава",
///         "region_name": "Мазовецкое воеводство",
///         "country_name": "Польша",
///         "tournaments_this_season": "0",
///         "tournaments_total": "125"
///     }
/// ],
/// "total_items": "1",
/// "current_items": "1-100"
///  }
///  ```
@immutable
class TeamSearch {
  const TeamSearch({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Team>? items;
  final String? totalItems;
  final String? currentItems;

  /// Decodes [TeamSearch] object from json string
  factory TeamSearch.fromJson(String str) =>
      TeamSearch.fromMap(json.decode(str));

  /// Encodes [TeamSearch] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [TeamSearch] object from json map
  factory TeamSearch.fromMap(Map<String, dynamic> json) => TeamSearch(
        items: json['items'] == null
            ? null
            : List<Team>.from(json['items'].map((x) => Team.fromMap(x))),
        totalItems: json['total_items'] == null ? null : json['total_items'],
        currentItems:
            json['current_items'] == null ? null : json['current_items'],
      );

  /// Encodes [TeamSearch] object to json map
  Map<String, dynamic> toMap() => {
        'items': items == null ? null : items,
        'total_items': totalItems == null ? null : totalItems,
        'current_items': currentItems == null ? null : currentItems,
      };

  @override
  String toString() {
    return 'TeamSearch{items: $items, totalItems: $totalItems, currentItems: $currentItems}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamSearch &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          totalItems == other.totalItems &&
          currentItems == other.currentItems;

  @override
  int get hashCode =>
      items.hashCode ^ totalItems.hashCode ^ currentItems.hashCode;
}
