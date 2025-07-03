// In your ConnectedRealmClient.dart
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:http/http.dart' as http;

import '../../../constants/battle_net_namespace.dart';
import '../../../constants/battle_net_region.dart';
import 'models/connected_realm_search_data.dart';
import 'models/connected_realm_search_response.dart';
import 'models/population_type_localised.dart';
import 'models/realm_localised.dart';
import 'models/server_status_localised.dart'; // If you need to pass a locale
// ... other imports

/// A client for interacting with the World of Warcraft Connected Realm API.
///
/// This class provides methods to retrieve information about connected realms,
/// including searching for realms based on various criteria.
class ConnectedRealmClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  /// Creates an instance of [ConnectedRealmClient].
  ///
  /// [connectionTimeout] is the timeout duration for HTTP requests in milliseconds.
  /// [client] an optional HTTP client for making requests. Defaults to a new [http.Client].
  ConnectedRealmClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns a connected realm by ID.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [id] The ID of the connected realm.
  ///
  /// Returns a [Future] that completes with a [ConnectedRealmSearchData] object.
  Future<ConnectedRealmSearchData> getConnectedRealm({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required int id,
  }) async {
    return doGet<ConnectedRealmSearchData>(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      // doGet will add this to queryParams prefixed with its type
      path: '/data/wow/connected-realm/$id',
      queryParameters: null,
      parser: (String json) => ConnectedRealmSearchData.fromRawJson(json),
    );
  }

  /// Queries connected realms by search parameters.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [statusType] Optional. Filters by server status (e.g., [ServerStatus.UP]).
  /// [realmsTimezone] Optional. Filters by realm timezone (e.g., [RealmTimezone.EUROPE_PARIS]).
  /// [orderBy] Optional. Specifies the sorting order (defaults to 'id:asc').
  /// [page] Optional. Specifies the page number for results (defaults to `1`).
  /// [pageSize] Optional. Specifies the number of results per page (defaults to `150`).
  /// [hasQueue] Optional. Filters by whether the realm has a queue.
  /// [populationType] Optional. Filters by population type (e.g., [PopulationType.FULL]).
  /// [realmsIsTournament] Optional. Filters by whether the realm is a tournament realm.
  ///
  /// Returns a [Future] that completes with a [ConnectedRealmSearchResponse] object.
  Future<ConnectedRealmSearchResponse> getConnectedRealmSearch({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    ServerStatus? statusType,
    RealmTimezone? realmsTimezone,
    String orderBy = 'id:asc',
    int page = 1,
    int pageSize = 150,
    bool? hasQueue,
    PopulationType? populationType,
    bool? realmsIsTournament,
  }) async {
    final Map<String, String?> queryParams = <String, String?>{};
    if (statusType != null) {
      queryParams['status.type'] = serverStatusValues.reverse[statusType];
    }
    if (realmsTimezone != null) {
      queryParams['realms.timezone'] =
          realmTimezoneValues.reverse[realmsTimezone];
    }
    if (populationType != null) {
      queryParams['population.type'] =
          populationTypeValues.reverse[populationType];
    }
    queryParams['orderby'] = orderBy;
    queryParams['_page'] = page.toString();
    queryParams['_pageSize'] = pageSize.toString();
    if (hasQueue != null) {
      queryParams['has_queue'] = hasQueue.toString();
    }
    if (realmsIsTournament != null) {
      queryParams['realms.is_tournament'] = realmsIsTournament.toString();
    }

    return doGet<ConnectedRealmSearchResponse>(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      // doGet handles adding this to query params
      path: '/data/wow/search/connected-realm',
      queryParameters: queryParams,
      parser: (String json) => ConnectedRealmSearchResponse.fromRawJson(json),
    );
  }
}
