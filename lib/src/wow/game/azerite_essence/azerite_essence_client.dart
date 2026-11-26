import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/azerite_essence_models.dart';

/// Client for the Azerite Essence API (`battleNet.wow.azeriteEssence`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class AzeriteEssenceClient extends ApiClient {
  /// Creates an [AzeriteEssenceClient].
  AzeriteEssenceClient({required super.connectionTimeout, super.client});

  /// Returns an index of Azerite essences.
  Future<AzeriteEssencesIndexResponse> getAzeriteEssencesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/azerite-essence/index',
    parse: AzeriteEssencesIndexResponse.new,
  );

  /// Returns an Azerite essence by [azeriteEssenceId].
  Future<AzeriteEssenceResponse> getAzeriteEssence({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int azeriteEssenceId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/azerite-essence/$azeriteEssenceId',
    parse: AzeriteEssenceResponse.new,
  );

  /// Returns media for an Azerite essence by [azeriteEssenceId].
  Future<MediaResponse> getAzeriteEssenceMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int azeriteEssenceId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/azerite-essence/$azeriteEssenceId',
    parse: MediaResponse.new,
  );

  /// Performs a search of Azerite essences.
  Future<SearchResponse> searchAzeriteEssences({
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
    path: '/data/wow/search/azerite-essence',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
