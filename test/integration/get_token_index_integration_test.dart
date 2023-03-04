import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/token/token_index_response.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
      clientId: clientId,
      clientSecret: clientSecret,
      logLevel: LogLevel.BODY,
      enableReleaseLogging: false);

  group('get token retail', () {
    test('get token eu', () async {
      final TokenIndexResponse token = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
              accessToken: response.accessToken,
              region: BattleNetRegion.eu,
              namespace: BattleNetNamespace.dynamic,
              locale: BattleNetLocale.enGB));
      assert(token.price != -1);
    });

    test('get token us', () async {
      final TokenIndexResponse token = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
              accessToken: response.accessToken,
              region: BattleNetRegion.eu,
              namespace: BattleNetNamespace.dynamic,
              locale: BattleNetLocale.enUS));
      assert(token.price != -1);
    });

    test('get token kr', () async {
      final TokenIndexResponse token = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
              accessToken: response.accessToken,
              region: BattleNetRegion.kr,
              namespace: BattleNetNamespace.dynamic,
              locale: BattleNetLocale.koKR));
      assert(token.price != -1);
    });

    test('get token tw', () async {
      final TokenIndexResponse token = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
              accessToken: response.accessToken,
              region: BattleNetRegion.tw,
              namespace: BattleNetNamespace.dynamic,
              locale: BattleNetLocale.zhTW));
      assert(token.price != -1);
    });
  });

  group('get token classic', () {
    test('get token tw', () async {
      final TokenIndexResponse token = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
              accessToken: response.accessToken,
              region: BattleNetRegion.tw,
              namespace: BattleNetNamespace.dynamicClassic,
              locale: BattleNetLocale.zhTW));
      assert(token.price != -1);
    });
  });
}
