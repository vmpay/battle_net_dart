import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:battle_net/src/wow/forever/models/forever_ruleset_models.dart';
import 'package:http/http.dart' as http;

/// Client for WoW: Forever ruleset and auction house endpoints.
///
/// WoW: Forever replaces connected realms with **rulesets**. Auction house
/// data is scoped to a ruleset rather than a connected realm.
class ForeverRulesetClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  static const String _gameDataBasePath = '/data/wow';

  ForeverRulesetClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns an index of all active WoW: Forever rulesets.
  Future<ForeverRulesetIndexResponse> getForeverRulesetIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
  }) => doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.dynamicForever,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataBasePath/ruleset/index',
    parser: ForeverRulesetIndexResponse.fromRawJson,
  );

  /// Returns details for a specific WoW: Forever ruleset.
  Future<ForeverRulesetResponse> getForeverRuleset({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int rulesetId,
  }) => doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.dynamicForever,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataBasePath/ruleset/$rulesetId',
    parser: ForeverRulesetResponse.fromRawJson,
  );

  /// Returns a paginated view of the auction house for a WoW: Forever ruleset.
  ///
  /// Because the Battle.net API returns all auctions in a single dump,
  /// pagination is performed **client-side**. Use [page] and [pageSize] to
  /// retrieve slices of the full list. Check [ForeverAuctionPageResponse.hasNextPage]
  /// to determine if more pages are available.
  ///
  /// [page] is 1-based. Defaults to `1`.
  /// [pageSize] is the number of entries per page. Defaults to `100`.
  Future<ForeverAuctionPageResponse> getForeverRulesetAuctions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int rulesetId,
    int page = 1,
    int pageSize = 100,
  }) => doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.dynamicForever,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataBasePath/ruleset/$rulesetId/auctions/index',
    parser: (String str) => ForeverAuctionPageResponse.fromRawJson(
      str,
      page: page,
      pageSize: pageSize,
    ),
  );
}
