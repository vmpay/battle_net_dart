import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/realm/population_type_localised.dart';
import 'package:battle_net/src/models/realm/realm_localised.dart';
import 'package:battle_net/src/models/realm/server_status_localised.dart';
import 'package:http/http.dart' as http;

import 'constants/battle_net_scope.dart';
import 'logger/log_level.dart';
import 'logger/logger.dart';
import 'models/oauth/authorization_code_response.dart';
import 'models/oauth/check_token_response.dart';
import 'models/oauth/client_credentials_response.dart';
import 'models/oauth/user_info_response.dart';
import 'models/realm/connected_realm_search_data.dart';
import 'models/realm/connected_realm_search_response.dart';
import 'models/token/token_index_response.dart';

/// Battle Net dart wrapper client
class BattleNet {
  final String _auth;
  final String _clientId;
  final int connectionTimeout;

  BattleNet({
    required String clientId,
    required String clientSecret,
    LogLevel logLevel = LogLevel.BASIC,
    bool enableReleaseLogging = false,
    this.connectionTimeout = 10000,
  })  : _clientId = clientId,
        _auth = base64.encode(utf8.encode('$clientId:$clientSecret')) {
    Logger.init(logLevel: logLevel, enableReleaseLogging: enableReleaseLogging);
  }

  /// This is the only request necessary for the client credential flow,
  /// OAuth's authentication flow intended for application servers.
  Future<ClientCredentialsResponse> postClientCredentials() async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $_auth',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final http.Request request =
        http.Request('POST', Uri.parse('https://oauth.battle.net/oauth/token'));
    request.bodyFields = <String, String>{'grant_type': 'client_credentials'};
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final ClientCredentialsResponse clientCredentialsResponse =
          ClientCredentialsResponse.fromRawJson(body);
      return clientCredentialsResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Builds Authorization Request [Uri] with the provided parameters
  Uri buildAuthorizationUri({
    required Uri redirectUri,
    required List<BattleNetScope> scope,
  }) {
    return Uri.parse(
      'https://oauth.battle.net/authorize'
      '?response_type=code'
      '&client_id=$_clientId'
      '&redirect_uri=$redirectUri'
      '&scope=${scope.fold('', (String previousValue, BattleNetScope element) => '$previousValue${element.name} ')}',
    );
  }

  /// The access token request is the second part of the authorization code flow.
  /// When the first part completes, the user's browser is redirected to
  /// an application's redirect_uri. This redirect URI also includes
  /// an access code and (optionally) a state parameter. This request allows
  /// the application to exchange the access code for an access token to can
  /// use in subsequent API requests.
  Future<AuthorizationCodeResponse> postAuthorizationCode({
    required Uri redirectUri,
    required String code,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $_auth',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final http.Request request =
        http.Request('POST', Uri.parse('https://oauth.battle.net/oauth/token'));
    request.bodyFields = <String, String>{
      'grant_type': 'authorization_code',
      'redirect_uri': '$redirectUri',
      'code': code,
    };
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final AuthorizationCodeResponse authorizationCodeResponse =
          AuthorizationCodeResponse.fromRawJson(body);
      return authorizationCodeResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Verifies that a given bearer token is valid and retrieves metadata
  /// about the token, including the client_id used to create the token,
  /// expiration timestamp, and scopes granted to the token.
  Future<CheckTokenResponse> postTokenValidation({
    required String token,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('https://oauth.battle.net/oauth/check_token'));
    request.bodyFields = <String, String>{'token': token};
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final CheckTokenResponse checkTokenResponse =
          CheckTokenResponse.fromRawJson(body);
      return checkTokenResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Returns basic information about the user associated with the current bearer token.
  Future<UserInfoResponse> getUserInfo({
    required String accessToken,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
    };
    final http.Request request =
        http.Request('GET', Uri.parse('https://eu.battle.net/oauth/userinfo'));
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final UserInfoResponse userInfoResponse =
          UserInfoResponse.fromRawJson(body);
      return userInfoResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Returns the WoW Token index.
  Future<TokenIndexResponse> getTokenIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Battlenet-Namespace': '${namespace.name}-${region.slug}'
    };
    final String baseUrl = '${region.slug}.api.blizzard.com';
    final http.Request request = http.Request('GET',
        Uri.parse('https://$baseUrl/data/wow/token/?locale=${locale.name}'));
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final TokenIndexResponse tokenIndex =
          TokenIndexResponse.fromRawJson(body);
      return tokenIndex;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Returns a connected realm by ID.
  Future<ConnectedRealmSearchData> getConnectedRealm({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required int id,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Battlenet-Namespace': '${namespace.name}-${region.slug}'
    };
    final http.Request request = http.Request(
        'GET',
        Uri.parse(
            'https://${region.slug}.api.blizzard.com/data/wow/connected-realm/$id'));
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      return ConnectedRealmSearchData.fromRawJson(body);
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Query a connected realm by search parameters
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
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Battlenet-Namespace': '${namespace.name}-${region.slug}'
    };
    final http.Request request = http.Request(
      'GET',
      Uri.parse(
          'https://${region.slug}.api.blizzard.com/data/wow/search/connected-realm?status.type=${statusType != null ? serverStatusValues.reverse[statusType] : ''}&realms.timezone=${realmsTimezone != null ? realmTimezoneValues.reverse[realmsTimezone] : ''}&population.type=${populationType != null ? populationTypeValues.reverse[populationType] : ''}&orderby=$orderBy&_page=$page&_pageSize=$pageSize&has_queue=${hasQueue ?? ''}&realms.is_tournament=${realmsIsTournament ?? ''}'),
    );
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response =
        await request.send().timeout(Duration(milliseconds: connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      return ConnectedRealmSearchResponse.fromRawJson(body);
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }
}
