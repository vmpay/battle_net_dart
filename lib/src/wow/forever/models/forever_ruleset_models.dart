import 'dart:convert';

import 'package:meta/meta.dart';

// ---------------------------------------------------------------------------
// ForeverRulesetIndexResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverRulesetIndex` (`GET /data/wow/ruleset/index`).
@immutable
class ForeverRulesetIndexResponse {
  final List<ForeverRulesetRef> rulesets;

  const ForeverRulesetIndexResponse({required this.rulesets});

  factory ForeverRulesetIndexResponse.fromRawJson(String str) =>
      ForeverRulesetIndexResponse.fromJson(json.decode(str));

  factory ForeverRulesetIndexResponse.fromJson(Map<String, dynamic> j) =>
      ForeverRulesetIndexResponse(
        rulesets: (j['rulesets'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverRulesetRef.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverRulesetIndexResponse{rulesets: ${rulesets.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverRulesetIndexResponse &&
          runtimeType == other.runtimeType &&
          rulesets.length == other.rulesets.length;

  @override
  int get hashCode => rulesets.length.hashCode;
}

/// A lightweight ruleset reference (index entry).
@immutable
class ForeverRulesetRef {
  final int id;
  final String? name;

  const ForeverRulesetRef({required this.id, this.name});

  factory ForeverRulesetRef.fromJson(Map<String, dynamic> j) =>
      ForeverRulesetRef(
        id: (j['id'] as num?)?.toInt() ?? 0,
        name: j['name'] as String?,
      );

  @override
  String toString() => 'ForeverRulesetRef{id: $id, name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverRulesetRef &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverRulesetResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverRuleset` (`GET /data/wow/ruleset/{rulesetId}`).
@immutable
class ForeverRulesetResponse {
  final int id;
  final String? name;
  final String? slug;
  final int? population;

  const ForeverRulesetResponse({
    required this.id,
    this.name,
    this.slug,
    this.population,
  });

  factory ForeverRulesetResponse.fromRawJson(String str) =>
      ForeverRulesetResponse.fromJson(json.decode(str));

  factory ForeverRulesetResponse.fromJson(Map<String, dynamic> j) =>
      ForeverRulesetResponse(
        id: (j['id'] as num?)?.toInt() ?? 0,
        name: j['name'] as String?,
        slug: j['slug'] as String?,
        population: (j['population']?['value'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverRulesetResponse{id: $id, name: $name, slug: $slug}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverRulesetResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverAuctionPageResponse  (Option B — client-side paginated wrapper)
// ---------------------------------------------------------------------------

/// Response for `getForeverRulesetAuctions`.
///
/// Because the Blizzard API returns all auctions in a single dump, pagination
/// is performed client-side. This wrapper holds the requested page slice
/// alongside total-count metadata so callers can determine when they have
/// retrieved all data.
@immutable
class ForeverAuctionPageResponse {
  /// The auctions on the requested page.
  final List<ForeverAuctionItem> auctions;

  /// Total number of auctions across all pages.
  final int totalAuctions;

  /// The requested page number (1-based).
  final int page;

  /// The requested page size.
  final int pageSize;

  /// Total number of pages available given [totalAuctions] and [pageSize].
  int get totalPages => (totalAuctions / pageSize).ceil();

  /// Whether there are more pages after this one.
  bool get hasNextPage => page < totalPages;

  const ForeverAuctionPageResponse({
    required this.auctions,
    required this.totalAuctions,
    required this.page,
    required this.pageSize,
  });

  /// Parses the full raw JSON dump from the API and returns the requested
  /// page slice.
  factory ForeverAuctionPageResponse.fromRawJson(
    String str, {
    int page = 1,
    int pageSize = 100,
  }) {
    final Map<String, dynamic> j = json.decode(str) as Map<String, dynamic>;
    final List<ForeverAuctionItem> allAuctions =
        (j['auctions'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverAuctionItem.fromJson(e as Map<String, dynamic>),
            )
            .toList();
    final int total = allAuctions.length;
    final int start = ((page - 1) * pageSize).clamp(0, total);
    final int end = (start + pageSize).clamp(0, total);
    return ForeverAuctionPageResponse(
      auctions: allAuctions.sublist(start, end),
      totalAuctions: total,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  String toString() =>
      'ForeverAuctionPageResponse{page: $page/$totalPages, auctions: ${auctions.length}/$totalAuctions}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverAuctionPageResponse &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          totalAuctions == other.totalAuctions;

  @override
  int get hashCode => Object.hash(page, totalAuctions);
}

/// A single auction entry in the ruleset auction house.
@immutable
class ForeverAuctionItem {
  final int id;
  final int itemId;
  final int? quantity;
  final int? unitPrice;
  final int? buyout;
  final int? bid;
  final String? timeLeft;

  const ForeverAuctionItem({
    required this.id,
    required this.itemId,
    this.quantity,
    this.unitPrice,
    this.buyout,
    this.bid,
    this.timeLeft,
  });

  factory ForeverAuctionItem.fromJson(Map<String, dynamic> j) =>
      ForeverAuctionItem(
        id: (j['id'] as num?)?.toInt() ?? 0,
        itemId: (j['item']?['id'] as num?)?.toInt() ?? 0,
        quantity: (j['quantity'] as num?)?.toInt(),
        unitPrice: (j['unit_price'] as num?)?.toInt(),
        buyout: (j['buyout'] as num?)?.toInt(),
        bid: (j['bid'] as num?)?.toInt(),
        timeLeft: j['time_left'] as String?,
      );

  @override
  String toString() =>
      'ForeverAuctionItem{id: $id, itemId: $itemId, quantity: $quantity}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverAuctionItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
