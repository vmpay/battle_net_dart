// keystone/mythic_keystone_dungeon_client.dart
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:http/http.dart' as http;

import 'models/mythic_keystone_models.dart';
import 'models/mythic_keystone_period_response.dart';
import 'models/mythic_keystone_periods_index_response.dart';

/// A client for interacting with the World of Warcraft Mythic Keystone Dungeon API.
///
/// This class provides methods to retrieve information about Mythic Keystone dungeons,
/// including periods and specific period details.
class MythicKeystoneDungeonClient {
  final int _connectionTimeout;
  final String _gameDataApiBasePath = '/data/wow';
  final http.Client _httpClient;

  /// Creates an instance of [MythicKeystoneDungeonClient].
  ///
  /// [connectionTimeout] is the timeout duration for HTTP requests in milliseconds.
  /// [client] an optional HTTP client for making requests. Defaults to a new [http.Client].
  MythicKeystoneDungeonClient({
    required int connectionTimeout,
    http.Client? client,
  }) : _connectionTimeout = connectionTimeout,
       _httpClient = client ?? http.Client();

  /// Returns an index of Mythic Keystone periods.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [locale] The Battle.net locale for the request.
  ///
  /// Returns a [Future] that completes with a [MythicKeystonePeriodsIndexResponse] object.
  Future<MythicKeystonePeriodsIndexResponse> getMythicKeystonePeriodsIndex({
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
      path: '$_gameDataApiBasePath/mythic-keystone/period/index',
      parser: MythicKeystonePeriodsIndexResponse.fromRawJson,
    );
  }

  /// Returns a Mythic Keystone period by ID.
  ///
  /// [accessToken] The access token for the request.
  /// [region] The Battle.net region for the request.
  /// [namespace] The Battle.net namespace for the request.
  /// [locale] The Battle.net locale for the request.
  /// [periodId] The ID of the Mythic Keystone period.
  ///
  /// Returns a [Future] that completes with a [MythicKeystonePeriodResponse] object.
  Future<MythicKeystonePeriodResponse> getMythicKeystonePeriod({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required int periodId,
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
      path: '$_gameDataApiBasePath/mythic-keystone/period/$periodId',
      parser: MythicKeystonePeriodResponse.fromRawJson,
    );
  }

  /// Returns an index of Mythic Keystone links (seasons and dungeons).
  Future<MythicKeystoneIndexResponse> getMythicKeystoneIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => doGet<MythicKeystoneIndexResponse>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataApiBasePath/mythic-keystone/index',
    parser: (String body) => MythicKeystoneIndexResponse(ApiModel.decode(body)),
  );

  /// Returns an index of Mythic Keystone dungeons.
  Future<MythicKeystoneDungeonsIndexResponse> getMythicKeystoneDungeonsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => doGet<MythicKeystoneDungeonsIndexResponse>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataApiBasePath/mythic-keystone/dungeon/index',
    parser: (String body) =>
        MythicKeystoneDungeonsIndexResponse(ApiModel.decode(body)),
  );

  /// Returns a Mythic Keystone dungeon by [dungeonId].
  Future<MythicKeystoneDungeonResponse> getMythicKeystoneDungeon({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int dungeonId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => doGet<MythicKeystoneDungeonResponse>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataApiBasePath/mythic-keystone/dungeon/$dungeonId',
    parser: (String body) =>
        MythicKeystoneDungeonResponse(ApiModel.decode(body)),
  );

  /// Returns an index of Mythic Keystone seasons.
  Future<MythicKeystoneSeasonsIndexResponse> getMythicKeystoneSeasonsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => doGet<MythicKeystoneSeasonsIndexResponse>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataApiBasePath/mythic-keystone/season/index',
    parser: (String body) =>
        MythicKeystoneSeasonsIndexResponse(ApiModel.decode(body)),
  );

  /// Returns a Mythic Keystone season by [seasonId].
  Future<MythicKeystoneSeasonResponse> getMythicKeystoneSeason({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int seasonId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => doGet<MythicKeystoneSeasonResponse>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataApiBasePath/mythic-keystone/season/$seasonId',
    parser: (String body) =>
        MythicKeystoneSeasonResponse(ApiModel.decode(body)),
  );
}
