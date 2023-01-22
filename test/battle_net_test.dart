import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/token_index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final BattleNet battleNet = BattleNet(
      '', '');

  test('get token eu', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.eu, BattleNetNamespace.dynamic, BattleNetLocale.enGB);
    print(response);
    print(token);
  });

  test('get token us', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.us, BattleNetNamespace.dynamic, BattleNetLocale.enUS);
    print(response);
    print(token);
  });

  test('get token kr', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.kr, BattleNetNamespace.dynamic, BattleNetLocale.koKR);
    print(response);
    print(token);
  });

  test('get token tw', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.tw, BattleNetNamespace.dynamic, BattleNetLocale.zhTW);
    print(response);
    print(token);
  });

  test('get token cn', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(response.accessToken,
        BattleNetRegion.cn, BattleNetNamespace.dynamic, BattleNetLocale.zhCN);
    print(response);
    print(token);
  });

  test('get token cn classic', () async {
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials(BattleNetRegion.us);
    final TokenIndex token = await battleNet.getTokenIndex(
        response.accessToken,
        BattleNetRegion.cn,
        BattleNetNamespace.dynamicClassic,
        BattleNetLocale.zhCN);
    print(response);
    print(token);
  });
}
