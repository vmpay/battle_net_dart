import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/models/oauth/client_credentials_response.dart';
import 'package:battle_net/src/models/realm/connected_realm_search_response.dart';
import 'package:battle_net/src/models/realm/population_type_localised.dart';
import 'package:battle_net/src/models/realm/realm_localised.dart';
import 'package:battle_net/src/models/realm/server_status_localised.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
      clientId: clientId,
      clientSecret: clientSecret,
      logLevel: LogLevel.BODY,
      enableReleaseLogging: false);

  group('get connected realm search retail', () {
    test('get connected realm search eu with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.eu,
                namespace: BattleNetNamespace.dynamic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.EUROPE_PARIS,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 580);
    });

    test('get connected realm search eu', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.eu,
                namespace: BattleNetNamespace.dynamic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 509);
    });

    test('get connected realm kr with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.kr,
                namespace: BattleNetNamespace.dynamic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.ASIA_SEOUL,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 205);
    });

    test('get connected realm kr', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.kr,
                namespace: BattleNetNamespace.dynamic,
                realmsTimezone: RealmTimezone.ASIA_SEOUL,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 205);
    });

    test('get connected realm us with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.AMERICA_LOS_ANGELES,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 5);
    });

    test('get connected realm us', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4);
    });

    test('get connected realm tw with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.tw,
                namespace: BattleNetNamespace.dynamic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.ASIA_TAIPEI,
                hasQueue: false,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 963);
    });

    test('get connected realm tw', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.tw,
                namespace: BattleNetNamespace.dynamic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 963);
    });
  });

  group('get connected realm search classic', () {
    test('get connected realm search eu with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.eu,
                namespace: BattleNetNamespace.dynamicClassic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.EUROPE_PARIS,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4474);
    });

    test('get connected realm search eu', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.eu,
                namespace: BattleNetNamespace.dynamicClassic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4440);
    });

    test('get connected realm kr with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.kr,
                namespace: BattleNetNamespace.dynamicClassic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.ASIA_SEOUL,
                hasQueue: false,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4417);
    });

    test('get connected realm kr', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.kr,
                namespace: BattleNetNamespace.dynamicClassic,
                realmsTimezone: RealmTimezone.ASIA_SEOUL,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4417);
    });

    test('get connected realm us with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamicClassic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.AMERICA_LOS_ANGELES,
                hasQueue: false,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4372);
    });

    test('get connected realm us', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamicClassic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4372);
    });

    test('get connected realm tw with parameters', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.tw,
                namespace: BattleNetNamespace.dynamicClassic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.ASIA_TAIPEI,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4485);
    });

    test('get connected realm tw', () async {
      final ConnectedRealmSearchResponse result = await battleNet
          .postClientCredentials()
          .then((ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.tw,
                namespace: BattleNetNamespace.dynamicClassic,
              ));
      expect(result.page, 1);
      expect(result.results.first.data.id, 4485);
    });
  });
}
