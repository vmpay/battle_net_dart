import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('Batch A clients & BattleNet.wow Unit Tests', () {
    const String token = 'tok';
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    BattleNet makeFacade(
      Map<String, String> responses, {
      int statusCode = 200,
    }) => BattleNet(
      clientId: 'id',
      clientSecret: 'secret',
      logLevel: LogLevel.NONE,
      httpClient: MockClient((http.Request req) async {
        final String? body = responses[req.url.path];
        if (body == null) {
          return http.Response(
            '{"code":404,"type":"BLZWEBAPI00000404","detail":"Not Found"}',
            404,
          );
        }
        return http.Response(body, statusCode);
      }),
    );

    test('Realm, ConnectedRealm index, Region', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/realm/index': '{"realms":[{"id":1,"name":"Ravencrest"}]}',
        '/data/wow/realm/ravencrest':
            '{"id":1,"name":"Ravencrest","slug":"ravencrest","category":"English",'
            '"locale":"enGB","timezone":"Europe/Paris","type":{"type":"NORMAL"},'
            '"is_tournament":false,"region":{"id":3,"name":"Europe"},'
            '"connected_realm":{"href":"https://eu.api.blizzard.com/data/wow/connected-realm/1329"}}',
        '/data/wow/search/realm':
            '{"page":1,"pageSize":1,"maxPageSize":100,"pageCount":1,"results":[{"data":{"id":1}}]}',
        '/data/wow/connected-realm/index':
            '{"connected_realms":[{"href":"https://eu.api.blizzard.com/data/wow/connected-realm/1301"}]}',
        '/data/wow/region/index':
            '{"regions":[{"href":"https://eu.api.blizzard.com/data/wow/region/3"}]}',
        '/data/wow/region/3':
            '{"id":3,"name":"Europe","tag":"EU","patch_string":"11.0"}',
      });

      final RealmsIndexResponse idx = await bn.wow.realm.getRealmsIndex(
        accessToken: token,
        region: region,
        locale: locale,
      );
      expect(idx.realms.single.name, 'Ravencrest');

      final RealmResponse realm = await bn.wow.realm.getRealm(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: 'ravencrest',
      );
      expect(realm.id, 1);
      expect(realm.slug, 'ravencrest');
      expect(realm.category, 'English');
      expect(realm.locale, 'enGB');
      expect(realm.timezone, 'Europe/Paris');
      expect(realm.type, 'NORMAL');
      expect(realm.isTournament, isFalse);
      expect(realm.region?.id, 3);
      expect(realm.connectedRealmHref, contains('1329'));

      final SearchResponse search = await bn.wow.realm.searchRealms(
        accessToken: token,
        region: region,
        locale: locale,
        pageSize: 1,
        filters: <String, String>{'timezone': 'Europe/Paris'},
      );
      expect(search.results.single.id, 1);

      final ConnectedRealmsIndexResponse crIdx = await bn.wow.connectedRealm
          .getConnectedRealmsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(crIdx.connectedRealmIds, <int>[1301]);

      final RegionsIndexResponse regIdx = await bn.wow.region.getRegionsIndex(
        accessToken: token,
        region: region,
        locale: locale,
      );
      expect(regIdx.regionHrefs.length, 1);

      final RegionResponse reg = await bn.wow.region.getRegion(
        accessToken: token,
        region: region,
        locale: locale,
        regionId: 3,
      );
      expect(reg.tag, 'EU');
      expect(reg.patchString, '11.0');
    });

    test('AuctionHouse', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/connected-realm/1301/auctions':
            '{"connected_realm":{"href":"https://cr/1301"},"auctions":[{"id":1,"item":{"id":19019},"quantity":1,"buyout":100,"bid":50,"unit_price":100,"time_left":"LONG"}]}',
        '/data/wow/auctions/commodities':
            '{"auctions":[{"id":2,"item":{"id":200},"quantity":5,"unit_price":10,"time_left":"SHORT"}]}',
      });

      final AuctionsResponse ah = await bn.wow.auctionHouse.getAuctions(
        accessToken: token,
        region: region,
        locale: locale,
        connectedRealmId: 1301,
      );
      expect(ah.connectedRealmHref, 'https://cr/1301');
      expect(ah.auctions.single.itemId, 19019);
      expect(ah.auctions.single.buyout, 100);
      expect(ah.auctions.single.bid, 50);
      expect(ah.auctions.single.unitPrice, 100);
      expect(ah.auctions.single.quantity, 1);
      expect(ah.auctions.single.timeLeft, 'LONG');
      expect(ah.auctions.single.id, 1);

      final AuctionsResponse comm = await bn.wow.auctionHouse.getCommodities(
        accessToken: token,
        region: region,
        locale: locale,
      );
      expect(comm.connectedRealmHref, isNull);
      expect(comm.auctions.single.itemId, 200);
    });

    test('Item', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/item-class/index':
            '{"item_classes":[{"id":2,"name":"Weapon"}]}',
        '/data/wow/item-class/2':
            '{"id":2,"name":"Weapon","item_subclasses":[{"id":7,"name":"Sword"}]}',
        '/data/wow/item-class/2/item-subclass/7':
            '{"id":7,"display_name":"One-Handed Swords","verbose_name":"One-Handed Swords","item_class":{"id":2}}',
        '/data/wow/item-set/index': '{"item_sets":[{"id":1,"name":"Set"}]}',
        '/data/wow/item-set/1':
            '{"id":1,"name":"Set","items":[{"id":19019,"name":"Thunderfury"}]}',
        '/data/wow/item/19019':
            '{"id":19019,"name":"Thunderfury","quality":{"type":"LEGENDARY"},"level":80,"required_level":60,"item_class":{"id":2},"item_subclass":{"id":7},"inventory_type":{"type":"ONEHAND"},"purchase_price":1,"sell_price":2,"max_count":1,"is_equippable":true,"is_stackable":false,"media":{"id":19019}}',
        '/data/wow/media/item/19019':
            '{"id":19019,"assets":[{"key":"icon","value":"https://icon","file_data_id":1}]}',
        '/data/wow/search/item':
            '{"page":1,"pageSize":1,"maxPageSize":100,"pageCount":1,"results":[{"data":{"id":19019}}]}',
      });

      expect(
        (await bn.wow.item.getItemClassesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).itemClasses.single.id,
        2,
      );
      expect(
        (await bn.wow.item.getItemClass(
          accessToken: token,
          region: region,
          locale: locale,
          itemClassId: 2,
        )).itemSubclasses.single.id,
        7,
      );
      final ItemSubclassResponse sub = await bn.wow.item.getItemSubclass(
        accessToken: token,
        region: region,
        locale: locale,
        itemClassId: 2,
        itemSubclassId: 7,
      );
      expect(sub.displayName, 'One-Handed Swords');
      expect(sub.verboseName, 'One-Handed Swords');
      expect(sub.itemClass?.id, 2);
      expect(sub.id, 7);

      expect(
        (await bn.wow.item.getItemSetsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).itemSets.single.id,
        1,
      );
      final ItemSetResponse itemSet = await bn.wow.item.getItemSet(
        accessToken: token,
        region: region,
        locale: locale,
        itemSetId: 1,
      );
      expect(itemSet.name, 'Set');
      expect(itemSet.items.single.id, 19019);

      final ItemResponse item = await bn.wow.item.getItem(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
      );
      expect(item.quality, 'LEGENDARY');
      expect(item.level, 80);
      expect(item.requiredLevel, 60);
      expect(item.itemClass?.id, 2);
      expect(item.itemSubclass?.id, 7);
      expect(item.inventoryType, 'ONEHAND');
      expect(item.purchasePrice, 1);
      expect(item.sellPrice, 2);
      expect(item.maxCount, 1);
      expect(item.isEquippable, isTrue);
      expect(item.isStackable, isFalse);
      expect(item.mediaId, 19019);

      expect(
        (await bn.wow.item.getItemMedia(
          accessToken: token,
          region: region,
          locale: locale,
          itemId: 19019,
        )).assets.single.key,
        'icon',
      );
      expect(
        (await bn.wow.item.searchItems(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        19019,
      );
    });

    test('Profession', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/profession/index':
            '{"professions":[{"id":164,"name":"Blacksmithing"}]}',
        '/data/wow/profession/164':
            '{"id":164,"name":"Blacksmithing","description":"Forge","type":{"type":"PRIMARY"},"skill_tiers":[{"id":2437}],"media":{"id":164}}',
        '/data/wow/media/profession/164':
            '{"id":164,"assets":[{"key":"icon","value":"https://p"}]}',
        '/data/wow/profession/164/skill-tier/2437':
            '{"id":2437,"name":"Classic","minimum_skill_level":1,"maximum_skill_level":300,"categories":[{"name":"Swords","recipes":[{"id":38729}]}]}',
        '/data/wow/recipe/38729':
            '{"id":38729,"name":"Sword","description":"Craft","crafted_item":{"id":100},"media":{"id":38729}}',
        '/data/wow/media/recipe/38729':
            '{"id":38729,"assets":[{"key":"icon","value":"https://r"}]}',
      });

      expect(
        (await bn.wow.profession.getProfessionsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).professions.single.id,
        164,
      );
      final ProfessionResponse prof = await bn.wow.profession.getProfession(
        accessToken: token,
        region: region,
        locale: locale,
        professionId: 164,
      );
      expect(prof.description, 'Forge');
      expect(prof.type, 'PRIMARY');
      expect(prof.skillTiers.single.id, 2437);
      expect(prof.mediaId, 164);
      expect(
        (await bn.wow.profession.getProfessionMedia(
          accessToken: token,
          region: region,
          locale: locale,
          professionId: 164,
        )).id,
        164,
      );
      final SkillTierResponse tier = await bn.wow.profession
          .getProfessionSkillTier(
            accessToken: token,
            region: region,
            locale: locale,
            professionId: 164,
            skillTierId: 2437,
          );
      expect(tier.minimumSkillLevel, 1);
      expect(tier.maximumSkillLevel, 300);
      expect(tier.categories.single.name, 'Swords');
      expect(tier.categories.single.recipes.single.id, 38729);
      final RecipeResponse recipe = await bn.wow.profession.getRecipe(
        accessToken: token,
        region: region,
        locale: locale,
        recipeId: 38729,
      );
      expect(recipe.craftedItem?.id, 100);
      expect(recipe.mediaId, 38729);
      expect(
        (await bn.wow.profession.getRecipeMedia(
          accessToken: token,
          region: region,
          locale: locale,
          recipeId: 38729,
        )).id,
        38729,
      );
    });

    test('Mythic Keystone & Raid Leaderboards + existing sub-clients', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/mythic-keystone/index':
            '{"seasons":{"href":"https://s"},"dungeons":{"href":"https://d"}}',
        '/data/wow/mythic-keystone/dungeon/index':
            '{"dungeons":[{"id":56,"name":"Dungeon"}]}',
        '/data/wow/mythic-keystone/dungeon/56':
            '{"id":56,"name":"Dungeon","map":{"id":10},"dungeon":{"id":20},"is_tracked":true,"keystone_upgrades":[{"upgrade_level":1,"qualifying_duration":1800000}]}',
        '/data/wow/mythic-keystone/season/index':
            '{"seasons":[{"id":18}],"current_season":{"id":18}}',
        '/data/wow/mythic-keystone/season/18':
            '{"id":18,"season_name":"S18","start_timestamp":1,"end_timestamp":2,"periods":[{"id":1091}]}',
        '/data/wow/connected-realm/1301/mythic-leaderboard/index':
            '{"current_leaderboards":[{"id":249}]}',
        '/data/wow/connected-realm/1301/mythic-leaderboard/249/period/1091':
            '{"map":{"id":249,"name":"D"},"period":1091,"period_start_timestamp":1,"period_end_timestamp":2,"connected_realm":{"href":"https://cr"},"leading_groups":[{"ranking":1,"duration":100,"completed_timestamp":2,"keystone_level":15,"members":[{"id":1}]}]}',
        '/data/wow/leaderboard/hall-of-fame/uldir/alliance':
            '{"slug":"uldir","criteria_type":"hall-of-fame","entries":[{"rank":1,"timestamp":10,"guild":{"id":1,"name":"Method","realm":{"slug":"tarren-mill"}},"faction":{"type":"ALLIANCE"}}]}',
      });

      final MythicKeystoneIndexResponse mkIdx = await bn
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(mkIdx.seasonsHref, 'https://s');
      expect(mkIdx.dungeonsHref, 'https://d');

      expect(
        (await bn.wow.mythicKeystoneDungeon.getMythicKeystoneDungeonsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).dungeons.single.id,
        56,
      );
      final MythicKeystoneDungeonResponse dungeon = await bn
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneDungeon(
            accessToken: token,
            region: region,
            locale: locale,
            dungeonId: 56,
          );
      expect(dungeon.mapId, 10);
      expect(dungeon.dungeon?.id, 20);
      expect(dungeon.isTracked, isTrue);
      expect(dungeon.keystoneUpgrades.single.upgradeLevel, 1);
      expect(dungeon.keystoneUpgrades.single.qualifyingDuration, 1800000);

      expect(
        (await bn.wow.mythicKeystoneDungeon.getMythicKeystoneSeasonsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).currentSeasonId,
        18,
      );
      final MythicKeystoneSeasonResponse season = await bn
          .wow
          .mythicKeystoneDungeon
          .getMythicKeystoneSeason(
            accessToken: token,
            region: region,
            locale: locale,
            seasonId: 18,
          );
      expect(season.seasonName, 'S18');
      expect(season.startTimestamp, 1);
      expect(season.endTimestamp, 2);
      expect(season.periods.single.id, 1091);

      expect(
        (await bn.wow.mythicKeystoneLeaderboard
                .getMythicKeystoneLeaderboardsIndex(
                  accessToken: token,
                  region: region,
                  locale: locale,
                  connectedRealmId: 1301,
                ))
            .currentLeaderboards
            .single
            .id,
        249,
      );
      final MythicKeystoneLeaderboardResponse lb = await bn
          .wow
          .mythicKeystoneLeaderboard
          .getMythicKeystoneLeaderboard(
            accessToken: token,
            region: region,
            locale: locale,
            connectedRealmId: 1301,
            dungeonId: 249,
            period: 1091,
          );
      expect(lb.dungeonName, 'D');
      expect(lb.mapId, 249);
      expect(lb.period, 1091);
      expect(lb.periodStartTimestamp, 1);
      expect(lb.periodEndTimestamp, 2);
      expect(lb.connectedRealmHref, 'https://cr');
      expect(lb.leadingGroups.single.ranking, 1);
      expect(lb.leadingGroups.single.duration, 100);
      expect(lb.leadingGroups.single.completedTimestamp, 2);
      expect(lb.leadingGroups.single.keystoneLevel, 15);
      expect(lb.leadingGroups.single.members.length, 1);

      final MythicRaidLeaderboardResponse raidLb = await bn
          .wow
          .mythicRaidLeaderboard
          .getMythicRaidLeaderboard(
            accessToken: token,
            region: region,
            locale: locale,
            raid: 'uldir',
            faction: BattleNetFaction.alliance,
          );
      expect(raidLb.slug, 'uldir');
      expect(raidLb.criteriaType, 'hall-of-fame');
      expect(raidLb.entries.single.rank, 1);
      expect(raidLb.entries.single.timestamp, 10);
      expect(raidLb.entries.single.guildName, 'Method');
      expect(raidLb.entries.single.guildId, 1);
      expect(raidLb.entries.single.realmSlug, 'tarren-mill');
      expect(raidLb.entries.single.faction, 'ALLIANCE');

      // Sub-client getters for existing clients are wired up.
      expect(bn.wow.token, isNotNull);
      expect(bn.wow.mythicKeystoneAffix, isNotNull);
      expect(bn.wow.foreverCharacter, isNotNull);
      expect(bn.wow.foreverAccount, isNotNull);
      expect(bn.wow.foreverItem, isNotNull);
      expect(bn.wow.foreverRuleset, isNotNull);

      // Missing path throws BattleNetNotFoundException via doGet.
      expect(
        () => bn.wow.item.getItem(
          accessToken: token,
          region: region,
          locale: locale,
          itemId: 99999999,
        ),
        throwsA(isA<BattleNetNotFoundException>()),
      );
    });
  });
}
