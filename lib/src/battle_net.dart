import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:http/http.dart' as http;

import 'models/client_credentials_response.dart';
import 'models/token_index.dart';

class BattleNet {
  final String _clientId;
  final String _clientSecret;

  BattleNet(this._clientId, this._clientSecret);

  Future<ClientCredentialsResponse> postClientCredentials(
      BattleNetRegion region) async {
    final String auth = base64.encode(utf8.encode('$_clientId:$_clientSecret'));
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $auth',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final http.Request request = http.Request(
        'POST', Uri.parse('https://${region.slug}.battle.net/oauth/token'));
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

  Future<TokenIndex> getTokenIndex(String accessToken, BattleNetRegion region,
      BattleNetNamespace namespace, BattleNetLocale locale) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken'
    };
    final String baseUrl = region == BattleNetRegion.cn
        ? 'gateway.battlenet.com.cn'
        : '${region.slug}.api.blizzard.com';
    final http.Request request = http.Request(
        'GET',
        Uri.parse(
            'https://$baseUrl/data/wow/token/?namespace=${namespace.name}-${region.slug}&locale=${locale.name}'));

    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final TokenIndex tokenIndex =
          TokenIndex.fromRawJson(await response.stream.bytesToString());
      return tokenIndex;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
