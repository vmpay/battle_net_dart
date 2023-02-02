import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/token_index_response.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(clientId, clientSecret);

  test('get token eu', () async {
    final TokenIndexResponse token = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
            response.accessToken,
            BattleNetRegion.eu,
            BattleNetNamespace.dynamic,
            BattleNetLocale.enGB));
    assert(token.price != -1);
  });

  test('get token us', () async {
    final TokenIndexResponse token = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
            response.accessToken,
            BattleNetRegion.eu,
            BattleNetNamespace.dynamic,
            BattleNetLocale.enUS));
    assert(token.price != -1);
  });

  test('get token kr', () async {
    final TokenIndexResponse token = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
            response.accessToken,
            BattleNetRegion.kr,
            BattleNetNamespace.dynamic,
            BattleNetLocale.koKR));
    assert(token.price != -1);
  });

  test('get token tw', () async {
    final TokenIndexResponse token = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
            response.accessToken,
            BattleNetRegion.tw,
            BattleNetNamespace.dynamic,
            BattleNetLocale.zhTW));
    assert(token.price != -1);
  });
}
