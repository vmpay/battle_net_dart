import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/achievement_models.dart';

/// Client for the Achievement API (`battleNet.wow.achievement`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class AchievementClient extends ApiClient {
  /// Creates an [AchievementClient].
  AchievementClient({required super.connectionTimeout, super.client});

  /// Returns an index of achievement categories.
  Future<AchievementCategoriesIndexResponse> getAchievementCategoriesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/achievement-category/index',
    parse: AchievementCategoriesIndexResponse.new,
  );

  /// Returns an achievement category by [achievementCategoryId].
  Future<AchievementCategoryResponse> getAchievementCategory({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int achievementCategoryId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/achievement-category/$achievementCategoryId',
    parse: AchievementCategoryResponse.new,
  );

  /// Returns an index of achievements.
  Future<AchievementsIndexResponse> getAchievementsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/achievement/index',
    parse: AchievementsIndexResponse.new,
  );

  /// Returns an achievement by [achievementId].
  Future<AchievementResponse> getAchievement({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int achievementId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/achievement/$achievementId',
    parse: AchievementResponse.new,
  );

  /// Returns media (icon) for an achievement by [achievementId].
  Future<MediaResponse> getAchievementMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int achievementId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/achievement/$achievementId',
    parse: MediaResponse.new,
  );
}
