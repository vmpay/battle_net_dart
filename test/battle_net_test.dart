import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/token_index.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(clientId, clientSecret);

  test('get token eu', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.eu);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.eu, BattleNetNamespace.dynamic, BattleNetLocale.enGB);
    assert(token.price != -1);
  });

  test('get token us', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.eu);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.eu, BattleNetNamespace.dynamic, BattleNetLocale.enUS);
    assert(token.price != -1);
  });

  test('get token kr', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.eu);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.kr, BattleNetNamespace.dynamic, BattleNetLocale.koKR);
    assert(token.price != -1);
  });

  test('get token tw', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.eu);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.tw, BattleNetNamespace.dynamic, BattleNetLocale.zhTW);
    assert(token.price != -1);
  });

  test('get token cn', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.cn);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.cn, BattleNetNamespace.dynamic, BattleNetLocale.zhCN);
    assert(token.price != -1);
  });

  test('get token cn classic cn', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.cn);
    final TokenIndex token = await battleNet.getTokenIndex(
        response.accessToken,
        BattleNetRegion.cn,
        BattleNetNamespace.dynamicClassic,
        BattleNetLocale.zhCN);
    assert(token.price != -1);
  });
}
