import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/connected-realm/{id}/auctions/index`
/// (WoW Classic).
class AuctionHousesIndexResponse extends ApiModel {
  /// Creates an [AuctionHousesIndexResponse] from its JSON object.
  AuctionHousesIndexResponse(super.raw);

  /// The auction houses for the connected realm (e.g. Alliance, Horde,
  /// Blackwater).
  List<KeyedRef> get auctions => refsOf('auctions');
}

/// Response of `GET /data/wow/connected-realm/{id}/auctions` and
/// `GET /data/wow/auctions/commodities`.
///
/// Auction payloads can be very large, so [auctions] is parsed lazily on first
/// access and cached.
class AuctionsResponse extends ApiModel {
  /// Creates an [AuctionsResponse] from its JSON object.
  AuctionsResponse(super.raw);

  /// The URL of the connected realm (`null` for commodities, which are
  /// region-wide).
  String? get connectedRealmHref => hrefOf('connected_realm');

  /// All active auctions.
  late final List<Auction> auctions = listOf<Auction>('auctions', Auction.new);
}

/// A single auction.
class Auction extends ApiModel {
  /// Creates an [Auction] from its JSON object.
  Auction(super.raw);

  /// The auction ID.
  int? get id => intOf('id');

  /// The ID of the auctioned item.
  int? get itemId => idOf('item');

  /// The number of items.
  int? get quantity => intOf('quantity');

  /// The price per item in copper (commodities and stackable items).
  int? get unitPrice => intOf('unit_price');

  /// The buyout price in copper.
  int? get buyout => intOf('buyout');

  /// The current bid in copper.
  int? get bid => intOf('bid');

  /// The remaining time bucket, for example `SHORT` or `VERY_LONG`.
  String? get timeLeft => stringOf('time_left');
}
