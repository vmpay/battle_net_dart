import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/realm/connected_realm_response.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
      clientId: clientId,
      clientSecret: clientSecret,
      logLevel: LogLevel.BODY,
      enableReleaseLogging: false);

  group('get connected realm retail', () {
    test('get connected realm eu', () async {
      const int mockId = 1301;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.eu,
                  namespace: BattleNetNamespace.dynamic,
                  locale: BattleNetLocale.enGB,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, 'Outland');
    });

    test('get connected realm kr', () async {
      const int mockId = 214;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.kr,
                  namespace: BattleNetNamespace.dynamic,
                  locale: BattleNetLocale.koKR,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, '윈드러너');
    });

    test('get connected realm us', () async {
      const int mockId = 1185;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.us,
                  namespace: BattleNetNamespace.dynamic,
                  locale: BattleNetLocale.enUS,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, 'Sen\'jin');
    });

    test('get connected realm tw', () async {
      const int mockId = 966;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.tw,
                  namespace: BattleNetNamespace.dynamic,
                  locale: BattleNetLocale.zhTW,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, '巨龍之喉');
    });
  });

  group('get connected realm classic', () {
    test('get connected realm eu', () async {
      const int mockId = 4440;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.eu,
                  namespace: BattleNetNamespace.dynamicClassic,
                  locale: BattleNetLocale.enGB,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, 'Everlook');
    });

    test('get connected realm kr', () async {
      const int mockId = 4420;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.kr,
                  namespace: BattleNetNamespace.dynamicClassic,
                  locale: BattleNetLocale.koKR,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, '얼음피');
    });

    test('get connected realm us', () async {
      const int mockId = 4408;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.us,
                  namespace: BattleNetNamespace.dynamicClassic,
                  locale: BattleNetLocale.enUS,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, 'Faerlina');
    });

    test('get connected realm tw', () async {
      const int mockId = 4488;
      final ConnectedRealmResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealm(
                  accessToken: value.accessToken,
                  region: BattleNetRegion.tw,
                  namespace: BattleNetNamespace.dynamicClassic,
                  locale: BattleNetLocale.zhTW,
                  id: mockId));
      expect(result.id, mockId);
      expect(result.realms[0].name, '烏蘇雷');
    });
  });
}
