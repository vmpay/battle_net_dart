import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

/// Client for the Media Search API (`battleNet.wow.media`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class MediaClient extends ApiClient {
  /// Creates a [MediaClient].
  MediaClient({required super.connectionTimeout, super.client});

  /// Performs a search of media documents (e.g. `filters: {'tags': 'item'}`).
  Future<SearchResponse> searchMedia({
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
    path: '/data/wow/search/media',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
