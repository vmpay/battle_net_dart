import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/achievement-category/index`.
class AchievementCategoriesIndexResponse extends ApiModel {
  /// Creates an [AchievementCategoriesIndexResponse] from its JSON object.
  AchievementCategoriesIndexResponse(super.raw);

  /// All achievement categories.
  List<KeyedRef> get categories => refsOf('categories');

  /// Top-level achievement categories.
  List<KeyedRef> get rootCategories => refsOf('root_categories');

  /// Guild achievement categories.
  List<KeyedRef> get guildCategories => refsOf('guild_categories');
}

/// Response of `GET /data/wow/achievement-category/{achievementCategoryId}`.
class AchievementCategoryResponse extends ApiModel {
  /// Creates an [AchievementCategoryResponse] from its JSON object.
  AchievementCategoryResponse(super.raw);

  /// The category ID.
  int? get id => intOf('id');

  /// The localized category name.
  String? get name => stringOf('name');

  /// Whether this is a guild achievement category.
  bool? get isGuildCategory => boolOf('is_guild_category');

  /// Display order in the UI.
  int? get displayOrder => intOf('display_order');

  /// Achievements in this category.
  List<KeyedRef> get achievements => refsOf('achievements');

  /// Subcategories of this category.
  List<KeyedRef> get subcategories => refsOf('subcategories');
}

/// Response of `GET /data/wow/achievement/index`.
class AchievementsIndexResponse extends ApiModel {
  /// Creates an [AchievementsIndexResponse] from its JSON object.
  AchievementsIndexResponse(super.raw);

  /// All achievements.
  List<KeyedRef> get achievements => refsOf('achievements');
}

/// Response of `GET /data/wow/achievement/{achievementId}`.
class AchievementResponse extends ApiModel {
  /// Creates an [AchievementResponse] from its JSON object.
  AchievementResponse(super.raw);

  /// The achievement ID.
  int? get id => intOf('id');

  /// The localized achievement name.
  String? get name => stringOf('name');

  /// The localized achievement description.
  String? get description => stringOf('description');

  /// The achievement points awarded.
  int? get points => intOf('points');

  /// Whether the achievement is account-wide.
  bool? get isAccountWide => boolOf('is_account_wide');

  /// The category this achievement belongs to.
  KeyedRef? get category => refOf('category');

  /// The next achievement in a chain, if any.
  KeyedRef? get nextAchievement => refOf('next_achievement');

  /// The ID to use with `getAchievementMedia`.
  int? get mediaId => idOf('media');
}
