import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/quest/index`.
class QuestsIndexResponse extends ApiModel {
  /// Creates a [QuestsIndexResponse] from its JSON object.
  QuestsIndexResponse(super.raw);

  /// URL of the quest categories index.
  String? get categoriesHref => hrefOf('categories');

  /// URL of the quest areas index.
  String? get areasHref => hrefOf('areas');

  /// URL of the quest types index.
  String? get typesHref => hrefOf('types');
}

/// Response of `GET /data/wow/quest/{questId}`.
class QuestResponse extends ApiModel {
  /// Creates a [QuestResponse] from its JSON object.
  QuestResponse(super.raw);

  /// The quest ID.
  int? get id => intOf('id');

  /// The localized quest title.
  String? get title => stringOf('title');

  /// The localized quest description.
  String? get description => stringOf('description');

  /// The quest area.
  KeyedRef? get area => refOf('area');
}

/// Response of `GET /data/wow/quest/category/index`.
class QuestCategoriesIndexResponse extends ApiModel {
  /// Creates a [QuestCategoriesIndexResponse] from its JSON object.
  QuestCategoriesIndexResponse(super.raw);

  /// All quest categories.
  List<KeyedRef> get categories => refsOf('categories');
}

/// Response of `GET /data/wow/quest/category/{questCategoryId}`.
class QuestCategoryResponse extends ApiModel {
  /// Creates a [QuestCategoryResponse] from its JSON object.
  QuestCategoryResponse(super.raw);

  /// The category ID.
  int? get id => intOf('id');

  /// The localized category name.
  String? get category => stringOf('category');

  /// Quests in this category.
  List<KeyedRef> get quests => refsOf('quests');
}

/// Response of `GET /data/wow/quest/area/index`.
class QuestAreasIndexResponse extends ApiModel {
  /// Creates a [QuestAreasIndexResponse] from its JSON object.
  QuestAreasIndexResponse(super.raw);

  /// All quest areas.
  List<KeyedRef> get areas => refsOf('areas');
}

/// Response of `GET /data/wow/quest/area/{questAreaId}`.
class QuestAreaResponse extends ApiModel {
  /// Creates a [QuestAreaResponse] from its JSON object.
  QuestAreaResponse(super.raw);

  /// The area ID.
  int? get id => intOf('id');

  /// The localized area name.
  String? get area => stringOf('area');

  /// Quests in this area.
  List<KeyedRef> get quests => refsOf('quests');
}

/// Response of `GET /data/wow/quest/type/index`.
class QuestTypesIndexResponse extends ApiModel {
  /// Creates a [QuestTypesIndexResponse] from its JSON object.
  QuestTypesIndexResponse(super.raw);

  /// All quest types.
  List<KeyedRef> get types => refsOf('types');
}

/// Response of `GET /data/wow/quest/type/{questTypeId}`.
class QuestTypeResponse extends ApiModel {
  /// Creates a [QuestTypeResponse] from its JSON object.
  QuestTypeResponse(super.raw);

  /// The type ID.
  int? get id => intOf('id');

  /// The localized type name.
  String? get type => stringOf('type');

  /// Quests of this type.
  List<KeyedRef> get quests => refsOf('quests');
}
