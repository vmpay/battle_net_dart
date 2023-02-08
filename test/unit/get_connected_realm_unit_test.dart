import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/models/realm/connected_realm_response.dart';
import 'package:battle_net/src/models/realm/population.dart';
import 'package:battle_net/src/models/realm/realm.dart';
import 'package:battle_net/src/models/realm/region.dart';
import 'package:test/test.dart';

void main() {
  const Self expectedSelf = Self(
      href:
          'https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu');
  const Links expectedLinks = Links(self: expectedSelf);
  const Population expectedPopulation = Population(type: 'HIGH', name: 'High');
  const Region expectedRegion =
      Region(key: expectedSelf, name: 'Europe', id: 3);
  const Realm expectedRealm = Realm(
      id: 1301,
      region: expectedRegion,
      connectedRealm: expectedSelf,
      name: 'Europe',
      category: 'English',
      locale: 'enGB',
      timezone: 'Europe/Paris',
      type: expectedPopulation,
      isTournament: false,
      slug: 'outland');
  const ConnectedRealmResponse expectedConnectedRealmResponse =
      ConnectedRealmResponse(
          links: expectedLinks,
          id: 1301,
          hasQueue: false,
          status: expectedPopulation,
          population: expectedPopulation,
          realms: <Realm>[expectedRealm],
          mythicLeaderboards: expectedSelf,
          auctions: expectedSelf);

  group('get connected realm mapping', () {
    test('population response', () async {
      final Population population =
          Population.fromRawJson('{"type": "HIGH","name": "High"}');
      expect(population, expectedPopulation);
    });

    test('region response', () async {
      final Region region = Region.fromRawJson(
          ' {"key": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"name": "Europe","id": 3}');
      expect(region, expectedRegion);
    });

    test('realm response', () async {
      final Realm realm = Realm.fromRawJson(
          '{"id": 1301,"region": {"key": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"name": "Europe","id": 3},"connected_realm": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"name": "Europe","category": "English","locale": "enGB","timezone": "Europe/Paris","type": {"type": "HIGH","name": "High"},"is_tournament": false,"slug": "outland"}');
      expect(realm, expectedRealm);
    });

    test('connected realm response', () async {
      final ConnectedRealmResponse actual = ConnectedRealmResponse.fromRawJson(
          '{"_links": {"self": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"}},"id": 1301,"has_queue": false,"status": {"type": "HIGH","name": "High"},"population": {"type": "HIGH","name": "High"},"realms": [{"id": 1301,"region": {"key": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"name": "Europe","id": 3},"connected_realm": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"name": "Europe","category": "English","locale": "enGB","timezone": "Europe/Paris","type": {"type": "HIGH","name": "High"},"is_tournament": false,"slug": "outland"}],"mythic_leaderboards": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"},"auctions": {"href": "https://eu.api.blizzard.com/data/wow/region/3?namespace=dynamic-eu"}}');
      expect(actual, expectedConnectedRealmResponse);
    });
  });
}
