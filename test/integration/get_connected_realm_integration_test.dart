import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/realm/connected_realm_response.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(clientId, clientSecret);

  test('get connected realm eu', () async {
    const int mockId = 1301;
    const String mockName = 'Outland';
    final ConnectedRealmResponse result = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse value) => battleNet.getConnectedRealm(
            accessToken: value.accessToken,
            region: BattleNetRegion.eu,
            namespace: BattleNetNamespace.dynamic,
            locale: BattleNetLocale.enGB,
            id: mockId));
    expect(result.id, mockId);
    expect(result.realms[0].name, mockName);
  });

  test('get connected realm kr', () async {
    const int mockId = 214;
    const String mockName = '윈드러너';
    final ConnectedRealmResponse result = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse value) => battleNet.getConnectedRealm(
            accessToken: value.accessToken,
            region: BattleNetRegion.kr,
            namespace: BattleNetNamespace.dynamic,
            locale: BattleNetLocale.koKR,
            id: mockId));
    expect(result.id, mockId);
    expect(result.realms[0].name, mockName);
  });

  test('get connected realm us', () async {
    const int mockId = 1185;
    const String mockName = 'Sen\'jin';
    final ConnectedRealmResponse result = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse value) => battleNet.getConnectedRealm(
            accessToken: value.accessToken,
            region: BattleNetRegion.us,
            namespace: BattleNetNamespace.dynamic,
            locale: BattleNetLocale.enUS,
            id: mockId));
    expect(result.id, mockId);
    expect(result.realms[0].name, mockName);
  });

  test('get connected realm tw', () async {
    const int mockId = 966;
    const String mockName = '巨龍之喉';
    final ConnectedRealmResponse result = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse value) => battleNet.getConnectedRealm(
            accessToken: value.accessToken,
            region: BattleNetRegion.tw,
            namespace: BattleNetNamespace.dynamic,
            locale: BattleNetLocale.zhTW,
            id: mockId));
    expect(result.id, mockId);
    expect(result.realms[0].name, mockName);
  });
}
