import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/item_models.dart';

/// Client for the Item API (`battleNet.wow.item`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail); pass a
/// Classic namespace to query Classic items.
class ItemClient extends ApiClient {
  /// Creates an [ItemClient].
  ItemClient({required super.connectionTimeout, super.client});

  /// Returns an index of item classes.
  Future<ItemClassesIndexResponse> getItemClassesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item-class/index',
    parse: ItemClassesIndexResponse.new,
  );

  /// Returns an item class by [itemClassId].
  Future<ItemClassResponse> getItemClass({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemClassId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item-class/$itemClassId',
    parse: ItemClassResponse.new,
  );

  /// Returns an item subclass by [itemClassId] and [itemSubclassId].
  Future<ItemSubclassResponse> getItemSubclass({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemClassId,
    required int itemSubclassId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item-class/$itemClassId/item-subclass/$itemSubclassId',
    parse: ItemSubclassResponse.new,
  );

  /// Returns an index of item sets.
  Future<ItemSetsIndexResponse> getItemSetsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item-set/index',
    parse: ItemSetsIndexResponse.new,
  );

  /// Returns an item set by [itemSetId].
  Future<ItemSetResponse> getItemSet({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemSetId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item-set/$itemSetId',
    parse: ItemSetResponse.new,
  );

  /// Returns an item by [itemId].
  Future<ItemResponse> getItem({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/item/$itemId',
    parse: ItemResponse.new,
  );

  /// Returns media (icon) for an item by [itemId].
  Future<MediaResponse> getItemMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/item/$itemId',
    parse: MediaResponse.new,
  );

  /// Performs a search of items.
  ///
  /// [filters] are passed as-is, for example `{'name.en_US': 'Thunderfury'}`.
  Future<SearchResponse> searchItems({
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
    path: '/data/wow/search/item',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
