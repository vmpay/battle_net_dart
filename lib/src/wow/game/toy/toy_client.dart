import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/toy_models.dart';

/// Client for the Toy API (`battleNet.wow.toy`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class ToyClient extends ApiClient {
  /// Creates a [ToyClient].
  ToyClient({required super.connectionTimeout, super.client});

  /// Returns an index of toys.
  Future<ToysIndexResponse> getToysIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/toy/index',
    parse: ToysIndexResponse.new,
  );

  /// Returns a toy by [toyId].
  Future<ToyResponse> getToy({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int toyId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/toy/$toyId',
    parse: ToyResponse.new,
  );
}
