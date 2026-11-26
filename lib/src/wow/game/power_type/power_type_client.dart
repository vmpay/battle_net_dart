import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/power_type_models.dart';

/// Client for the Power Type API (`battleNet.wow.powerType`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class PowerTypeClient extends ApiClient {
  /// Creates a [PowerTypeClient].
  PowerTypeClient({required super.connectionTimeout, super.client});

  /// Returns an index of power types.
  Future<PowerTypesIndexResponse> getPowerTypesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/power-type/index',
    parse: PowerTypesIndexResponse.new,
  );

  /// Returns a power type by [powerTypeId].
  Future<PowerTypeResponse> getPowerType({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int powerTypeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/power-type/$powerTypeId',
    parse: PowerTypeResponse.new,
  );
}
