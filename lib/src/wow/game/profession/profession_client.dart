import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/profession_models.dart';

/// Client for the Profession API (`battleNet.wow.profession`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class ProfessionClient extends ApiClient {
  /// Creates a [ProfessionClient].
  ProfessionClient({required super.connectionTimeout, super.client});

  /// Returns an index of professions.
  Future<ProfessionsIndexResponse> getProfessionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/profession/index',
    parse: ProfessionsIndexResponse.new,
  );

  /// Returns a profession by [professionId].
  Future<ProfessionResponse> getProfession({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int professionId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/profession/$professionId',
    parse: ProfessionResponse.new,
  );

  /// Returns media (icon) for a profession by [professionId].
  Future<MediaResponse> getProfessionMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int professionId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/profession/$professionId',
    parse: MediaResponse.new,
  );

  /// Returns a profession skill tier by [professionId] and [skillTierId].
  Future<SkillTierResponse> getProfessionSkillTier({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int professionId,
    required int skillTierId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/profession/$professionId/skill-tier/$skillTierId',
    parse: SkillTierResponse.new,
  );

  /// Returns a recipe by [recipeId].
  Future<RecipeResponse> getRecipe({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int recipeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/recipe/$recipeId',
    parse: RecipeResponse.new,
  );

  /// Returns media (icon) for a recipe by [recipeId].
  Future<MediaResponse> getRecipeMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int recipeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/recipe/$recipeId',
    parse: MediaResponse.new,
  );
}
