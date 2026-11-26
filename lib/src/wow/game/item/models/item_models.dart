import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/item-class/index`.
class ItemClassesIndexResponse extends ApiModel {
  /// Creates an [ItemClassesIndexResponse] from its JSON object.
  ItemClassesIndexResponse(super.raw);

  /// All item classes.
  List<KeyedRef> get itemClasses => refsOf('item_classes');
}

/// Response of `GET /data/wow/item-class/{itemClassId}`.
class ItemClassResponse extends ApiModel {
  /// Creates an [ItemClassResponse] from its JSON object.
  ItemClassResponse(super.raw);

  /// The item class ID.
  int? get id => intOf('id');

  /// The localized item class name.
  String? get name => stringOf('name');

  /// The subclasses of this item class.
  List<KeyedRef> get itemSubclasses => refsOf('item_subclasses');
}

/// Response of `GET /data/wow/item-class/{itemClassId}/item-subclass/{itemSubclassId}`.
class ItemSubclassResponse extends ApiModel {
  /// Creates an [ItemSubclassResponse] from its JSON object.
  ItemSubclassResponse(super.raw);

  /// The item subclass ID.
  int? get id => intOf('id');

  /// The localized display name.
  String? get displayName => stringOf('display_name');

  /// The localized verbose name.
  String? get verboseName => stringOf('verbose_name');

  /// The parent item class.
  KeyedRef? get itemClass => refOf('item_class');
}

/// Response of `GET /data/wow/item-set/index`.
class ItemSetsIndexResponse extends ApiModel {
  /// Creates an [ItemSetsIndexResponse] from its JSON object.
  ItemSetsIndexResponse(super.raw);

  /// All item sets.
  List<KeyedRef> get itemSets => refsOf('item_sets');
}

/// Response of `GET /data/wow/item-set/{itemSetId}`.
class ItemSetResponse extends ApiModel {
  /// Creates an [ItemSetResponse] from its JSON object.
  ItemSetResponse(super.raw);

  /// The item set ID.
  int? get id => intOf('id');

  /// The localized item set name.
  String? get name => stringOf('name');

  /// The items of the set.
  List<KeyedRef> get items => refsOf('items');
}

/// Response of `GET /data/wow/item/{itemId}`.
class ItemResponse extends ApiModel {
  /// Creates an [ItemResponse] from its JSON object.
  ItemResponse(super.raw);

  /// The item ID.
  int? get id => intOf('id');

  /// The localized item name.
  String? get name => stringOf('name');

  /// The item quality, for example `EPIC` or `LEGENDARY`.
  String? get quality => typeOf('quality');

  /// The item level.
  int? get level => intOf('level');

  /// The required character level.
  int? get requiredLevel => intOf('required_level');

  /// The item class.
  KeyedRef? get itemClass => refOf('item_class');

  /// The item subclass.
  KeyedRef? get itemSubclass => refOf('item_subclass');

  /// The inventory type, for example `TWOHWEAPON`.
  String? get inventoryType => typeOf('inventory_type');

  /// The vendor purchase price in copper.
  int? get purchasePrice => intOf('purchase_price');

  /// The vendor sell price in copper.
  int? get sellPrice => intOf('sell_price');

  /// The maximum number of this item a character can own (0 = unlimited).
  int? get maxCount => intOf('max_count');

  /// Whether the item can be equipped.
  bool? get isEquippable => boolOf('is_equippable');

  /// Whether the item stacks.
  bool? get isStackable => boolOf('is_stackable');

  /// The ID to use with `getItemMedia`.
  int? get mediaId => idOf('media');
}
