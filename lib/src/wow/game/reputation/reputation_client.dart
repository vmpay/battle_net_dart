import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/reputation_models.dart';

/// Client for the Reputation API (`battleNet.wow.reputation`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class ReputationClient extends ApiClient {
  /// Creates a [ReputationClient].
  ReputationClient({required super.connectionTimeout, super.client});

  /// Returns an index of reputation factions.
  Future<ReputationFactionsIndexResponse> getReputationFactionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/reputation-faction/index',
    parse: ReputationFactionsIndexResponse.new,
  );

  /// Returns a reputation faction by [reputationFactionId].
  Future<ReputationFactionResponse> getReputationFaction({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int reputationFactionId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/reputation-faction/$reputationFactionId',
    parse: ReputationFactionResponse.new,
  );

  /// Returns an index of reputation tiers.
  Future<ReputationTiersIndexResponse> getReputationTiersIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/reputation-tiers/index',
    parse: ReputationTiersIndexResponse.new,
  );

  /// Returns a reputation tiers set by [reputationTiersId].
  Future<ReputationTiersResponse> getReputationTiers({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int reputationTiersId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/reputation-tiers/$reputationTiersId',
    parse: ReputationTiersResponse.new,
  );
}
