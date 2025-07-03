import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:http/http.dart' as http;

import 'models/mythic_keystone_affix_media_response.dart';
import 'models/mythic_keystone_affix_response.dart';
import 'models/mythic_keystone_affixes_index_response.dart';

/// A client for interacting with the World of Warcraft Mythic Keystone Affix API.
///
/// This class provides methods to retrieve information about Mythic Keystone affixes,
/// including their index, details by ID, and associated media.
class MythicKeystoneAffixClient {
  final int _connectionTimeout;
  final String _gameDataApiBasePath = '/data/wow';
  final http.Client _httpClient;

  /// Creates an instance of [MythicKeystoneAffixClient].
  ///
  /// [connectionTimeout] is the timeout duration for HTTP requests in milliseconds.
  /// [client] an optional HTTP client for making requests. Defaults to a new [http.Client].
  MythicKeystoneAffixClient({
    required int connectionTimeout,
    http.Client? client,
  }) : _connectionTimeout = connectionTimeout,
       _httpClient = client ?? http.Client();

  /// Returns an index of Mythic Keystone affixes.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [locale] The Battle.net locale for the request.
  ///
  /// Returns a [Future] that completes with a [MythicKeystoneAffixesIndexResponse] object.
  Future<MythicKeystoneAffixesIndexResponse> getMythicKeystoneAffixesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
  }) async {
    final Map<String, String?> queryParams = <String, String?>{};
    queryParams['locale'] = locale.name;
    return doGet(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      path: '$_gameDataApiBasePath/keystone-affix/index',
      parser: MythicKeystoneAffixesIndexResponse.fromRawJson,
    );
  }

  /// Returns a Mythic Keystone affix by ID.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [locale] The Battle.net locale for the request.
  /// [keystoneAffixId] The ID of the Mythic Keystone affix.
  ///
  /// Returns a [Future] that completes with a [MythicKeystoneAffixResponse] object.
  Future<MythicKeystoneAffixResponse> getMythicKeystoneAffix({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required int keystoneAffixId,
  }) async {
    final Map<String, String?> queryParams = <String, String?>{};
    queryParams['locale'] = locale.name;
    return doGet(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      path: '$_gameDataApiBasePath/keystone-affix/$keystoneAffixId',
      parser: MythicKeystoneAffixResponse.fromRawJson,
    );
  }

  /// Returns media for a Mythic Keystone affix by ID.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request (e.g., [BattleNetNamespace.static]).
  /// [locale] The Battle.net locale for the request.
  /// [keystoneAffixId] The ID of the Mythic Keystone affix.
  ///
  /// Returns a [Future] that completes with a [MythicKeystoneAffixMediaResponse] object.
  Future<MythicKeystoneAffixMediaResponse> getMythicKeystoneAffixMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required int keystoneAffixId,
  }) async {
    final Map<String, String?> queryParams = <String, String?>{};
    queryParams['locale'] = locale.name;
    return doGet(
      client: _httpClient,
      connectionTimeout: _connectionTimeout,
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      path: '$_gameDataApiBasePath/media/keystone-affix/$keystoneAffixId',
      parser: MythicKeystoneAffixMediaResponse.fromRawJson,
    );
  }
}
