import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/tech_talent_models.dart';

/// Client for the Tech Talent API (`battleNet.wow.techTalent`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class TechTalentClient extends ApiClient {
  /// Creates a [TechTalentClient].
  TechTalentClient({required super.connectionTimeout, super.client});

  /// Returns an index of tech talent trees.
  Future<TechTalentTreesIndexResponse> getTechTalentTreesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/tech-talent-tree/index',
    parse: TechTalentTreesIndexResponse.new,
  );

  /// Returns a tech talent tree by [techTalentTreeId].
  Future<TechTalentTreeResponse> getTechTalentTree({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int techTalentTreeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/tech-talent-tree/$techTalentTreeId',
    parse: TechTalentTreeResponse.new,
  );

  /// Returns an index of tech talents.
  Future<TechTalentsIndexResponse> getTechTalentsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/tech-talent/index',
    parse: TechTalentsIndexResponse.new,
  );

  /// Returns a tech talent by [techTalentId].
  Future<TechTalentResponse> getTechTalent({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int techTalentId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/tech-talent/$techTalentId',
    parse: TechTalentResponse.new,
  );

  /// Returns media for a tech talent by [techTalentId].
  Future<MediaResponse> getTechTalentMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int techTalentId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/tech-talent/$techTalentId',
    parse: MediaResponse.new,
  );
}
