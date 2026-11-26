import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/mount_models.dart';

/// Client for the Mount API (`battleNet.wow.mount`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class MountClient extends ApiClient {
  /// Creates a [MountClient].
  MountClient({required super.connectionTimeout, super.client});

  /// Returns an index of mounts.
  Future<MountsIndexResponse> getMountsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/mount/index',
    parse: MountsIndexResponse.new,
  );

  /// Returns a mount by [mountId].
  Future<MountResponse> getMount({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int mountId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/mount/$mountId',
    parse: MountResponse.new,
  );

  /// Performs a search of mounts.
  Future<SearchResponse> searchMounts({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    Map<String, String>? filters,
    String orderBy = 'id',
    int page = 1,
    int? pageSize,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/search/mount',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
