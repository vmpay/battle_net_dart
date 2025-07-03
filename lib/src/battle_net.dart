import 'dart:convert';

import 'package:battle_net/src/oauth/oauth_client.dart';
import 'package:battle_net/src/wow/game/connected_realm/connected_realm_client.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/mythic_keystone_affix_client.dart';
import 'package:battle_net/src/wow/game/token/models/token_index_response.dart';
import 'package:battle_net/src/wow/game/token/token_client.dart';

import 'constants/battle_net_locale.dart';
import 'constants/battle_net_namespace.dart';
import 'constants/battle_net_region.dart';
import 'constants/battle_net_scope.dart';
import 'logger/log_level.dart';
import 'logger/logger.dart';
import 'oauth/models/authorization_code_response.dart';
import 'oauth/models/check_token_response.dart';
import 'oauth/models/client_credentials_response.dart';
import 'oauth/models/user_info_response.dart';
import 'wow/game/connected_realm/models/connected_realm_search_data.dart';
import 'wow/game/connected_realm/models/connected_realm_search_response.dart';
import 'wow/game/connected_realm/models/population_type_localised.dart';
import 'wow/game/connected_realm/models/realm_localised.dart';
import 'wow/game/connected_realm/models/server_status_localised.dart';
import 'wow/game/mythic_keystone_affix/models/mythic_keystone_affix_media_response.dart';
import 'wow/game/mythic_keystone_affix/models/mythic_keystone_affix_response.dart';
import 'wow/game/mythic_keystone_affix/models/mythic_keystone_affixes_index_response.dart';
import 'wow/game/mythic_keystone_dungeon/models/mythic_keystone_period_response.dart';
import 'wow/game/mythic_keystone_dungeon/models/mythic_keystone_periods_index_response.dart';
import 'wow/game/mythic_keystone_dungeon/mythic_keystone_dungeon_client.dart';

/// A Dart wrapper client for the Battle.net API.
///
/// This class provides methods to interact with various Battle.net API
/// endpoints, including OAuth, WoW Game Data (Token, Connected Realm,
/// Mythic Keystone Dungeons, and Mythic Keystone Affixes).
class BattleNet {
  final String _auth;
  final String _clientId;

  /// The connection timeout in milliseconds for API requests.
  final int connectionTimeout;

  late final OauthClient _oauthClient;
  late final TokenClient _tokenClient;
  late final ConnectedRealmClient _connectedRealmClient;
  late final MythicKeystoneDungeonClient _mythicKeystoneDungeonClient;
  late final MythicKeystoneAffixClient _mythicKeystoneAffixClient;

  /// Creates an instance of [BattleNet].
  ///
  /// [clientId] and [clientSecret] are required for authentication.
  /// [logLevel] specifies the level of logging for API requests (defaults to [LogLevel.BASIC]).
  /// [enableReleaseLogging] determines if logging is enabled in release mode (defaults to `false`).
  /// [connectionTimeout] sets the timeout for API requests in milliseconds (defaults to `10000`).
  BattleNet({
    required String clientId,
    required String clientSecret,
    LogLevel logLevel = LogLevel.BASIC,
    bool enableReleaseLogging = false,
    this.connectionTimeout = 10000,
  }) : _clientId = clientId,
       _auth = base64.encode(utf8.encode('$clientId:$clientSecret')) {
    Logger.init(logLevel: logLevel, enableReleaseLogging: enableReleaseLogging);
    _oauthClient = OauthClient(
      auth: _auth,
      clientId: _clientId,
      connectionTimeout: connectionTimeout,
    );
    _tokenClient = TokenClient(connectionTimeout: connectionTimeout);
    _connectedRealmClient = ConnectedRealmClient(
      connectionTimeout: connectionTimeout,
    );
    _mythicKeystoneDungeonClient = MythicKeystoneDungeonClient(
      connectionTimeout: connectionTimeout,
    );
    _mythicKeystoneAffixClient = MythicKeystoneAffixClient(
      connectionTimeout: connectionTimeout,
    );
  }

  /// OAuthRegion start

  /// This is the only request necessary for the client credential flow,
  /// OAuth's authentication flow intended for application servers.
  ///
  /// Returns a [ClientCredentialsResponse] containing the access token.
  Future<ClientCredentialsResponse> postClientCredentials() async {
    return _oauthClient.postClientCredentials();
  }

  /// Builds Authorization Request [Uri] with the provided parameters.
  ///
  /// [redirectUri] is the URI to which the user will be redirected after authorization.
  /// [scope] is a list of [BattleNetScope] values defining the requested permissions.
  ///
  /// Returns a [Uri] for the authorization request.
  Uri buildAuthorizationUri({
    required Uri redirectUri,
    required List<BattleNetScope> scope,
  }) {
    return _oauthClient.buildAuthorizationUri(
      redirectUri: redirectUri,
      scope: scope,
    );
  }

  /// The access token request is the second part of the authorization code flow.
  /// When the first part completes, the user's browser is redirected to
  /// an application's redirect_uri. This redirect URI also includes
  /// an access code and (optionally) a state parameter. This request allows
  /// the application to exchange the access code for an access token to can
  /// use in subsequent API requests.
  ///
  /// [redirectUri] is the URI to which the user was redirected after authorization.
  /// [code] is the authorization code received from the authorization server.
  ///
  /// Returns an [AuthorizationCodeResponse] containing the access token and other details.
  Future<AuthorizationCodeResponse> postAuthorizationCode({
    required Uri redirectUri,
    required String code,
  }) async {
    return _oauthClient.postAuthorizationCode(
      redirectUri: redirectUri,
      code: code,
    );
  }

  /// Verifies that a given bearer token is valid and retrieves metadata
  /// about the token, including the client_id used to create the token,
  /// expiration timestamp, and scopes granted to the token.
  ///
  /// [token] is the bearer token to validate.
  ///
  /// Returns a [CheckTokenResponse] containing token metadata.
  Future<CheckTokenResponse> postTokenValidation({
    required String token,
  }) async {
    return _oauthClient.postTokenValidation(token: token);
  }

  /// Returns basic information about the user associated with the current bearer token.
  ///
  /// [accessToken] is the access token for the user.
  ///
  /// Returns a [UserInfoResponse] containing user information.
  Future<UserInfoResponse> getUserInfo({required String accessToken}) async {
    return _oauthClient.getUserInfo(accessToken: accessToken);
  }

  /// OAuthRegion end

  /// WoW Region start
  /// Game Region start

  /// Returns the WoW Token index.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [locale] specifies the Battle.net locale.
  ///
  /// Returns a [TokenIndexResponse] containing the WoW Token index data.
  Future<TokenIndexResponse> getTokenIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
  }) async {
    return _tokenClient.getTokenIndex(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      locale: locale,
    );
  }

  /// Returns a connected realm by ID.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [id] is the ID of the connected realm.
  ///
  /// Returns a [ConnectedRealmSearchData] for the specified connected realm.
  Future<ConnectedRealmSearchData> getConnectedRealm({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required int id,
  }) async {
    return _connectedRealmClient.getConnectedRealm(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      id: id,
    );
  }

  /// Query a connected realm by search parameters.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [statusType] filters by server status (e.g., [ServerStatus.UP]).
  /// [realmsTimezone] filters by realm timezone (e.g., [RealmTimezone.EUROPE_PARIS]).
  /// [orderBy] specifies the sorting order (defaults to 'id:asc').
  /// [page] specifies the page number for results (defaults to `1`).
  /// [pageSize] specifies the number of results per page (defaults to `150`).
  /// [hasQueue] filters by whether the realm has a queue.
  /// [populationType] filters by population type (e.g., [PopulationType.FULL]).
  /// [realmsIsTournament] filters by whether the realm is a tournament realm.
  ///
  /// Returns a [ConnectedRealmSearchResponse] containing search results.
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
    return _connectedRealmClient.getConnectedRealmSearch(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      statusType: statusType,
      realmsTimezone: realmsTimezone,
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      hasQueue: hasQueue,
      populationType: populationType,
      realmsIsTournament: realmsIsTournament,
    );
  }

  /// Returns an index of Mythic Keystone periods.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [locale] specifies the Battle.net locale.
  ///
  /// Returns a [MythicKeystonePeriodsIndexResponse] containing the index of periods.
  Future<MythicKeystonePeriodsIndexResponse> getMythicKeystonePeriodsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
  }) {
    return _mythicKeystoneDungeonClient.getMythicKeystonePeriodsIndex(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      locale: locale,
    );
  }

  /// Returns a Mythic Keystone period by ID.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [locale] specifies the Battle.net locale.
  /// [periodId] is the ID of the Mythic Keystone period.
  ///
  /// Returns a [MythicKeystonePeriodResponse] for the specified period.
  Future<MythicKeystonePeriodResponse> getMythicKeystonePeriod({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace, // Typically DYNAMIC
    required BattleNetLocale locale,
    required int periodId,
  }) {
    return _mythicKeystoneDungeonClient.getMythicKeystonePeriod(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      locale: locale,
      periodId: periodId,
    );
  }

  /// Returns an index of Mythic Keystone affixes.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [locale] specifies the Battle.net locale.
  ///
  /// Returns a [MythicKeystoneAffixesIndexResponse] containing the index of affixes.
  Future<MythicKeystoneAffixesIndexResponse> getMythicKeystoneAffixesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace, // Typically DYNAMIC
    required BattleNetLocale locale,
  }) {
    return _mythicKeystoneAffixClient.getMythicKeystoneAffixesIndex(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      locale: locale,
    );
  }

  /// Returns a Mythic Keystone affix by ID.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.dynamic]).
  /// [locale] specifies the Battle.net locale.
  /// [keystoneAffixId] is the ID of the Mythic Keystone affix.
  ///
  /// Returns a [MythicKeystoneAffixResponse] for the specified affix.
  Future<MythicKeystoneAffixResponse> getMythicKeystoneAffix({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace, // Typically DYNAMIC
    required BattleNetLocale locale,
    required int keystoneAffixId,
  }) {
    return _mythicKeystoneAffixClient.getMythicKeystoneAffix(
      accessToken: accessToken,
      region: region,
      namespace: namespace,
      locale: locale,
      keystoneAffixId: keystoneAffixId,
    );
  }

  /// Returns media for a Mythic Keystone affix by ID.
  ///
  /// [accessToken] is the access token for the request.
  /// [region] specifies the Battle.net region.
  /// [namespace] specifies the Battle.net namespace (e.g., [BattleNetNamespace.STATIC]).
  /// [locale] specifies the Battle.net locale.
  /// [keystoneAffixId] is the ID of the Mythic Keystone affix.
  ///
  /// Returns a [MythicKeystoneAffixMediaResponse] containing media for the specified affix.
  Future<MythicKeystoneAffixMediaResponse> getMythicKeystoneAffixMedia({
    required String accessToken,
    required BattleNetRegion region,
    // For Media, ensure this is BattleNetNamespace.STATIC or equivalent
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required int keystoneAffixId,
  }) {
    return _mythicKeystoneAffixClient.getMythicKeystoneAffixMedia(
      accessToken: accessToken,
      region: region,
      namespace: namespace, // Pass BattleNetNamespace.STATIC
      locale: locale,
      keystoneAffixId: keystoneAffixId,
    );
  }

  /// Game Region end
  /// WoW Region end
}
