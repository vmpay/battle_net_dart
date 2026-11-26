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

  group('Batch A Live Integration Smoke Tests (EU)', () {
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    test('Realm, ConnectedRealm index, Region', () async {
      final RealmsIndexResponse realms = await battleNet.wow.realm
          .getRealmsIndex(accessToken: token, region: region, locale: locale);
      expect(realms.realms, isNotEmpty);

      final RealmResponse ravencrest = await battleNet.wow.realm.getRealm(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: 'ravencrest',
      );
      expect(ravencrest.slug, 'ravencrest');

      final SearchResponse search = await battleNet.wow.realm.searchRealms(
        accessToken: token,
        region: region,
        locale: locale,
        pageSize: 2,
      );
      expect(search.results, isNotEmpty);

      final ConnectedRealmsIndexResponse crIdx = await battleNet
          .wow
          .connectedRealm
          .getConnectedRealmsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(crIdx.connectedRealmIds, isNotEmpty);

      final RegionsIndexResponse regIdx = await battleNet.wow.region
          .getRegionsIndex(accessToken: token, region: region, locale: locale);
      expect(regIdx.regionHrefs, isNotEmpty);

      final RegionResponse eu = await battleNet.wow.region.getRegion(
        accessToken: token,
        region: region,
        locale: locale,
        regionId: 3,
      );
      expect(eu.tag, 'EU');
    });

    test('Item API (Retail + Classic probes)', () async {
      final ItemClassesIndexResponse classes = await battleNet.wow.item
          .getItemClassesIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(classes.itemClasses, isNotEmpty);

      final ItemClassResponse weapon = await battleNet.wow.item.getItemClass(
        accessToken: token,
        region: region,
        locale: locale,
        itemClassId: 2,
      );
      expect(weapon.id, 2);

      final ItemSubclassResponse sword = await battleNet.wow.item
          .getItemSubclass(
            accessToken: token,
            region: region,
            locale: locale,
            itemClassId: 2,
            itemSubclassId: 7,
          );
      expect(sword.id, 7);

      final ItemSetsIndexResponse sets = await battleNet.wow.item
          .getItemSetsIndex(accessToken: token, region: region, locale: locale);
      expect(sets.itemSets, isNotEmpty);

      final ItemSetResponse itemSet = await battleNet.wow.item.getItemSet(
        accessToken: token,
        region: region,
        locale: locale,
        itemSetId: sets.itemSets.first.id!,
      );
      expect(itemSet.id, isNotNull);

      final ItemResponse tf = await battleNet.wow.item.getItem(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
      );
      expect(tf.id, 19019);

      // Classic probes
      final ItemResponse tfClassic = await battleNet.wow.item.getItem(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
        namespace: BattleNetNamespace.staticClassic,
      );
      expect(tfClassic.id, 19019);

      final ItemResponse tfClassic1x = await battleNet.wow.item.getItem(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
        namespace: BattleNetNamespace.staticClassic1x,
      );
      expect(tfClassic1x.id, 19019);

      final MediaResponse media = await battleNet.wow.item.getItemMedia(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
      );
      expect(media.assets, isNotEmpty);

      final SearchResponse search = await battleNet.wow.item.searchItems(
        accessToken: token,
        region: region,
        locale: locale,
        filters: <String, String>{'name.en_US': 'Thunderfury'},
      );
      expect(search.results, isNotEmpty);
    });

    test('Profession API', () async {
      final ProfessionsIndexResponse idx = await battleNet.wow.profession
          .getProfessionsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(idx.professions, isNotEmpty);

      final ProfessionResponse bs = await battleNet.wow.profession
          .getProfession(
            accessToken: token,
            region: region,
            locale: locale,
            professionId: 164,
          );
      expect(bs.skillTiers, isNotEmpty);

      final MediaResponse media = await battleNet.wow.profession
          .getProfessionMedia(
            accessToken: token,
            region: region,
            locale: locale,
            professionId: 164,
          );
      expect(media.assets, isNotEmpty);

      final int tierId = bs.skillTiers.first.id!;
      final SkillTierResponse tier = await battleNet.wow.profession
          .getProfessionSkillTier(
            accessToken: token,
            region: region,
            locale: locale,
            professionId: 164,
            skillTierId: tierId,
          );
      expect(tier.categories, isNotEmpty);

      final int recipeId = tier.categories.first.recipes.first.id!;
      final RecipeResponse recipe = await battleNet.wow.profession.getRecipe(
        accessToken: token,
        region: region,
        locale: locale,
        recipeId: recipeId,
      );
      expect(recipe.id, recipeId);

      final MediaResponse rMedia = await battleNet.wow.profession
          .getRecipeMedia(
            accessToken: token,
            region: region,
            locale: locale,
            recipeId: recipeId,
          );
      expect(rMedia.assets, isNotEmpty);
    });

    test('Mythic Keystone Dungeon & Leaderboards', () async {
      final MythicKeystoneIndexResponse mkIdx = await battleNet
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(mkIdx.seasonsHref, isNotEmpty);

      final MythicKeystoneDungeonsIndexResponse dungeons = await battleNet
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneDungeonsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(dungeons.dungeons, isNotEmpty);

      final MythicKeystoneDungeonResponse dungeon = await battleNet
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneDungeon(
            accessToken: token,
            region: region,
            locale: locale,
            dungeonId: dungeons.dungeons.first.id!,
          );
      expect(dungeon.id, isNotNull);

      final MythicKeystoneSeasonsIndexResponse seasons = await battleNet
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneSeasonsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(seasons.seasons, isNotEmpty);

      final MythicKeystoneSeasonResponse season = await battleNet
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneSeason(
            accessToken: token,
            region: region,
            locale: locale,
            seasonId: seasons.currentSeasonId!,
          );
      expect(season.periods, isNotEmpty);

      final MythicKeystoneLeaderboardsIndexResponse lbIdx = await battleNet
          .wow
          .mythicKeystoneLeaderboard
          .getMythicKeystoneLeaderboardsIndex(
            accessToken: token,
            region: region,
            locale: locale,
            connectedRealmId: 1301,
          );
      expect(lbIdx.currentLeaderboards, isNotEmpty);

      final MythicKeystonePeriodsIndexResponse periods = await battleNet
          .getMythicKeystonePeriodsIndex(
            accessToken: token,
            region: region,
            namespace: BattleNetNamespace.dynamic,
            locale: locale,
          );
      final MythicKeystoneLeaderboardResponse lb = await battleNet
          .wow
          .mythicKeystoneLeaderboard
          .getMythicKeystoneLeaderboard(
            accessToken: token,
            region: region,
            locale: locale,
            connectedRealmId: 1301,
            dungeonId: lbIdx.currentLeaderboards.first.id!,
            period: periods.currentPeriod.id,
          );
      expect(lb.period, periods.currentPeriod.id);

      final MythicRaidLeaderboardResponse raidLb = await battleNet
          .wow
          .mythicRaidLeaderboard
          .getMythicRaidLeaderboard(
            accessToken: token,
            region: region,
            locale: locale,
            raid: 'uldir',
            faction: BattleNetFaction.alliance,
          );
      expect(raidLb.entries, isNotEmpty);
    });

    test('Auction House API', () async {
      final AuctionsResponse ah = await battleNet.wow.auctionHouse.getAuctions(
        accessToken: token,
        region: region,
        locale: locale,
        connectedRealmId: 1301,
      );
      expect(ah.auctions, isNotEmpty);
    });
  });
}
