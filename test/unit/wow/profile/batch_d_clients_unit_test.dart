import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('Batch D Profile & Guild clients Unit Tests', () {
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

    test(
      'AccountProfileClient (requires user token with wow.profile scope)',
      () async {
        final BattleNet bn = makeFacade(<String, String>{
          '/profile/user/wow':
              '{"id":1,"wow_accounts":[{"id":10,"characters":[{"id":100,"name":"Rinox","level":80,"realm":{"id":1329},"playable_class":{"id":1},"playable_race":{"id":4},"faction":{"type":"ALLIANCE"}}]}]}',
          '/profile/user/wow/protected-character/1329-100':
              '{"id":100,"name":"Rinox","money":99999}',
          '/profile/user/wow/collections':
              '{"pets":{"href":"https://p"},"mounts":{"href":"https://m"},"heirlooms":{"href":"https://h"},"toys":{"href":"https://t"},"transmogs":{"href":"https://x"}}',
          '/profile/user/wow/collections/mounts':
              '{"mounts":[{"mount":{"id":1}}]}',
          '/profile/user/wow/collections/pets':
              '{"pets":[{"id":1}],"unlocked_battle_pet_slots":3}',
          '/profile/user/wow/collections/toys': '{"toys":[{"toy":{"id":1}}]}',
          '/profile/user/wow/collections/heirlooms':
              '{"heirlooms":[{"heirloom":{"id":1}}]}',
          '/profile/user/wow/collections/transmogs':
              '{"appearance_sets":[{"id":1}],"slots":[{"slot":{"type":"HEAD"}}]}',
        });

        final AccountProfileResponse acc = await bn.wow.account
            .getAccountProfile(
              accessToken: token,
              region: region,
              locale: locale,
            );
        expect(acc.id, 1);
        expect(acc.wowAccounts.single.id, 10);
        final AccountCharacterSummary ch =
            acc.wowAccounts.single.characters.single;
        expect(ch.id, 100);
        expect(ch.name, 'Rinox');
        expect(ch.level, 80);
        expect(ch.realm?.id, 1329);
        expect(ch.playableClass?.id, 1);
        expect(ch.playableRace?.id, 4);
        expect(ch.faction, 'ALLIANCE');

        final ProtectedCharacterProfileResponse prot = await bn.wow.account
            .getProtectedCharacterProfile(
              accessToken: token,
              region: region,
              locale: locale,
              realmId: 1329,
              characterId: 100,
            );
        expect(prot.id, 100);
        expect(prot.name, 'Rinox');
        expect(prot.money, 99999);

        final AccountCollectionsIndexResponse colIdx = await bn.wow.account
            .getAccountCollectionsIndex(
              accessToken: token,
              region: region,
              locale: locale,
            );
        expect(colIdx.petsHref, 'https://p');
        expect(colIdx.mountsHref, 'https://m');
        expect(colIdx.heirloomsHref, 'https://h');
        expect(colIdx.toysHref, 'https://t');
        expect(colIdx.transmogsHref, 'https://x');

        expect(
          (await bn.wow.account.getAccountMountsCollection(
            accessToken: token,
            region: region,
            locale: locale,
          )).mounts.length,
          1,
        );
        final AccountPetsCollectionResponse pets = await bn.wow.account
            .getAccountPetsCollection(
              accessToken: token,
              region: region,
              locale: locale,
            );
        expect(pets.pets.length, 1);
        expect(pets.unlockedBattlePetSlots, 3);
        expect(
          (await bn.wow.account.getAccountToysCollection(
            accessToken: token,
            region: region,
            locale: locale,
          )).toys.length,
          1,
        );
        expect(
          (await bn.wow.account.getAccountHeirloomsCollection(
            accessToken: token,
            region: region,
            locale: locale,
          )).heirlooms.length,
          1,
        );
        final AccountTransmogsCollectionResponse xmogs = await bn.wow.account
            .getAccountTransmogsCollection(
              accessToken: token,
              region: region,
              locale: locale,
            );
        expect(xmogs.appearanceSets.single.id, 1);
        expect(xmogs.slots.length, 1);
      },
    );

    test('CharacterProfileClient (all 29 endpoints)', () async {
      const String base = '/profile/wow/character/ravencrest/rinox';
      final BattleNet bn = makeFacade(<String, String>{
        base:
            '{"id":100,"name":"Rinox","level":80,"achievement_points":5000,"average_item_level":620,"equipped_item_level":618,"gender":{"type":"MALE"},"faction":{"type":"ALLIANCE"},"race":{"id":4},"character_class":{"id":1},"active_spec":{"id":71},"realm":{"id":1329},"guild":{"id":50}}',
        '$base/status': '{"id":100,"is_valid":true}',
        '$base/achievements':
            '{"total_quantity":10,"total_points":100,"achievements":[{"id":6}]}',
        '$base/achievements/statistics':
            '{"character":{"id":100},"categories":[{"id":1}]}',
        '$base/appearance': '{"character":{"id":100},"items":[{"id":1}]}',
        '$base/collections':
            '{"pets":{"href":"https://p"},"mounts":{"href":"https://m"},"heirlooms":{"href":"https://h"},"toys":{"href":"https://t"},"transmogs":{"href":"https://x"}}',
        '$base/collections/mounts': '{"mounts":[{"id":1}]}',
        '$base/collections/pets':
            '{"pets":[{"id":1}],"unlocked_battle_pet_slots":3}',
        '$base/collections/toys': '{"toys":[{"id":1}]}',
        '$base/collections/heirlooms': '{"heirlooms":[{"id":1}]}',
        '$base/collections/transmogs':
            '{"appearance_sets":[{"id":1}],"slots":[{"id":1}]}',
        '$base/encounters':
            '{"character":{"id":100},"dungeons":{"href":"https://d"},"raids":{"href":"https://r"}}',
        '$base/encounters/dungeons': '{"expansions":[{"id":1}]}',
        '$base/encounters/raids': '{"expansions":[{"id":2}]}',
        '$base/equipment':
            '{"character":{"id":100},"equipped_items":[{"id":1}]}',
        '$base/hunter-pets':
            '{"character":{"id":100},"hunter_pets":[{"id":1}]}',
        '$base/character-media':
            '{"character":{"id":100},"assets":[{"key":"avatar","value":"https://a"}]}',
        '$base/mythic-keystone-profile':
            '{"character":{"id":100},"current_period":{"period":{"id":1}},"seasons":[{"id":18}]}',
        '$base/mythic-keystone-profile/season/18':
            '{"character":{"id":100},"season":{"id":18},"best_runs":[{"keystone_level":10}]}',
        '$base/professions':
            '{"character":{"id":100},"primaries":[{"id":1}],"secondaries":[{"id":2}]}',
        '$base/pvp-bracket/2v2':
            '{"character":{"id":100},"bracket":{"type":"ARENA_2v2"},"rating":1800}',
        '$base/pvp-summary':
            '{"character":{"id":100},"honor_level":50,"honorable_kills":1000}',
        '$base/quests': '{"character":{"id":100},"in_progress":[{"id":1}]}',
        '$base/quests/completed':
            '{"character":{"id":100},"quests":[{"id":2}]}',
        '$base/reputations':
            '{"character":{"id":100},"reputations":[{"id":1}]}',
        '$base/soulbinds':
            '{"character":{"id":100},"chosen_covenant":{"id":1},"renown_level":80,"soulbinds":[{"id":4}]}',
        '$base/specializations':
            '{"character":{"id":100},"active_specialization":{"id":71},"specializations":[{"id":71}]}',
        '$base/statistics':
            '{"character":{"id":100},"health":5000000,"power":100,"power_type":{"id":1}}',
        '$base/titles':
            '{"character":{"id":100},"active_title":{"id":1},"titles":[{"id":1}]}',
      });

      const String rSlug = 'ravencrest';
      const String cName = 'Rinox';

      final CharacterProfileResponse prof = await bn.wow.character
          .getCharacterProfile(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(prof.id, 100);
      expect(prof.name, 'Rinox');
      expect(prof.level, 80);
      expect(prof.achievementPoints, 5000);
      expect(prof.averageItemLevel, 620);
      expect(prof.equippedItemLevel, 618);
      expect(prof.gender, 'MALE');
      expect(prof.faction, 'ALLIANCE');
      expect(prof.race?.id, 4);
      expect(prof.characterClass?.id, 1);
      expect(prof.activeSpec?.id, 71);
      expect(prof.realm?.id, 1329);
      expect(prof.guild?.id, 50);

      final CharacterProfileStatusResponse status = await bn.wow.character
          .getCharacterProfileStatus(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(status.id, 100);
      expect(status.isValid, isTrue);

      final CharacterAchievementsResponse ach = await bn.wow.character
          .getCharacterAchievements(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(ach.totalQuantity, 10);
      expect(ach.totalPoints, 100);
      expect(ach.achievements.length, 1);

      final CharacterAchievementStatisticsResponse achStats = await bn
          .wow
          .character
          .getCharacterAchievementStatistics(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(achStats.character?.id, 100);
      expect(achStats.categories.length, 1);

      final CharacterAppearanceResponse app = await bn.wow.character
          .getCharacterAppearance(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(app.character?.id, 100);
      expect(app.items.length, 1);

      final CharacterCollectionsIndexResponse cCol = await bn.wow.character
          .getCharacterCollectionsIndex(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(cCol.petsHref, 'https://p');
      expect(cCol.mountsHref, 'https://m');
      expect(cCol.heirloomsHref, 'https://h');
      expect(cCol.toysHref, 'https://t');
      expect(cCol.transmogsHref, 'https://x');

      expect(
        (await bn.wow.character.getCharacterMountsCollection(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: rSlug,
          characterName: cName,
        )).mounts.length,
        1,
      );
      final CharacterPetsCollectionResponse cPets = await bn.wow.character
          .getCharacterPetsCollection(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(cPets.pets.length, 1);
      expect(cPets.unlockedBattlePetSlots, 3);
      expect(
        (await bn.wow.character.getCharacterToysCollection(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: rSlug,
          characterName: cName,
        )).toys.length,
        1,
      );
      expect(
        (await bn.wow.character.getCharacterHeirloomsCollection(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: rSlug,
          characterName: cName,
        )).heirlooms.length,
        1,
      );
      final CharacterTransmogsCollectionResponse cXmog = await bn.wow.character
          .getCharacterTransmogsCollection(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(cXmog.appearanceSets.single.id, 1);
      expect(cXmog.slots.length, 1);

      final CharacterEncountersSummaryResponse enc = await bn.wow.character
          .getCharacterEncountersSummary(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(enc.character?.id, 100);
      expect(enc.dungeonsHref, 'https://d');
      expect(enc.raidsHref, 'https://r');
      expect(
        (await bn.wow.character.getCharacterDungeons(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: rSlug,
          characterName: cName,
        )).expansions.length,
        1,
      );
      expect(
        (await bn.wow.character.getCharacterRaids(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: rSlug,
          characterName: cName,
        )).expansions.length,
        1,
      );

      final CharacterEquipmentResponse eq = await bn.wow.character
          .getCharacterEquipment(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(eq.character?.id, 100);
      expect(eq.equippedItems.length, 1);

      final CharacterHunterPetsResponse hp = await bn.wow.character
          .getCharacterHunterPets(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(hp.character?.id, 100);
      expect(hp.hunterPets.length, 1);

      final CharacterMediaResponse med = await bn.wow.character
          .getCharacterMedia(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(med.character?.id, 100);
      expect(med.assets.single.key, 'avatar');

      final CharacterMythicKeystoneProfileResponse mk = await bn.wow.character
          .getCharacterMythicKeystoneProfile(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(mk.character?.id, 100);
      expect(mk.currentPeriod, isNotNull);
      expect(mk.seasons.single.id, 18);

      final CharacterMythicKeystoneSeasonResponse mkS = await bn.wow.character
          .getCharacterMythicKeystoneSeasonDetails(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
            seasonId: 18,
          );
      expect(mkS.character?.id, 100);
      expect(mkS.season?.id, 18);
      expect(mkS.bestRuns.length, 1);

      final CharacterProfessionsResponse cProf = await bn.wow.character
          .getCharacterProfessions(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(cProf.character?.id, 100);
      expect(cProf.primaries.length, 1);
      expect(cProf.secondaries.length, 1);

      final CharacterPvpBracketResponse pvpB = await bn.wow.character
          .getCharacterPvpBracketStatistics(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
            pvpBracket: '2v2',
          );
      expect(pvpB.character?.id, 100);
      expect(pvpB.bracket, 'ARENA_2v2');
      expect(pvpB.rating, 1800);

      final CharacterPvpSummaryResponse pvpS = await bn.wow.character
          .getCharacterPvpSummary(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(pvpS.character?.id, 100);
      expect(pvpS.honorLevel, 50);
      expect(pvpS.honorableKills, 1000);

      final CharacterQuestsResponse q = await bn.wow.character
          .getCharacterQuests(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(q.character?.id, 100);
      expect(q.inProgress.single.id, 1);

      final CharacterCompletedQuestsResponse qC = await bn.wow.character
          .getCharacterCompletedQuests(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(qC.character?.id, 100);
      expect(qC.quests.single.id, 2);

      final CharacterReputationsResponse rep = await bn.wow.character
          .getCharacterReputations(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(rep.character?.id, 100);
      expect(rep.reputations.length, 1);

      final CharacterSoulbindsResponse soul = await bn.wow.character
          .getCharacterSoulbinds(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(soul.character?.id, 100);
      expect(soul.chosenCovenant?.id, 1);
      expect(soul.renownLevel, 80);
      expect(soul.soulbinds.length, 1);

      final CharacterSpecializationsResponse spec = await bn.wow.character
          .getCharacterSpecializations(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(spec.character?.id, 100);
      expect(spec.activeSpecialization?.id, 71);
      expect(spec.specializations.length, 1);

      final CharacterStatisticsResponse stats = await bn.wow.character
          .getCharacterStatistics(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(stats.character?.id, 100);
      expect(stats.health, 5000000);
      expect(stats.power, 100);
      expect(stats.powerType?.id, 1);

      final CharacterTitlesResponse titles = await bn.wow.character
          .getCharacterTitles(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            characterName: cName,
          );
      expect(titles.character?.id, 100);
      expect(titles.activeTitle?.id, 1);
      expect(titles.titles.single.id, 1);
    });

    test('GuildClient (all 4 endpoints)', () async {
      const String gBase = '/data/wow/guild/ravencrest/viysko-nightelfiyske';
      final BattleNet bn = makeFacade(<String, String>{
        gBase:
            '{"id":50,"name":"Viysko Nightelfiyske","faction":{"type":"ALLIANCE"},"achievement_points":2000,"member_count":150,"realm":{"id":1329},"roster":{"href":"https://ro"},"achievements":{"href":"https://ac"},"activity":{"href":"https://av"}}',
        '$gBase/activity': '{"guild":{"id":50},"activities":[{"type":"KILL"}]}',
        '$gBase/achievements':
            '{"guild":{"id":50},"total_quantity":5,"total_points":50,"achievements":[{"id":1}]}',
        '$gBase/roster':
            '{"guild":{"id":50},"members":[{"rank":0,"character":{"id":100,"name":"Rinox"}}]}',
      });

      const String rSlug = 'ravencrest';
      const String gSlug = 'Viysko-Nightelfiyske';

      final GuildResponse g = await bn.wow.guild.getGuild(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: rSlug,
        nameSlug: gSlug,
      );
      expect(g.id, 50);
      expect(g.name, 'Viysko Nightelfiyske');
      expect(g.faction, 'ALLIANCE');
      expect(g.achievementPoints, 2000);
      expect(g.memberCount, 150);
      expect(g.realm?.id, 1329);
      expect(g.rosterHref, 'https://ro');
      expect(g.achievementsHref, 'https://ac');
      expect(g.activityHref, 'https://av');

      final GuildActivityResponse act = await bn.wow.guild.getGuildActivity(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: rSlug,
        nameSlug: gSlug,
      );
      expect(act.guild?.id, 50);
      expect(act.activities.length, 1);

      final GuildAchievementsResponse gAch = await bn.wow.guild
          .getGuildAchievements(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: rSlug,
            nameSlug: gSlug,
          );
      expect(gAch.guild?.id, 50);
      expect(gAch.totalQuantity, 5);
      expect(gAch.totalPoints, 50);
      expect(gAch.achievements.length, 1);

      final GuildRosterResponse roster = await bn.wow.guild.getGuildRoster(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: rSlug,
        nameSlug: gSlug,
      );
      expect(roster.guild?.id, 50);
      expect(roster.members.single.rank, 0);
      expect(roster.members.single.characterId, 100);
      expect(roster.members.single.characterName, 'Rinox');
    });
  });
}
