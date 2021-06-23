import 'dart:convert';

import 'player.dart';

/// Response example:
/// ```json
/// {
/// "items": [
///     {
///         "idplayer": "3281",
///         "surname": "Бескрёстнов",
///         "name": "Андрей",
///         "patronymic": "Юрьевич"
///     },
///     {
///         "idplayer": "3903",
///         "surname": "Бондарь",
///         "name": "Андрей",
///         "patronymic": "Юрьевич"
///     }
/// ],
/// "total_items": "169",
/// "current_items": "1-1000"
/// }
/// ```
class PlayerSearch {
  PlayerSearch({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Player>? items;
  final String? totalItems;
  final String? currentItems;

  /// Decodes [PlayerSearch] object from json string
  factory PlayerSearch.fromJson(String str) =>
      PlayerSearch.fromMap(json.decode(str));

  /// Encodes [PlayerSearch] object to json string
  String toJson() => json.encode(toMap());

  /// Decodes [PlayerSearch] object from json map
  factory PlayerSearch.fromMap(Map<String, dynamic> json) => PlayerSearch(
        items: json['items'] == null
            ? null
            : List<Player>.from(json['items'].map((x) => Player.fromMap(x))),
        totalItems: json['total_items'] == null ? null : json['total_items'],
        currentItems:
            json['current_items'] == null ? null : json['current_items'],
      );

  /// Encodes [PlayerSearch] object to json map
  Map<String, dynamic> toMap() => {
        'items': items == null ? null : items,
        'total_items': totalItems == null ? null : totalItems,
        'current_items': currentItems == null ? null : currentItems,
      };

  @override
  String toString() {
    return 'PlayerSearchResponse{items: $items, totalItems: $totalItems, currentItems: $currentItems}';
  }
}
