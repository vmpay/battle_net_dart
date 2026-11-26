import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/realm_models.dart';

/// Client for the Realm API (`battleNet.wow.realm`).
///
/// [namespace] defaults to [BattleNetNamespace.dynamic] (Retail); pass a
/// Classic namespace to query Classic realms.
class RealmClient extends ApiClient {
  /// Creates a [RealmClient].
  RealmClient({required super.connectionTimeout, super.client});

  /// Returns an index of realms.
  Future<RealmsIndexResponse> getRealmsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/realm/index',
    parse: RealmsIndexResponse.new,
  );

  /// Returns a single realm by [realmSlug], for example `ravencrest`.
  Future<RealmResponse> getRealm({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/realm/$realmSlug',
    parse: RealmResponse.new,
  );

  /// Performs a search of realms.
  ///
  /// [filters] are passed as-is, for example `{'timezone': 'Europe/Paris'}`.
  Future<SearchResponse> searchRealms({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    Map<String, String>? filters,
    String orderBy = 'id',
    int page = 1,
    int? pageSize,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/search/realm',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}

/// Client for the Region API (`battleNet.wow.region`).
class RegionClient extends ApiClient {
  /// Creates a [RegionClient].
  RegionClient({required super.connectionTimeout, super.client});

  /// Returns an index of regions.
  Future<RegionsIndexResponse> getRegionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/region/index',
    parse: RegionsIndexResponse.new,
  );

  /// Returns a region by [regionId] (1 = US, 2 = KR, 3 = EU, 4 = TW).
  Future<RegionResponse> getRegion({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int regionId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/region/$regionId',
    parse: RegionResponse.new,
  );
}
