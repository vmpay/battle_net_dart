import 'dart:convert';

import 'package:meta/meta.dart';

// ---------------------------------------------------------------------------
// ForeverItemResponse
// ---------------------------------------------------------------------------

/// Response for `getItemData` (`GET /data/wow/item/{itemId}`).
@immutable
class ForeverItemResponse {
  final int id;
  final String? name;
  final int? quality;
  final int? itemLevel;
  final int? requiredLevel;
  final int? itemClassId;
  final int? itemSubclassId;

  const ForeverItemResponse({
    required this.id,
    this.name,
    this.quality,
    this.itemLevel,
    this.requiredLevel,
    this.itemClassId,
    this.itemSubclassId,
  });

  factory ForeverItemResponse.fromRawJson(String str) =>
      ForeverItemResponse.fromJson(json.decode(str));

  factory ForeverItemResponse.fromJson(Map<String, dynamic> j) =>
      ForeverItemResponse(
        id: (j['id'] as num?)?.toInt() ?? 0,
        name: j['name'] as String?,
        quality: (j['quality']?['type'] != null)
            ? _qualityToInt(j['quality']['type'] as String)
            : null,
        itemLevel: (j['level'] as num?)?.toInt(),
        requiredLevel: (j['required_level'] as num?)?.toInt(),
        itemClassId: (j['item_class']?['id'] as num?)?.toInt(),
        itemSubclassId: (j['item_subclass']?['id'] as num?)?.toInt(),
      );

  static int _qualityToInt(String type) {
    const Map<String, int> map = <String, int>{
      'POOR': 0,
      'COMMON': 1,
      'UNCOMMON': 2,
      'RARE': 3,
      'EPIC': 4,
      'LEGENDARY': 5,
      'ARTIFACT': 6,
      'HEIRLOOM': 7,
    };
    return map[type] ?? 1;
  }

  @override
  String toString() =>
      'ForeverItemResponse{id: $id, name: $name, itemLevel: $itemLevel}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverItemResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
