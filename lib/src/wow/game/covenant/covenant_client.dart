import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/covenant_models.dart';

/// Client for the Covenant API (`battleNet.wow.covenant`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class CovenantClient extends ApiClient {
  /// Creates a [CovenantClient].
  CovenantClient({required super.connectionTimeout, super.client});

  /// Returns an index of covenants.
  Future<CovenantsIndexResponse> getCovenantsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/index',
    parse: CovenantsIndexResponse.new,
  );

  /// Returns a covenant by [covenantId].
  Future<CovenantResponse> getCovenant({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int covenantId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/$covenantId',
    parse: CovenantResponse.new,
  );

  /// Returns media for a covenant by [covenantId].
  Future<MediaResponse> getCovenantMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int covenantId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/covenant/$covenantId',
    parse: MediaResponse.new,
  );

  /// Returns an index of soulbinds.
  Future<SoulbindsIndexResponse> getSoulbindsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/soulbind/index',
    parse: SoulbindsIndexResponse.new,
  );

  /// Returns a soulbind by [soulbindId].
  Future<SoulbindResponse> getSoulbind({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int soulbindId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/soulbind/$soulbindId',
    parse: SoulbindResponse.new,
  );

  /// Returns an index of conduits.
  Future<ConduitsIndexResponse> getConduitsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/conduit/index',
    parse: ConduitsIndexResponse.new,
  );

  /// Returns a conduit by [conduitId].
  Future<ConduitResponse> getConduit({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int conduitId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/covenant/conduit/$conduitId',
    parse: ConduitResponse.new,
  );
}
