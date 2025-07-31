import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';

// Import your http_utils
import 'package:battle_net/src/utils/http_utils.dart'; // Assuming this is the correct path
import 'package:http/http.dart' as http;

import 'models/token_index_response.dart';

/// A client for interacting with the World of Warcraft Token API.
///
/// This class provides methods to retrieve information about the WoW Token.
class TokenClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  /// Creates an instance of [TokenClient].
  ///
  /// [connectionTimeout] is the timeout duration for HTTP requests in milliseconds.
  /// [client] an optional HTTP client for making requests. Defaults to a new [http.Client].
  TokenClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns the WoW Token index.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [locale] The Battle.net locale for the request.
  ///
  /// Returns a [Future] that completes with a [TokenIndexResponse] object.
  Future<TokenIndexResponse> getTokenIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
  }) async {
    final Map<String, String?> queryParams = <String, String?>{};
    queryParams['locale'] = locale.name;
    return doGet<TokenIndexResponse>(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      path: '/data/wow/token/',
      parser: (String json) => TokenIndexResponse.fromRawJson(json),
    );
  }
}
