import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/quest_models.dart';

/// Client for the Quest API (`battleNet.wow.quest`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class QuestClient extends ApiClient {
  /// Creates a [QuestClient].
  QuestClient({required super.connectionTimeout, super.client});

  /// Returns an index of quest categories, areas, and types.
  Future<QuestsIndexResponse> getQuestsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/index',
    parse: QuestsIndexResponse.new,
  );

  /// Returns a quest by [questId].
  Future<QuestResponse> getQuest({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int questId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/$questId',
    parse: QuestResponse.new,
  );

  /// Returns an index of quest categories.
  Future<QuestCategoriesIndexResponse> getQuestCategoriesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/category/index',
    parse: QuestCategoriesIndexResponse.new,
  );

  /// Returns a quest category by [questCategoryId].
  Future<QuestCategoryResponse> getQuestCategory({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int questCategoryId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/category/$questCategoryId',
    parse: QuestCategoryResponse.new,
  );

  /// Returns an index of quest areas.
  Future<QuestAreasIndexResponse> getQuestAreasIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/area/index',
    parse: QuestAreasIndexResponse.new,
  );

  /// Returns a quest area by [questAreaId].
  Future<QuestAreaResponse> getQuestArea({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int questAreaId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/area/$questAreaId',
    parse: QuestAreaResponse.new,
  );

  /// Returns an index of quest types.
  Future<QuestTypesIndexResponse> getQuestTypesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/type/index',
    parse: QuestTypesIndexResponse.new,
  );

  /// Returns a quest type by [questTypeId].
  Future<QuestTypeResponse> getQuestType({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int questTypeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/quest/type/$questTypeId',
    parse: QuestTypeResponse.new,
  );
}
