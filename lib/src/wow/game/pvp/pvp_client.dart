import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/pvp_models.dart';

/// Client for the PvP Season API (`battleNet.wow.pvpSeason`).
///
/// [namespace] defaults to [BattleNetNamespace.dynamic] (Retail).
class PvpSeasonClient extends ApiClient {
  /// Creates a [PvpSeasonClient].
  PvpSeasonClient({required super.connectionTimeout, super.client});

  /// Returns an index of PvP seasons.
  Future<PvpSeasonsIndexResponse> getPvpSeasonsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-season/index',
    parse: PvpSeasonsIndexResponse.new,
  );

  /// Returns a PvP season by [pvpSeasonId].
  Future<PvpSeasonResponse> getPvpSeason({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpSeasonId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-season/$pvpSeasonId',
    parse: PvpSeasonResponse.new,
  );

  /// Returns an index of PvP leaderboards for a [pvpSeasonId].
  Future<PvpLeaderboardsIndexResponse> getPvpLeaderboardsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpSeasonId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-season/$pvpSeasonId/pvp-leaderboard/index',
    parse: PvpLeaderboardsIndexResponse.new,
  );

  /// Returns a PvP leaderboard for a [pvpSeasonId] and [pvpBracket]
  /// (for example `2v2`, `3v3`, `rbg`).
  Future<PvpLeaderboardResponse> getPvpLeaderboard({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpSeasonId,
    required String pvpBracket,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-season/$pvpSeasonId/pvp-leaderboard/$pvpBracket',
    parse: PvpLeaderboardResponse.new,
  );

  /// Returns an index of PvP rewards for a [pvpSeasonId].
  Future<PvpRewardsIndexResponse> getPvpRewardsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpSeasonId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-season/$pvpSeasonId/pvp-reward/index',
    parse: PvpRewardsIndexResponse.new,
  );
}

/// Client for the PvP Tier API (`battleNet.wow.pvpTier`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class PvpTierClient extends ApiClient {
  /// Creates a [PvpTierClient].
  PvpTierClient({required super.connectionTimeout, super.client});

  /// Returns an index of PvP tiers.
  Future<PvpTiersIndexResponse> getPvpTiersIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-tier/index',
    parse: PvpTiersIndexResponse.new,
  );

  /// Returns a PvP tier by [pvpTierId].
  Future<PvpTierResponse> getPvpTier({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpTierId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-tier/$pvpTierId',
    parse: PvpTierResponse.new,
  );

  /// Returns media for a PvP tier by [pvpTierId].
  Future<MediaResponse> getPvpTierMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpTierId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/pvp-tier/$pvpTierId',
    parse: MediaResponse.new,
  );
}
