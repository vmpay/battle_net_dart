import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/realm/population_type_localised.dart';
import 'package:battle_net/src/models/realm/realm_localised.dart';
import 'package:battle_net/src/models/realm/server_status_localised.dart';
import 'package:http/http.dart' as http;

import 'models/client_credentials_response.dart';
import 'models/realm/connected_realm_response.dart';
import 'models/realm/connected_realm_search_response.dart';
import 'models/token/token_index_response.dart';

/// Battle Net dart wrapper client
class BattleNet {
  final String _auth;

  BattleNet(String clientId, String clientSecret)
      : _auth = base64.encode(utf8.encode('$clientId:$clientSecret'));

  ///This is the only request necessary for the client credential flow,
  ///OAuth's authentication flow intended for application servers.
  Future<ClientCredentialsResponse> postClientCredentials() async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $_auth',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final http.Request request =
        http.Request('POST', Uri.parse('https://oauth.battle.net/oauth/token'));
    request.bodyFields = <String, String>{'grant_type': 'client_credentials'};
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final ClientCredentialsResponse ccResponse =
          ClientCredentialsResponse.fromRawJson(
              await response.stream.bytesToString());
      return ccResponse;
    } else {
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
    final String baseUrl = region == BattleNetRegion.cn
        ? 'gateway.battlenet.com.cn'
        : '${region.slug}.api.blizzard.com';
    final http.Request request = http.Request('GET',
        Uri.parse('https://$baseUrl/data/wow/token/?locale=${locale.name}'));

    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final TokenIndexResponse tokenIndex =
          TokenIndexResponse.fromRawJson(await response.stream.bytesToString());
      return tokenIndex;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  /// Returns a connected realm by ID.
  Future<ConnectedRealmResponse> getConnectedRealm({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required int id,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Battlenet-Namespace': '${namespace.name}-${region.slug}'
    };
    final http.Request request = http.Request(
        'GET',
        Uri.parse(
            'https://${region.slug}.api.blizzard.com/data/wow/connected-realm/$id?locale=${locale.name}'));

    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return ConnectedRealmResponse.fromRawJson(
          await response.stream.bytesToString());
    } else {
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

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      // print('res $res');
      return ConnectedRealmSearchResponse.fromRawJson(res);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
