import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/profession/index`.
class ProfessionsIndexResponse extends ApiModel {
  /// Creates a [ProfessionsIndexResponse] from its JSON object.
  ProfessionsIndexResponse(super.raw);

  /// All professions.
  List<KeyedRef> get professions => refsOf('professions');
}

/// Response of `GET /data/wow/profession/{professionId}`.
class ProfessionResponse extends ApiModel {
  /// Creates a [ProfessionResponse] from its JSON object.
  ProfessionResponse(super.raw);

  /// The profession ID.
  int? get id => intOf('id');

  /// The localized profession name.
  String? get name => stringOf('name');

  /// The localized profession description.
  String? get description => stringOf('description');

  /// The profession type, for example `PRIMARY` or `SECONDARY`.
  String? get type => typeOf('type');

  /// The skill tiers (one per expansion) of the profession.
  List<KeyedRef> get skillTiers => refsOf('skill_tiers');

  /// The ID to use with `getProfessionMedia`.
  int? get mediaId => idOf('media');
}

/// Response of `GET /data/wow/profession/{professionId}/skill-tier/{skillTierId}`.
class SkillTierResponse extends ApiModel {
  /// Creates a [SkillTierResponse] from its JSON object.
  SkillTierResponse(super.raw);

  /// The skill tier ID.
  int? get id => intOf('id');

  /// The localized skill tier name.
  String? get name => stringOf('name');

  /// The minimum skill level of the tier.
  int? get minimumSkillLevel => intOf('minimum_skill_level');

  /// The maximum skill level of the tier.
  int? get maximumSkillLevel => intOf('maximum_skill_level');

  /// The recipe categories of the tier.
  List<SkillTierCategory> get categories =>
      listOf<SkillTierCategory>('categories', SkillTierCategory.new);
}

/// A recipe category within a skill tier.
class SkillTierCategory extends ApiModel {
  /// Creates a [SkillTierCategory] from its JSON object.
  SkillTierCategory(super.raw);

  /// The localized category name.
  String? get name => stringOf('name');

  /// The recipes in the category.
  List<KeyedRef> get recipes => refsOf('recipes');
}

/// Response of `GET /data/wow/recipe/{recipeId}`.
class RecipeResponse extends ApiModel {
  /// Creates a [RecipeResponse] from its JSON object.
  RecipeResponse(super.raw);

  /// The recipe ID.
  int? get id => intOf('id');

  /// The localized recipe name.
  String? get name => stringOf('name');

  /// The localized recipe description.
  String? get description => stringOf('description');

  /// The item crafted by the recipe (when not faction specific).
  KeyedRef? get craftedItem => refOf('crafted_item');

  /// The ID to use with `getRecipeMedia`.
  int? get mediaId => idOf('media');
}
