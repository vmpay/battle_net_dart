import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('Batch B clients & models Unit Tests', () {
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

    test('Achievement', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/achievement-category/index':
            '{"categories":[{"id":81}],"root_categories":[{"id":92}],"guild_categories":[{"id":15077}]}',
        '/data/wow/achievement-category/81':
            '{"id":81,"name":"Feats","is_guild_category":false,"display_order":10,"achievements":[{"id":6}],"subcategories":[{"id":82}]}',
        '/data/wow/achievement/index': '{"achievements":[{"id":6}]}',
        '/data/wow/achievement/6':
            '{"id":6,"name":"Level 10","description":"Reach 10","points":10,"is_account_wide":true,"category":{"id":81},"next_achievement":{"id":7},"media":{"id":6}}',
        '/data/wow/media/achievement/6':
            '{"id":6,"assets":[{"key":"icon","value":"https://a"}]}',
      });

      final AchievementCategoriesIndexResponse cats = await bn.wow.achievement
          .getAchievementCategoriesIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(cats.categories.single.id, 81);
      expect(cats.rootCategories.single.id, 92);
      expect(cats.guildCategories.single.id, 15077);

      final AchievementCategoryResponse cat = await bn.wow.achievement
          .getAchievementCategory(
            accessToken: token,
            region: region,
            locale: locale,
            achievementCategoryId: 81,
          );
      expect(cat.id, 81);
      expect(cat.name, 'Feats');
      expect(cat.isGuildCategory, isFalse);
      expect(cat.displayOrder, 10);
      expect(cat.achievements.single.id, 6);
      expect(cat.subcategories.single.id, 82);

      expect(
        (await bn.wow.achievement.getAchievementsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).achievements.single.id,
        6,
      );

      final AchievementResponse ach = await bn.wow.achievement.getAchievement(
        accessToken: token,
        region: region,
        locale: locale,
        achievementId: 6,
      );
      expect(ach.id, 6);
      expect(ach.name, 'Level 10');
      expect(ach.description, 'Reach 10');
      expect(ach.points, 10);
      expect(ach.isAccountWide, isTrue);
      expect(ach.category?.id, 81);
      expect(ach.nextAchievement?.id, 7);
      expect(ach.mediaId, 6);

      expect(
        (await bn.wow.achievement.getAchievementMedia(
          accessToken: token,
          region: region,
          locale: locale,
          achievementId: 6,
        )).id,
        6,
      );
    });

    test('Creature', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/creature-family/index': '{"creature_families":[{"id":1}]}',
        '/data/wow/creature-family/1':
            '{"id":1,"name":"Wolf","specialization":{"id":74},"media":{"id":1}}',
        '/data/wow/media/creature-family/1': '{"id":1,"assets":[]}',
        '/data/wow/creature-type/index': '{"creature_types":[{"id":1}]}',
        '/data/wow/creature-type/1': '{"id":1,"name":"Beast"}',
        '/data/wow/creature/42722':
            '{"id":42722,"name":"Hogger","type":{"id":7},"family":{"id":1},"is_tameable":false,"creature_displays":[{"id":30221}]}',
        '/data/wow/media/creature-display/30221': '{"id":30221,"assets":[]}',
        '/data/wow/search/creature': '{"page":1,"results":[{"data":{"id":1}}]}',
      });

      expect(
        (await bn.wow.creature.getCreatureFamiliesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).creatureFamilies.single.id,
        1,
      );
      final CreatureFamilyResponse fam = await bn.wow.creature
          .getCreatureFamily(
            accessToken: token,
            region: region,
            locale: locale,
            creatureFamilyId: 1,
          );
      expect(fam.id, 1);
      expect(fam.name, 'Wolf');
      expect(fam.specialization?.id, 74);
      expect(fam.mediaId, 1);
      expect(
        (await bn.wow.creature.getCreatureFamilyMedia(
          accessToken: token,
          region: region,
          locale: locale,
          creatureFamilyId: 1,
        )).id,
        1,
      );
      expect(
        (await bn.wow.creature.getCreatureTypesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).creatureTypes.single.id,
        1,
      );
      final CreatureTypeResponse cType = await bn.wow.creature.getCreatureType(
        accessToken: token,
        region: region,
        locale: locale,
        creatureTypeId: 1,
      );
      expect(cType.id, 1);
      expect(cType.name, 'Beast');

      final CreatureResponse cr = await bn.wow.creature.getCreature(
        accessToken: token,
        region: region,
        locale: locale,
        creatureId: 42722,
      );
      expect(cr.id, 42722);
      expect(cr.name, 'Hogger');
      expect(cr.type?.id, 7);
      expect(cr.family?.id, 1);
      expect(cr.isTameable, isFalse);
      expect(cr.creatureDisplays.single.id, 30221);

      expect(
        (await bn.wow.creature.getCreatureDisplayMedia(
          accessToken: token,
          region: region,
          locale: locale,
          creatureDisplayId: 30221,
        )).id,
        30221,
      );
      expect(
        (await bn.wow.creature.searchCreatures(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        1,
      );
    });

    test('Journal, Mount, Pet', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/journal-expansion/index': '{"tiers":[{"id":68}]}',
        '/data/wow/journal-expansion/68':
            '{"id":68,"name":"Classic","dungeons":[{"id":63}],"raids":[{"id":741}]}',
        '/data/wow/journal-encounter/index': '{"encounters":[{"id":89}]}',
        '/data/wow/journal-encounter/89':
            '{"id":89,"name":"Glubtok","description":"Desc","instance":{"id":63},"category":{"type":"BOSS"}}',
        '/data/wow/search/journal-encounter':
            '{"page":1,"results":[{"data":{"id":89}}]}',
        '/data/wow/journal-instance/index': '{"instances":[{"id":63}]}',
        '/data/wow/journal-instance/63':
            '{"id":63,"name":"Deadmines","description":"D","minimum_level":10,"expansion":{"id":68},"encounters":[{"id":89}],"category":{"type":"DUNGEON"}}',
        '/data/wow/media/journal-instance/63': '{"assets":[]}',
        '/data/wow/mount/index': '{"mounts":[{"id":6}]}',
        '/data/wow/mount/6':
            '{"id":6,"name":"Brown Horse","description":"Ride","source":{"type":"VENDOR"},"faction":{"type":"ALLIANCE"},"creature_displays":[{"id":1}]}',
        '/data/wow/search/mount': '{"page":1,"results":[{"data":{"id":6}}]}',
        '/data/wow/pet/index': '{"pets":[{"id":39}]}',
        '/data/wow/pet/39':
            '{"id":39,"name":"Squirrel","description":"Desc","battle_pet_type":{"type":"CRITTER"},"is_capturable":true,"is_tradable":true,"is_battlepet":true,"is_alliance_only":false,"is_horde_only":false,"media":{"id":39}}',
        '/data/wow/media/pet/39': '{"id":39,"assets":[]}',
        '/data/wow/pet-ability/index': '{"abilities":[{"id":110}]}',
        '/data/wow/pet-ability/110':
            '{"id":110,"name":"Bite","battle_pet_type":{"type":"BEAST"},"rounds":1,"media":{"id":110}}',
        '/data/wow/media/pet-ability/110': '{"id":110,"assets":[]}',
      });

      expect(
        (await bn.wow.journal.getJournalExpansionsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).tiers.single.id,
        68,
      );
      final JournalExpansionResponse exp = await bn.wow.journal
          .getJournalExpansion(
            accessToken: token,
            region: region,
            locale: locale,
            journalExpansionId: 68,
          );
      expect(exp.id, 68);
      expect(exp.name, 'Classic');
      expect(exp.dungeons.single.id, 63);
      expect(exp.raids.single.id, 741);

      expect(
        (await bn.wow.journal.getJournalEncountersIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).encounters.single.id,
        89,
      );
      final JournalEncounterResponse enc = await bn.wow.journal
          .getJournalEncounter(
            accessToken: token,
            region: region,
            locale: locale,
            journalEncounterId: 89,
          );
      expect(enc.id, 89);
      expect(enc.name, 'Glubtok');
      expect(enc.description, 'Desc');
      expect(enc.instance?.id, 63);
      expect(enc.category, 'BOSS');
      expect(
        (await bn.wow.journal.searchJournalEncounters(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        89,
      );
      expect(
        (await bn.wow.journal.getJournalInstancesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).instances.single.id,
        63,
      );
      final JournalInstanceResponse inst = await bn.wow.journal
          .getJournalInstance(
            accessToken: token,
            region: region,
            locale: locale,
            journalInstanceId: 63,
          );
      expect(inst.id, 63);
      expect(inst.name, 'Deadmines');
      expect(inst.description, 'D');
      expect(inst.minimumLevel, 10);
      expect(inst.expansion?.id, 68);
      expect(inst.encounters.single.id, 89);
      expect(inst.category, 'DUNGEON');
      expect(
        (await bn.wow.journal.getJournalInstanceMedia(
          accessToken: token,
          region: region,
          locale: locale,
          journalInstanceId: 63,
        )).assets,
        isEmpty,
      );

      expect(
        (await bn.wow.mount.getMountsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).mounts.single.id,
        6,
      );
      final MountResponse mount = await bn.wow.mount.getMount(
        accessToken: token,
        region: region,
        locale: locale,
        mountId: 6,
      );
      expect(mount.id, 6);
      expect(mount.name, 'Brown Horse');
      expect(mount.description, 'Ride');
      expect(mount.source, 'VENDOR');
      expect(mount.faction, 'ALLIANCE');
      expect(mount.creatureDisplays.single.id, 1);
      expect(
        (await bn.wow.mount.searchMounts(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        6,
      );

      expect(
        (await bn.wow.pet.getPetsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).pets.single.id,
        39,
      );
      final PetResponse pet = await bn.wow.pet.getPet(
        accessToken: token,
        region: region,
        locale: locale,
        petId: 39,
      );
      expect(pet.id, 39);
      expect(pet.name, 'Squirrel');
      expect(pet.description, 'Desc');
      expect(pet.battlePetType, 'CRITTER');
      expect(pet.isCapturable, isTrue);
      expect(pet.isTradable, isTrue);
      expect(pet.isBattlepet, isTrue);
      expect(pet.isAllianceOnly, isFalse);
      expect(pet.isHordeOnly, isFalse);
      expect(pet.mediaId, 39);
      expect(
        (await bn.wow.pet.getPetMedia(
          accessToken: token,
          region: region,
          locale: locale,
          petId: 39,
        )).id,
        39,
      );
      expect(
        (await bn.wow.pet.getPetAbilitiesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).abilities.single.id,
        110,
      );
      final PetAbilityResponse petAb = await bn.wow.pet.getPetAbility(
        accessToken: token,
        region: region,
        locale: locale,
        petAbilityId: 110,
      );
      expect(petAb.id, 110);
      expect(petAb.name, 'Bite');
      expect(petAb.battlePetType, 'BEAST');
      expect(petAb.rounds, 1);
      expect(petAb.mediaId, 110);
      expect(
        (await bn.wow.pet.getPetAbilityMedia(
          accessToken: token,
          region: region,
          locale: locale,
          petAbilityId: 110,
        )).id,
        110,
      );
    });

    test('Playable Class, Race, Specialization', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/playable-class/index': '{"classes":[{"id":1}]}',
        '/data/wow/playable-class/1':
            '{"id":1,"name":"Warrior","power_type":{"id":1},"specializations":[{"id":71}],"playable_races":[{"id":1}],"media":{"id":1}}',
        '/data/wow/media/playable-class/1': '{"id":1,"assets":[]}',
        '/data/wow/playable-class/1/pvp-talent-slots':
            '{"talent_slots":[{"slot_number":1,"unlock_player_level":20}]}',
        '/data/wow/playable-race/index': '{"races":[{"id":1}]}',
        '/data/wow/playable-race/1':
            '{"id":1,"name":"Human","faction":{"type":"ALLIANCE"},"is_selectable":true,"is_allied_race":false,"playable_classes":[{"id":1}]}',
        '/data/wow/playable-specialization/index':
            '{"character_specializations":[{"id":262}],"pet_specializations":[{"id":74}]}',
        '/data/wow/playable-specialization/262':
            '{"id":262,"name":"Elemental","playable_class":{"id":7},"role":{"type":"DAMAGE"},"power_type":{"id":0},"spec_talent_tree":{"id":774},"media":{"id":262}}',
        '/data/wow/media/playable-specialization/262': '{"id":262,"assets":[]}',
      });

      expect(
        (await bn.wow.playableClass.getPlayableClassesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).classes.single.id,
        1,
      );
      final PlayableClassResponse cls = await bn.wow.playableClass
          .getPlayableClass(
            accessToken: token,
            region: region,
            locale: locale,
            classId: 1,
          );
      expect(cls.id, 1);
      expect(cls.name, 'Warrior');
      expect(cls.powerType?.id, 1);
      expect(cls.specializations.single.id, 71);
      expect(cls.playableRaces.single.id, 1);
      expect(cls.mediaId, 1);
      expect(
        (await bn.wow.playableClass.getPlayableClassMedia(
          accessToken: token,
          region: region,
          locale: locale,
          classId: 1,
        )).id,
        1,
      );
      final PvpTalentSlotsResponse slots = await bn.wow.playableClass
          .getPvpTalentSlots(
            accessToken: token,
            region: region,
            locale: locale,
            classId: 1,
          );
      expect(slots.talentSlots.single.slotNumber, 1);
      expect(slots.talentSlots.single.unlockPlayerLevel, 20);

      expect(
        (await bn.wow.playableRace.getPlayableRacesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).races.single.id,
        1,
      );
      final PlayableRaceResponse race = await bn.wow.playableRace
          .getPlayableRace(
            accessToken: token,
            region: region,
            locale: locale,
            raceId: 1,
          );
      expect(race.id, 1);
      expect(race.name, 'Human');
      expect(race.faction, 'ALLIANCE');
      expect(race.isSelectable, isTrue);
      expect(race.isAlliedRace, isFalse);
      expect(race.playableClasses.single.id, 1);

      final PlayableSpecializationsIndexResponse specs = await bn
          .wow
          .playableSpecialization
          .getPlayableSpecializationsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(specs.characterSpecializations.single.id, 262);
      expect(specs.petSpecializations.single.id, 74);

      final PlayableSpecializationResponse spec = await bn
          .wow
          .playableSpecialization
          .getPlayableSpecialization(
            accessToken: token,
            region: region,
            locale: locale,
            specId: 262,
          );
      expect(spec.id, 262);
      expect(spec.name, 'Elemental');
      expect(spec.playableClass?.id, 7);
      expect(spec.role, 'DAMAGE');
      expect(spec.powerType?.id, 0);
      expect(spec.specTalentTree?.id, 774);
      expect(spec.mediaId, 262);
      expect(
        (await bn.wow.playableSpecialization.getPlayableSpecializationMedia(
          accessToken: token,
          region: region,
          locale: locale,
          specId: 262,
        )).id,
        262,
      );
    });

    test('PvP Season, PvP Tier, Quest, Spell, Talent', () async {
      final BattleNet bn = makeFacade(<String, String>{
        '/data/wow/pvp-season/index':
            '{"seasons":[{"id":38}],"current_season":{"id":38}}',
        '/data/wow/pvp-season/38':
            '{"id":38,"season_name":"S38","season_start_timestamp":1,"season_end_timestamp":2,"leaderboards":{"href":"https://lb"},"rewards":{"href":"https://rw"}}',
        '/data/wow/pvp-season/38/pvp-leaderboard/index':
            '{"leaderboards":[{"id":1,"name":"3v3"}]}',
        '/data/wow/pvp-season/38/pvp-leaderboard/3v3':
            '{"name":"3v3","bracket":{"type":"ARENA_3v3"},"season":{"id":38},"entries":[{"rank":1,"rating":3000,"character":{"id":10,"name":"P"},"faction":{"type":"ALLIANCE"}}]}',
        '/data/wow/pvp-season/38/pvp-reward/index':
            '{"rewards":[{"bracket":{"type":"ARENA_3v3"}}]}',
        '/data/wow/pvp-tier/index': '{"tiers":[{"id":1}]}',
        '/data/wow/pvp-tier/1':
            '{"id":1,"name":"Combatant","min_rating":1000,"max_rating":1199,"bracket":{"type":"ARENA_2v2"},"rating_type":"1","media":{"id":1}}',
        '/data/wow/media/pvp-tier/1': '{"id":1,"assets":[]}',
        '/data/wow/quest/index':
            '{"categories":{"href":"https://c"},"areas":{"href":"https://a"},"types":{"href":"https://t"}}',
        '/data/wow/quest/2':
            '{"id":2,"title":"Sharptalon","description":"Kill","area":{"id":1}}',
        '/data/wow/quest/category/index': '{"categories":[{"id":1}]}',
        '/data/wow/quest/category/1':
            '{"id":1,"category":"Zone","quests":[{"id":2}]}',
        '/data/wow/quest/area/index': '{"areas":[{"id":1}]}',
        '/data/wow/quest/area/1':
            '{"id":1,"area":"Ashenvale","quests":[{"id":2}]}',
        '/data/wow/quest/type/index': '{"types":[{"id":1}]}',
        '/data/wow/quest/type/1': '{"id":1,"type":"Group","quests":[{"id":2}]}',
        '/data/wow/spell/196607':
            '{"id":196607,"name":"Eye of Tyr","description":"Hit","media":{"id":196607}}',
        '/data/wow/media/spell/196607': '{"id":196607,"assets":[]}',
        '/data/wow/search/spell':
            '{"page":1,"results":[{"data":{"id":196607}}]}',
        '/data/wow/talent-tree/index':
            '{"spec_talent_trees":[{"id":774}],"class_talent_trees":[{"id":1}],"hero_talent_trees":[{"id":2}]}',
        '/data/wow/talent-tree/774/playable-specialization/254':
            '{"id":774,"name":"MM","playable_class":{"id":3},"playable_specialization":{"id":254}}',
        '/data/wow/talent-tree/774': '{"id":774}',
        '/data/wow/talent/index': '{"talents":[{"id":117163}]}',
        '/data/wow/talent/117163':
            '{"id":117163,"spell":{"id":1},"playable_class":{"id":3},"playable_specialization":{"id":254}}',
        '/data/wow/pvp-talent/index': '{"pvp_talents":[{"id":40}]}',
        '/data/wow/pvp-talent/40':
            '{"id":40,"spell":{"id":2},"playable_specialization":{"id":254},"description":"PvP","unlock_player_level":20}',
      });

      final PvpSeasonsIndexResponse pvpIdx = await bn.wow.pvpSeason
          .getPvpSeasonsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(pvpIdx.seasons.single.id, 38);
      expect(pvpIdx.currentSeasonId, 38);

      final PvpSeasonResponse pvpS = await bn.wow.pvpSeason.getPvpSeason(
        accessToken: token,
        region: region,
        locale: locale,
        pvpSeasonId: 38,
      );
      expect(pvpS.id, 38);
      expect(pvpS.seasonName, 'S38');
      expect(pvpS.seasonStartTimestamp, 1);
      expect(pvpS.seasonEndTimestamp, 2);
      expect(pvpS.leaderboardsHref, 'https://lb');
      expect(pvpS.rewardsHref, 'https://rw');

      expect(
        (await bn.wow.pvpSeason.getPvpLeaderboardsIndex(
          accessToken: token,
          region: region,
          locale: locale,
          pvpSeasonId: 38,
        )).leaderboards.single.name,
        '3v3',
      );
      final PvpLeaderboardResponse pvpLb = await bn.wow.pvpSeason
          .getPvpLeaderboard(
            accessToken: token,
            region: region,
            locale: locale,
            pvpSeasonId: 38,
            pvpBracket: '3v3',
          );
      expect(pvpLb.name, '3v3');
      expect(pvpLb.bracketType, 'ARENA_3v3');
      expect(pvpLb.seasonId, 38);
      expect(pvpLb.entries.single.rank, 1);
      expect(pvpLb.entries.single.rating, 3000);
      expect(pvpLb.entries.single.characterName, 'P');
      expect(pvpLb.entries.single.characterId, 10);
      expect(pvpLb.entries.single.faction, 'ALLIANCE');

      expect(
        (await bn.wow.pvpSeason.getPvpRewardsIndex(
          accessToken: token,
          region: region,
          locale: locale,
          pvpSeasonId: 38,
        )).rewards.length,
        1,
      );

      expect(
        (await bn.wow.pvpTier.getPvpTiersIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).tiers.single.id,
        1,
      );
      final PvpTierResponse pvpT = await bn.wow.pvpTier.getPvpTier(
        accessToken: token,
        region: region,
        locale: locale,
        pvpTierId: 1,
      );
      expect(pvpT.id, 1);
      expect(pvpT.name, 'Combatant');
      expect(pvpT.minRating, 1000);
      expect(pvpT.maxRating, 1199);
      expect(pvpT.bracket, 'ARENA_2v2');
      expect(pvpT.ratingType, '1');
      expect(pvpT.mediaId, 1);
      expect(
        (await bn.wow.pvpTier.getPvpTierMedia(
          accessToken: token,
          region: region,
          locale: locale,
          pvpTierId: 1,
        )).id,
        1,
      );

      final QuestsIndexResponse qIdx = await bn.wow.quest.getQuestsIndex(
        accessToken: token,
        region: region,
        locale: locale,
      );
      expect(qIdx.categoriesHref, 'https://c');
      expect(qIdx.areasHref, 'https://a');
      expect(qIdx.typesHref, 'https://t');

      final QuestResponse q = await bn.wow.quest.getQuest(
        accessToken: token,
        region: region,
        locale: locale,
        questId: 2,
      );
      expect(q.id, 2);
      expect(q.title, 'Sharptalon');
      expect(q.description, 'Kill');
      expect(q.area?.id, 1);

      expect(
        (await bn.wow.quest.getQuestCategoriesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).categories.single.id,
        1,
      );
      final QuestCategoryResponse qCat = await bn.wow.quest.getQuestCategory(
        accessToken: token,
        region: region,
        locale: locale,
        questCategoryId: 1,
      );
      expect(qCat.id, 1);
      expect(qCat.category, 'Zone');
      expect(qCat.quests.single.id, 2);

      expect(
        (await bn.wow.quest.getQuestAreasIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).areas.single.id,
        1,
      );
      final QuestAreaResponse qArea = await bn.wow.quest.getQuestArea(
        accessToken: token,
        region: region,
        locale: locale,
        questAreaId: 1,
      );
      expect(qArea.id, 1);
      expect(qArea.area, 'Ashenvale');
      expect(qArea.quests.single.id, 2);

      expect(
        (await bn.wow.quest.getQuestTypesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).types.single.id,
        1,
      );
      final QuestTypeResponse qType = await bn.wow.quest.getQuestType(
        accessToken: token,
        region: region,
        locale: locale,
        questTypeId: 1,
      );
      expect(qType.id, 1);
      expect(qType.type, 'Group');
      expect(qType.quests.single.id, 2);

      final SpellResponse spl = await bn.wow.spell.getSpell(
        accessToken: token,
        region: region,
        locale: locale,
        spellId: 196607,
      );
      expect(spl.id, 196607);
      expect(spl.name, 'Eye of Tyr');
      expect(spl.description, 'Hit');
      expect(spl.mediaId, 196607);
      expect(
        (await bn.wow.spell.getSpellMedia(
          accessToken: token,
          region: region,
          locale: locale,
          spellId: 196607,
        )).id,
        196607,
      );
      expect(
        (await bn.wow.spell.searchSpells(
          accessToken: token,
          region: region,
          locale: locale,
        )).results.single.id,
        196607,
      );

      final TalentTreesIndexResponse ttIdx = await bn.wow.talent
          .getTalentTreesIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(ttIdx.specTalentTrees.single.id, 774);
      expect(ttIdx.classTalentTrees.single.id, 1);
      expect(ttIdx.heroTalentTrees.single.id, 2);

      final TalentTreeResponse tt = await bn.wow.talent.getTalentTree(
        accessToken: token,
        region: region,
        locale: locale,
        talentTreeId: 774,
        specId: 254,
      );
      expect(tt.id, 774);
      expect(tt.name, 'MM');
      expect(tt.playableClass?.id, 3);
      expect(tt.playableSpecialization?.id, 254);

      expect(
        (await bn.wow.talent.getTalentTreeNodes(
          accessToken: token,
          region: region,
          locale: locale,
          talentTreeId: 774,
        )).id,
        774,
      );
      expect(
        (await bn.wow.talent.getTalentsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).talents.single.id,
        117163,
      );
      final TalentResponse tal = await bn.wow.talent.getTalent(
        accessToken: token,
        region: region,
        locale: locale,
        talentId: 117163,
      );
      expect(tal.id, 117163);
      expect(tal.spell?.id, 1);
      expect(tal.playableClass?.id, 3);
      expect(tal.playableSpecialization?.id, 254);

      expect(
        (await bn.wow.talent.getPvpTalentsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).pvpTalents.single.id,
        40,
      );
      final PvpTalentResponse pTal = await bn.wow.talent.getPvpTalent(
        accessToken: token,
        region: region,
        locale: locale,
        pvpTalentId: 40,
      );
      expect(pTal.id, 40);
      expect(pTal.spell?.id, 2);
      expect(pTal.playableSpecialization?.id, 254);
      expect(pTal.description, 'PvP');
      expect(pTal.unlockPlayerLevel, 20);
    });
  });
}
