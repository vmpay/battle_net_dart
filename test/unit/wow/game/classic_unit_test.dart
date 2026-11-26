import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('WoW Classic Support Unit Tests', () {
    const String token = 'tok';
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    test('BattleNetNamespace Classic profile values', () {
      expect(BattleNetNamespace.profileClassic.name, 'profile-classic');
      expect(BattleNetNamespace.profileClassic1x.name, 'profile-classic1x');
    });

    test('Classic Auction House endpoints and namespace routing', () async {
      final List<String> namespaces = <String>[];
      final BattleNet bn = BattleNet(
        clientId: 'id',
        clientSecret: 'secret',
        logLevel: LogLevel.NONE,
        httpClient: MockClient((http.Request req) async {
          namespaces.add(req.url.queryParameters['namespace'] ?? '');
          if (req.url.path == '/data/wow/connected-realm/6113/auctions/index') {
            return http.Response(
              '{"auctions":[{"id":2,"name":"Alliance Auction House"}]}',
              200,
            );
          }
          if (req.url.path == '/data/wow/connected-realm/6113/auctions/2') {
            return http.Response(
              '{"auctions":[{"id":1,"item":{"id":19019},"quantity":1,"buyout":100}]}',
              200,
            );
          }
          return http.Response('{"id":100,"name":"ClassicChar"}', 200);
        }),
      );

      final AuctionHousesIndexResponse idx = await bn.wow.auctionHouse
          .getAuctionHousesIndex(
            accessToken: token,
            region: region,
            locale: locale,
            connectedRealmId: 6113,
          );
      expect(idx.auctions.single.id, 2);
      expect(idx.auctions.single.name, 'Alliance Auction House');

      final AuctionsResponse ah = await bn.wow.auctionHouse.getClassicAuctions(
        accessToken: token,
        region: region,
        locale: locale,
        connectedRealmId: 6113,
        auctionHouseId: 2,
      );
      expect(ah.auctions.single.itemId, 19019);

      final CharacterProfileResponse ch = await bn.wow.character
          .getCharacterProfile(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: 'firemaw',
            characterName: 'thrall',
            namespace: BattleNetNamespace.profileClassic,
          );
      expect(ch.name, 'ClassicChar');

      expect(namespaces, <String>[
        'dynamic-classic1x-eu',
        'dynamic-classic1x-eu',
        'profile-classic-eu',
      ]);
    });
  });
}
