import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/modified_crafting_models.dart';

/// Client for the Modified Crafting API (`battleNet.wow.modifiedCrafting`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class ModifiedCraftingClient extends ApiClient {
  /// Creates a [ModifiedCraftingClient].
  ModifiedCraftingClient({required super.connectionTimeout, super.client});

  /// Returns an index of modified crafting categories and slot types.
  Future<ModifiedCraftingIndexResponse> getModifiedCraftingIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/modified-crafting/index',
    parse: ModifiedCraftingIndexResponse.new,
  );

  /// Returns an index of modified crafting categories.
  Future<ModifiedCraftingCategoriesIndexResponse>
  getModifiedCraftingCategoriesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/modified-crafting/category/index',
    parse: ModifiedCraftingCategoriesIndexResponse.new,
  );

  /// Returns a modified crafting category by [categoryId].
  Future<ModifiedCraftingCategoryResponse> getModifiedCraftingCategory({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int categoryId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/modified-crafting/category/$categoryId',
    parse: ModifiedCraftingCategoryResponse.new,
  );

  /// Returns an index of modified crafting reagent slot types.
  Future<ModifiedCraftingReagentSlotTypesIndexResponse>
  getModifiedCraftingReagentSlotTypesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/modified-crafting/reagent-slot-type/index',
    parse: ModifiedCraftingReagentSlotTypesIndexResponse.new,
  );

  /// Returns a modified crafting reagent slot type by [slotTypeId].
  Future<ModifiedCraftingReagentSlotTypeResponse>
  getModifiedCraftingReagentSlotType({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int slotTypeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/modified-crafting/reagent-slot-type/$slotTypeId',
    parse: ModifiedCraftingReagentSlotTypeResponse.new,
  );
}
