import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/auction_models.dart';

/// Client for the Auction House API (`battleNet.wow.auctionHouse`).
///
/// Responses are large (commodities are tens of MB), so consider a generous
/// `connectionTimeout`.
class AuctionHouseClient extends ApiClient {
  /// Creates an [AuctionHouseClient].
  AuctionHouseClient({required super.connectionTimeout, super.client});

  /// Returns all active auctions for a connected realm.
  ///
  /// Commodities (stackable trade goods) are not included; use
  /// [getCommodities].
  Future<AuctionsResponse> getAuctions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int connectedRealmId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/connected-realm/$connectedRealmId/auctions',
    parse: AuctionsResponse.new,
  );

  /// Returns all active region-wide commodity auctions.
  Future<AuctionsResponse> getCommodities({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/auctions/commodities',
    parse: AuctionsResponse.new,
  );
}
