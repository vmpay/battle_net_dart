import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/talent_models.dart';

/// Client for the Talent API (`battleNet.wow.talent`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class TalentClient extends ApiClient {
  /// Creates a [TalentClient].
  TalentClient({required super.connectionTimeout, super.client});

  /// Returns an index of talent trees.
  Future<TalentTreesIndexResponse> getTalentTreesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/talent-tree/index',
    parse: TalentTreesIndexResponse.new,
  );

  /// Returns a talent tree by [talentTreeId] and [specId].
  Future<TalentTreeResponse> getTalentTree({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int talentTreeId,
    required int specId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/talent-tree/$talentTreeId/playable-specialization/$specId',
    parse: TalentTreeResponse.new,
  );

  /// Returns all nodes for a talent tree by [talentTreeId].
  Future<TalentTreeNodesResponse> getTalentTreeNodes({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int talentTreeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/talent-tree/$talentTreeId',
    parse: TalentTreeNodesResponse.new,
  );

  /// Returns an index of talents.
  Future<TalentsIndexResponse> getTalentsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/talent/index',
    parse: TalentsIndexResponse.new,
  );

  /// Returns a talent by [talentId].
  Future<TalentResponse> getTalent({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int talentId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/talent/$talentId',
    parse: TalentResponse.new,
  );

  /// Returns an index of PvP talents.
  Future<PvpTalentsIndexResponse> getPvpTalentsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-talent/index',
    parse: PvpTalentsIndexResponse.new,
  );

  /// Returns a PvP talent by [pvpTalentId].
  Future<PvpTalentResponse> getPvpTalent({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int pvpTalentId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pvp-talent/$pvpTalentId',
    parse: PvpTalentResponse.new,
  );
}
