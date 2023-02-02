import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:http/http.dart' as http;

import 'models/client_credentials_response.dart';
import 'models/token_index_response.dart';

class BattleNet {
  final String _auth;

  BattleNet(String clientId, String clientSecret)
      : _auth = base64.encode(utf8.encode('$clientId:$clientSecret'));

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

  Future<TokenIndexResponse> getTokenIndex(
      String accessToken,
      BattleNetRegion region,
      BattleNetNamespace namespace,
      BattleNetLocale locale) async {
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
}
