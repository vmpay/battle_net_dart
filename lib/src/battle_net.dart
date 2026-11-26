import 'dart:convert';

import 'package:battle_net/src/oauth/oauth_client.dart';
import 'package:battle_net/src/wow/game/connected_realm/connected_realm_client.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/mythic_keystone_affix_client.dart';
import 'package:battle_net/src/wow/game/token/models/token_index_response.dart';
import 'package:battle_net/src/wow/game/token/token_client.dart';
import 'package:http/http.dart' as http;

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
import 'wow/forever/forever_account_client.dart';
import 'wow/forever/forever_character_client.dart';
import 'wow/forever/forever_character_slug.dart';
import 'wow/forever/forever_item_client.dart';
import 'wow/forever/forever_ruleset_client.dart';
import 'wow/forever/models/forever_account_models.dart';
import 'wow/forever/models/forever_character_models.dart';
import 'wow/forever/models/forever_item_models.dart';
import 'wow/forever/models/forever_ruleset_models.dart';
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
import 'wow/wow_api.dart';

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

  /// The version string used for WoW: Forever static namespaces.
  @Deprecated(
    'Unversioned staticForever resolves to the current build automatically. '
    'This field will be removed in 0.5.0.',
  )
  final String foreverStaticVersion;

  /// Grouped World of Warcraft API sub-clients.
  late final WowApi wow;

  late final OauthClient _oauthClient;
  late final TokenClient _tokenClient;
  late final ConnectedRealmClient _connectedRealmClient;
  late final MythicKeystoneDungeonClient _mythicKeystoneDungeonClient;
  late final MythicKeystoneAffixClient _mythicKeystoneAffixClient;
  late final ForeverCharacterClient _foreverCharacterClient;
  late final ForeverAccountClient _foreverAccountClient;
  late final ForeverItemClient _foreverItemClient;
  late final ForeverRulesetClient _foreverRulesetClient;

  /// Creates an instance of [BattleNet].
  ///
  /// [clientId] and [clientSecret] are required for authentication.
  /// [logLevel] specifies the level of logging for API requests (defaults to [LogLevel.BASIC]).
  /// [enableReleaseLogging] determines if logging is enabled in release mode (defaults to `false`).
  /// [connectionTimeout] sets the timeout for API requests in milliseconds (defaults to `10000`).
  /// [foreverStaticVersion] is deprecated and ignored; will be removed in 0.5.0.
  /// [httpClient] is an optional HTTP client used by the OAuth and WoW
  /// clients (useful for testing). Defaults to a new [http.Client] per client.
  BattleNet({
    required String clientId,
    required String clientSecret,
    LogLevel logLevel = LogLevel.BASIC,
    bool enableReleaseLogging = false,
    this.connectionTimeout = 10000,
    @Deprecated(
      'Unversioned staticForever is used automatically; removed in 0.5.0.',
    )
    this.foreverStaticVersion = '1.60.1_70399',
    http.Client? httpClient,
  }) : _clientId = clientId,
       _auth = base64.encode(utf8.encode('$clientId:$clientSecret')) {
    Logger.init(logLevel: logLevel, enableReleaseLogging: enableReleaseLogging);
    _oauthClient = OauthClient(
      auth: _auth,
      clientId: _clientId,
      connectionTimeout: connectionTimeout,
      httpClient: httpClient,
    );
    _tokenClient = TokenClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _connectedRealmClient = ConnectedRealmClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _mythicKeystoneDungeonClient = MythicKeystoneDungeonClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _mythicKeystoneAffixClient = MythicKeystoneAffixClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _foreverCharacterClient = ForeverCharacterClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _foreverAccountClient = ForeverAccountClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _foreverItemClient = ForeverItemClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    _foreverRulesetClient = ForeverRulesetClient(
      connectionTimeout: connectionTimeout,
      client: httpClient,
    );
    wow = WowApi(
      connectionTimeout: connectionTimeout,
      httpClient: httpClient,
      token: _tokenClient,
      connectedRealm: _connectedRealmClient,
      mythicKeystoneDungeon: _mythicKeystoneDungeonClient,
      mythicKeystoneAffix: _mythicKeystoneAffixClient,
      foreverCharacter: _foreverCharacterClient,
      foreverAccount: _foreverAccountClient,
      foreverItem: _foreverItemClient,
      foreverRuleset: _foreverRulesetClient,
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

  /// Exchanges a [refreshToken] for a new access token.
  ///
  /// Returns an [AuthorizationCodeResponse] containing the new access token
  /// and refresh token details.
  Future<AuthorizationCodeResponse> refreshAccessToken({
    required String refreshToken,
  }) async {
    return _oauthClient.refreshAccessToken(refreshToken: refreshToken);
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

  /// WoW: Forever Region start

  /// Returns the base character profile for a WoW: Forever character.
  Future<ForeverCharacterProfileResponse> getForeverCharacterProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterProfile(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns a Forever character's equipped items.
  Future<ForeverCharacterEquipmentResponse> getForeverCharacterEquipment({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterEquipment(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns render asset URLs for a Forever character.
  Future<ForeverCharacterMediaResponse> getForeverCharacterMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterMedia(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns a Forever character's completed achievements.
  Future<ForeverCharacterAchievementsResponse> getForeverCharacterAchievements({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterAchievements(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns achievement statistics for a Forever character.
  Future<ForeverCharacterStatisticsResponse> getForeverCharacterStatistics({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterStatistics(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns dungeon encounter completion data for a Forever character.
  Future<ForeverCharacterEncountersResponse>
  getForeverCharacterDungeonEncounters({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterDungeonEncounters(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns the PvP summary for a Forever character.
  Future<ForeverCharacterPvpSummaryResponse> getForeverCharacterPvpSummary({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterPvpSummary(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns completed quests for a Forever character.
  Future<ForeverCharacterQuestsResponse> getForeverCharacterCompletedQuests({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterCompletedQuests(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns reputations for a Forever character.
  Future<ForeverCharacterReputationsResponse> getForeverCharacterReputations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterReputations(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns profession skill levels for a Forever character.
  Future<ForeverCharacterProfessionsResponse> getForeverCharacterProfessions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterProfessions(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns specialization data for a Forever character.
  Future<ForeverCharacterSpecializationsResponse>
  getForeverCharacterSpecializations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterSpecializations(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns unlocked titles for a Forever character.
  Future<ForeverCharacterTitlesResponse> getForeverCharacterTitles({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterTitles(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns the mount and pet collection summary for a Forever character.
  Future<ForeverCharacterCollectionsResponse> getForeverCharacterCollections({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _foreverCharacterClient.getForeverCharacterCollections(
    accessToken: accessToken,
    region: region,
    locale: locale,
    slug: slug,
  );

  /// Returns the WoW: Forever account profile summary.
  ///
  /// [accessToken] must be a **user token** with `wow.profile` scope.
  Future<ForeverAccountProfileResponse> getForeverAccountProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
  }) => _foreverAccountClient.getForeverAccountProfile(
    accessToken: accessToken,
    region: region,
    locale: locale,
  );

  /// Returns item data for the given [itemId] in WoW: Forever.
  Future<ForeverItemResponse> getItemData({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemId,
  }) => _foreverItemClient.getItemData(
    accessToken: accessToken,
    region: region,
    locale: locale,
    itemId: itemId,
  );

  /// Returns an index of all active WoW: Forever rulesets.
  Future<ForeverRulesetIndexResponse> getForeverRulesetIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
  }) => _foreverRulesetClient.getForeverRulesetIndex(
    accessToken: accessToken,
    region: region,
    locale: locale,
  );

  /// Returns details for a specific WoW: Forever ruleset.
  Future<ForeverRulesetResponse> getForeverRuleset({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int rulesetId,
  }) => _foreverRulesetClient.getForeverRuleset(
    accessToken: accessToken,
    region: region,
    locale: locale,
    rulesetId: rulesetId,
  );

  /// Returns a paginated view of the auction house for a WoW: Forever ruleset.
  Future<ForeverAuctionPageResponse> getForeverRulesetAuctions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int rulesetId,
    int page = 1,
    int pageSize = 100,
  }) => _foreverRulesetClient.getForeverRulesetAuctions(
    accessToken: accessToken,
    region: region,
    locale: locale,
    rulesetId: rulesetId,
    page: page,
    pageSize: pageSize,
  );

  /// WoW: Forever Region end
  /// WoW Region end
}
