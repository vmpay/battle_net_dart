import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import '../../credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
    clientId: clientId,
    clientSecret: clientSecret,
    logLevel: LogLevel.NONE,
    enableReleaseLogging: false,
  );

  late String token;

  setUpAll(() async {
    final ClientCredentialsResponse creds = await battleNet
        .postClientCredentials();
    token = creds.accessToken;
  });

  group('WoW Classic Live Integration Smoke Tests (EU)', () {
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    test('Classic Era (classic1x) Auction Houses Index & Game Data', () async {
      final ConnectedRealmsIndexResponse crIdx = await battleNet
          .wow
          .connectedRealm
          .getConnectedRealmsIndex(
            accessToken: token,
            region: region,
            locale: locale,
            namespace: BattleNetNamespace.dynamicClassic1x,
          );
      expect(crIdx.connectedRealmIds, isNotEmpty);

      final AuctionHousesIndexResponse ahIdx = await battleNet.wow.auctionHouse
          .getAuctionHousesIndex(
            accessToken: token,
            region: region,
            locale: locale,
            connectedRealmId: crIdx.connectedRealmIds.first,
            namespace: BattleNetNamespace.dynamicClassic1x,
          );
      expect(ahIdx.auctions, isNotEmpty);

      expect(
        (await battleNet.wow.playableClass.getPlayableClassesIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.staticClassic1x,
        )).classes,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.playableRace.getPlayableRacesIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.staticClassic1x,
        )).races,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.achievement.getAchievementsIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.staticClassic1x,
        )).achievements,
        isNotEmpty,
      );
    });

    test('Progression Classic (classic) Game Data', () async {
      expect(
        (await battleNet.wow.realm.getRealmsIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.dynamicClassic,
        )).realms,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.playableClass.getPlayableClassesIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.staticClassic,
        )).classes,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.achievement.getAchievementsIndex(
          accessToken: token,
          region: region,
          locale: locale,
          namespace: BattleNetNamespace.staticClassic,
        )).achievements,
        isNotEmpty,
      );
    });
  });
}
