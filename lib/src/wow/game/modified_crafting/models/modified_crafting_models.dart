import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/modified-crafting/index`.
class ModifiedCraftingIndexResponse extends ApiModel {
  /// Creates a [ModifiedCraftingIndexResponse] from its JSON object.
  ModifiedCraftingIndexResponse(super.raw);

  /// URL of the modified crafting categories index.
  String? get categoriesHref => hrefOf('categories');

  /// URL of the reagent slot types index.
  String? get slotTypesHref => hrefOf('slot_types');
}

/// Response of `GET /data/wow/modified-crafting/category/index`.
class ModifiedCraftingCategoriesIndexResponse extends ApiModel {
  /// Creates a [ModifiedCraftingCategoriesIndexResponse] from its JSON object.
  ModifiedCraftingCategoriesIndexResponse(super.raw);

  /// All modified crafting categories.
  List<KeyedRef> get categories => refsOf('categories');
}

/// Response of `GET /data/wow/modified-crafting/category/{categoryId}`.
class ModifiedCraftingCategoryResponse extends ApiModel {
  /// Creates a [ModifiedCraftingCategoryResponse] from its JSON object.
  ModifiedCraftingCategoryResponse(super.raw);

  /// The category ID.
  int? get id => intOf('id');

  /// The localized category name.
  String? get name => stringOf('name');
}

/// Response of `GET /data/wow/modified-crafting/reagent-slot-type/index`.
class ModifiedCraftingReagentSlotTypesIndexResponse extends ApiModel {
  /// Creates a [ModifiedCraftingReagentSlotTypesIndexResponse] from its JSON object.
  ModifiedCraftingReagentSlotTypesIndexResponse(super.raw);

  /// All reagent slot types.
  List<KeyedRef> get slotTypes => refsOf('slot_types');
}

/// Response of
/// `GET /data/wow/modified-crafting/reagent-slot-type/{slotTypeId}`.
class ModifiedCraftingReagentSlotTypeResponse extends ApiModel {
  /// Creates a [ModifiedCraftingReagentSlotTypeResponse] from its JSON object.
  ModifiedCraftingReagentSlotTypeResponse(super.raw);

  /// The reagent slot type ID.
  int? get id => intOf('id');

  /// The localized description.
  String? get description => stringOf('description');

  /// Compatible modified crafting categories.
  List<KeyedRef> get compatibleCategories => refsOf('compatible_categories');
}
