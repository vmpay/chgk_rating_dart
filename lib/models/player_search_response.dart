/// Response example:
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
///     },
///     {
///         "idplayer": "5076",
///         "surname": "Васильев",
///         "name": "Андрей",
///         "patronymic": "Юрьевич"
///     },
///     {
///         "idplayer": "6977",
///         "surname": "Гетманенко",
///         "name": "Андрей",
///         "patronymic": "Юрьевич"
///     },
///     {
///         "idplayer": "10110",
///         "surname": "Евдокимов",
///         "name": "Андрей",
///         "patronymic": "Юрьевич"
///     }
/// ],
/// "total_items": "169",
/// "current_items": "1-5"
/// }
import 'dart:convert';

import 'package:chgk_rating/models/player.dart';

class PlayerSearchResponse {
  PlayerSearchResponse({
    this.items,
    this.totalItems,
    this.currentItems,
  });

  final List<Player>? items;
  final String? totalItems;
  final String? currentItems;

  factory PlayerSearchResponse.fromJson(String str) =>
      PlayerSearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerSearchResponse.fromMap(Map<String, dynamic> json) =>
      PlayerSearchResponse(
        items: json["items"] == null
            ? null
            : List<Player>.from(json["items"].map((x) => Player.fromMap(x))),
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
    return 'PlayerSearchResponse{items: $items, totalItems: $totalItems, currentItems: $currentItems}';
  }
}
