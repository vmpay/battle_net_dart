import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/heirloom_models.dart';

/// Client for the Heirloom API (`battleNet.wow.heirloom`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class HeirloomClient extends ApiClient {
  /// Creates a [HeirloomClient].
  HeirloomClient({required super.connectionTimeout, super.client});

  /// Returns an index of heirlooms.
  Future<HeirloomsIndexResponse> getHeirloomsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/heirloom/index',
    parse: HeirloomsIndexResponse.new,
  );

  /// Returns an heirloom by [heirloomId].
  Future<HeirloomResponse> getHeirloom({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int heirloomId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/heirloom/$heirloomId',
    parse: HeirloomResponse.new,
  );
}
