/// Response example:
/// {
/// "items": [
///     {
///         "idteam": "58380",
///         "name": "Олег с мышами",
///         "town": "Варшава",
///         "region_name": null,
///         "country_name": "Польша",
///         "tournaments_this_season": "0",
///         "tournaments_total": "125"
///     }
/// ],
/// "total_items": "1",
/// "current_items": "1-100"
///  }
import 'dart:convert';

import 'package:chgk_rating/models/team.dart';

class TeamSearch {
  TeamSearch({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Team>? items;
  final String? totalItems;
  final String? currentItems;

  factory TeamSearch.fromJson(String str) =>
      TeamSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamSearch.fromMap(Map<String, dynamic> json) => TeamSearch(
        items: json["items"] == null
            ? null
            : List<Team>.from(json["items"].map((x) => Team.fromMap(x))),
        totalItems: json["total_items"] == null ? null : json["total_items"],
        currentItems:
            json["current_items"] == null ? null : json["current_items"],
      );

  Map<String, dynamic> toMap() => {
        "items": items == null ? null : items,
        "total_items": totalItems == null ? null : totalItems,
        "current_items": currentItems == null ? null : currentItems,
      };

  @override
  String toString() {
    return 'TeamSearch{items: $items, totalItems: $totalItems, currentItems: $currentItems}';
  }
}
