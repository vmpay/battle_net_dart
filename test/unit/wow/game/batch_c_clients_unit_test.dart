import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('Batch C clients & models Unit Tests', () {
    const String token = 'tok';
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    BattleNet makeFacade(Map<String, String> responses) => BattleNet(
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
        return http.Response(body, 200);
      }),
    );

    test('AzeriteEssence, Covenant, GuildCrest', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/azerite-essence/index': '{"azerite_essences":[{"id":16}]}',
        '/data/wow/azerite-essence/16':
            '{"id":16,"name":"Vision","allowed_specializations":[{"id":64}],"media":{"id":16}}',
        '/data/wow/media/azerite-essence/16': '{"id":16,"assets":[]}',
        '/data/wow/search/azerite-essence':
            '{"page":1,"results":[{"data":{"id":16}}]}',
        '/data/wow/covenant/index': '{"covenants":[{"id":1}]}',
        '/data/wow/covenant/1':
            '{"id":1,"name":"Kyrian","description":"Desc","soulbinds":[{"id":4}],"media":{"id":1}}',
        '/data/wow/media/covenant/1': '{"assets":[]}',
        '/data/wow/covenant/soulbind/index': '{"soulbinds":[{"id":4}]}',
        '/data/wow/covenant/soulbind/4':
            '{"id":4,"name":"Pelagos","covenant":{"id":1},"creature":{"id":2},"follower":{"id":3},"talent_tree":{"id":4}}',
        '/data/wow/covenant/conduit/index': '{"conduits":[{"id":19}]}',
        '/data/wow/covenant/conduit/19':
            '{"id":19,"name":"Cond","item":{"id":100},"socket_type":{"type":"POTENCY"}}',
        '/data/wow/guild-crest/index':
            '{"emblems":[{"id":0}],"borders":[{"id":0}]}',
        '/data/wow/media/guild-crest/border/0': '{"id":0,"assets":[]}',
        '/data/wow/media/guild-crest/emblem/0': '{"id":0,"assets":[]}',
      });

      expect(
        (await bn.wow.azeriteEssence.getAzeriteEssencesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).azeriteEssences.single.id,
        16,
      );
      final AzeriteEssenceResponse az = await bn.wow.azeriteEssence
          .getAzeriteEssence(
            accessToken: token,
            region: region,
            locale: locale,
            azeriteEssenceId: 16,
          );
      expect(az.id, 16);
      expect(az.name, 'Vision');
      expect(az.allowedSpecializations.single.id, 64);
      expect(az.mediaId, 16);
      expect(
        (await bn.wow.azeriteEssence.getAzeriteEssenceMedia(
          accessToken: token,
          region: region,
          locale: locale,
          azeriteEssenceId: 16,
        )).id,
        16,
      );
      expect(
        (await bn.wow.azeriteEssence.searchAzeriteEssences(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        16,
      );

      expect(
        (await bn.wow.covenant.getCovenantsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).covenants.single.id,
        1,
      );
      final CovenantResponse cov = await bn.wow.covenant.getCovenant(
        accessToken: token,
        region: region,
        locale: locale,
        covenantId: 1,
      );
      expect(cov.id, 1);
      expect(cov.name, 'Kyrian');
      expect(cov.description, 'Desc');
      expect(cov.soulbinds.single.id, 4);
      expect(cov.mediaId, 1);
      expect(
        (await bn.wow.covenant.getCovenantMedia(
          accessToken: token,
          region: region,
          locale: locale,
          covenantId: 1,
        )).assets,
        isEmpty,
      );
      expect(
        (await bn.wow.covenant.getSoulbindsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).soulbinds.single.id,
        4,
      );
      final SoulbindResponse sb = await bn.wow.covenant.getSoulbind(
        accessToken: token,
        region: region,
        locale: locale,
        soulbindId: 4,
      );
      expect(sb.id, 4);
      expect(sb.name, 'Pelagos');
      expect(sb.covenant?.id, 1);
      expect(sb.creature?.id, 2);
      expect(sb.follower?.id, 3);
      expect(sb.talentTree?.id, 4);
      expect(
        (await bn.wow.covenant.getConduitsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).conduits.single.id,
        19,
      );
      final ConduitResponse cond = await bn.wow.covenant.getConduit(
        accessToken: token,
        region: region,
        locale: locale,
        conduitId: 19,
      );
      expect(cond.id, 19);
      expect(cond.name, 'Cond');
      expect(cond.item?.id, 100);
      expect(cond.socketType, 'POTENCY');

      final GuildCrestComponentsIndexResponse gc = await bn.wow.guildCrest
          .getGuildCrestComponentsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(gc.emblems.single.id, 0);
      expect(gc.borders.single.id, 0);
      expect(
        (await bn.wow.guildCrest.getGuildCrestBorderMedia(
          accessToken: token,
          region: region,
          locale: locale,
          borderId: 0,
        )).id,
        0,
      );
      expect(
        (await bn.wow.guildCrest.getGuildCrestEmblemMedia(
          accessToken: token,
          region: region,
          locale: locale,
          emblemId: 0,
        )).id,
        0,
      );
    });

    test('Heirloom, Media, ModifiedCrafting, PowerType', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/heirloom/index': '{"heirlooms":[{"id":1}]}',
        '/data/wow/heirloom/1':
            '{"id":1,"item":{"id":122245},"source":{"type":"VENDOR"},"source_description":"Vendor","media":{"id":1}}',
        '/data/wow/search/media': '{"page":1,"results":[{"data":{"id":1}}]}',
        '/data/wow/modified-crafting/index':
            '{"categories":{"href":"https://c"},"slot_types":{"href":"https://s"}}',
        '/data/wow/modified-crafting/category/index':
            '{"categories":[{"id":1}]}',
        '/data/wow/modified-crafting/category/1': '{"id":1,"name":"Missive"}',
        '/data/wow/modified-crafting/reagent-slot-type/index':
            '{"slot_types":[{"id":1}]}',
        '/data/wow/modified-crafting/reagent-slot-type/1':
            '{"id":1,"description":"Optional","compatible_categories":[{"id":1}]}',
        '/data/wow/power-type/index': '{"power_types":[{"id":10}]}',
        '/data/wow/power-type/10': '{"id":10,"name":"Runic Power"}',
      });

      expect(
        (await bn.wow.heirloom.getHeirloomsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).heirlooms.single.id,
        1,
      );
      final HeirloomResponse hl = await bn.wow.heirloom.getHeirloom(
        accessToken: token,
        region: region,
        locale: locale,
        heirloomId: 1,
      );
      expect(hl.id, 1);
      expect(hl.item?.id, 122245);
      expect(hl.source, 'VENDOR');
      expect(hl.sourceDescription, 'Vendor');
      expect(hl.mediaId, 1);

      expect(
        (await bn.wow.media.searchMedia(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        1,
      );

      final ModifiedCraftingIndexResponse mcIdx = await bn.wow.modifiedCrafting
          .getModifiedCraftingIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(mcIdx.categoriesHref, 'https://c');
      expect(mcIdx.slotTypesHref, 'https://s');
      expect(
        (await bn.wow.modifiedCrafting.getModifiedCraftingCategoriesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).categories.single.id,
        1,
      );
      final ModifiedCraftingCategoryResponse mcCat = await bn
          .wow
          .modifiedCrafting
          .getModifiedCraftingCategory(
            accessToken: token,
            region: region,
            locale: locale,
            categoryId: 1,
          );
      expect(mcCat.id, 1);
      expect(mcCat.name, 'Missive');
      expect(
        (await bn.wow.modifiedCrafting.getModifiedCraftingReagentSlotTypesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).slotTypes.single.id,
        1,
      );
      final ModifiedCraftingReagentSlotTypeResponse mcSlot = await bn
          .wow
          .modifiedCrafting
          .getModifiedCraftingReagentSlotType(
            accessToken: token,
            region: region,
            locale: locale,
            slotTypeId: 1,
          );
      expect(mcSlot.id, 1);
      expect(mcSlot.description, 'Optional');
      expect(mcSlot.compatibleCategories.single.id, 1);

      expect(
        (await bn.wow.powerType.getPowerTypesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).powerTypes.single.id,
        10,
      );
      final PowerTypeResponse pwr = await bn.wow.powerType.getPowerType(
        accessToken: token,
        region: region,
        locale: locale,
        powerTypeId: 10,
      );
      expect(pwr.id, 10);
      expect(pwr.name, 'Runic Power');
    });

    test('Reputation, TechTalent, Title, Toy', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/reputation-faction/index':
            '{"factions":[{"id":1091}],"root_factions":[{"id":1091}]}',
        '/data/wow/reputation-faction/1091':
            '{"id":1091,"name":"Wyrmrest","description":"Dragons","reputation_tiers":{"id":0}}',
        '/data/wow/reputation-tiers/index': '{"reputation_tiers":[{"id":0}]}',
        '/data/wow/reputation-tiers/0':
            '{"id":0,"tiers":[{"id":7,"name":"Exalted","min_value":42000,"max_value":42999}]}',
        '/data/wow/tech-talent-tree/index': '{"talent_trees":[{"id":31}]}',
        '/data/wow/tech-talent-tree/31':
            '{"id":31,"max_tiers":4,"talents":[{"id":39}]}',
        '/data/wow/tech-talent/index': '{"talents":[{"id":39}]}',
        '/data/wow/tech-talent/39':
            '{"id":39,"name":"Tech","talent_tree":{"id":31},"tier":1,"display_order":2,"media":{"id":39}}',
        '/data/wow/media/tech-talent/39': '{"assets":[]}',
        '/data/wow/title/index': '{"titles":[{"id":140}]}',
        '/data/wow/title/140': '{"id":140,"name":"Bane of the Fallen King"}',
        '/data/wow/toy/index': '{"toys":[{"id":30}]}',
        '/data/wow/toy/30':
            '{"id":30,"item":{"id":43499},"source":{"type":"VENDOR"},"should_exclude_if_uncollected":false,"media":{"id":30}}',
      });

      final ReputationFactionsIndexResponse repFIdx = await bn.wow.reputation
          .getReputationFactionsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(repFIdx.factions.single.id, 1091);
      expect(repFIdx.rootFactions.single.id, 1091);
      final ReputationFactionResponse repF = await bn.wow.reputation
          .getReputationFaction(
            accessToken: token,
            region: region,
            locale: locale,
            reputationFactionId: 1091,
          );
      expect(repF.id, 1091);
      expect(repF.name, 'Wyrmrest');
      expect(repF.description, 'Dragons');
      expect(repF.reputationTiers?.id, 0);
      expect(
        (await bn.wow.reputation.getReputationTiersIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).reputationTiers.single.id,
        0,
      );
      final ReputationTiersResponse repT = await bn.wow.reputation
          .getReputationTiers(
            accessToken: token,
            region: region,
            locale: locale,
            reputationTiersId: 0,
          );
      expect(repT.id, 0);
      expect(repT.tiers.single.id, 7);
      expect(repT.tiers.single.name, 'Exalted');
      expect(repT.tiers.single.minValue, 42000);
      expect(repT.tiers.single.maxValue, 42999);

      expect(
        (await bn.wow.techTalent.getTechTalentTreesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).talentTrees.single.id,
        31,
      );
      final TechTalentTreeResponse ttTree = await bn.wow.techTalent
          .getTechTalentTree(
            accessToken: token,
            region: region,
            locale: locale,
            techTalentTreeId: 31,
          );
      expect(ttTree.id, 31);
      expect(ttTree.maxTiers, 4);
      expect(ttTree.talents.single.id, 39);
      expect(
        (await bn.wow.techTalent.getTechTalentsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).talents.single.id,
        39,
      );
      final TechTalentResponse tt = await bn.wow.techTalent.getTechTalent(
        accessToken: token,
        region: region,
        locale: locale,
        techTalentId: 39,
      );
      expect(tt.id, 39);
      expect(tt.name, 'Tech');
      expect(tt.talentTree?.id, 31);
      expect(tt.tier, 1);
      expect(tt.displayOrder, 2);
      expect(tt.mediaId, 39);
      expect(
        (await bn.wow.techTalent.getTechTalentMedia(
          accessToken: token,
          region: region,
          locale: locale,
          techTalentId: 39,
        )).assets,
        isEmpty,
      );

      expect(
        (await bn.wow.title.getTitlesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).titles.single.id,
        140,
      );
      final TitleResponse title = await bn.wow.title.getTitle(
        accessToken: token,
        region: region,
        locale: locale,
        titleId: 140,
      );
      expect(title.id, 140);
      expect(title.name, 'Bane of the Fallen King');

      expect(
        (await bn.wow.toy.getToysIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).toys.single.id,
        30,
      );
      final ToyResponse toy = await bn.wow.toy.getToy(
        accessToken: token,
        region: region,
        locale: locale,
        toyId: 30,
      );
      expect(toy.id, 30);
      expect(toy.item?.id, 43499);
      expect(toy.source, 'VENDOR');
      expect(toy.shouldExcludeIfUncollected, isFalse);
      expect(toy.mediaId, 30);
    });
  });
}
