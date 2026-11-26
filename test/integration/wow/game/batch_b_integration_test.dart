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

  group('Batch B Live Integration Smoke Tests (EU)', () {
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    test('Achievement & Creature', () async {
      expect(
        (await battleNet.wow.achievement.getAchievementCategoriesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).categories,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.achievement.getAchievement(
          accessToken: token,
          region: region,
          locale: locale,
          achievementId: 6,
        )).id,
        6,
      );
      expect(
        (await battleNet.wow.achievement.getAchievementMedia(
          accessToken: token,
          region: region,
          locale: locale,
          achievementId: 6,
        )).assets,
        isNotEmpty,
      );

      expect(
        (await battleNet.wow.creature.getCreatureFamiliesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).creatureFamilies,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.creature.getCreature(
          accessToken: token,
          region: region,
          locale: locale,
          creatureId: 42722,
        )).id,
        42722,
      );
      expect(
        (await battleNet.wow.creature.searchCreatures(
          accessToken: token,
          region: region,
          locale: locale,
          pageSize: 2,
        )).results,
        isNotEmpty,
      );
    });

    test('Journal, Mount, Pet', () async {
      expect(
        (await battleNet.wow.journal.getJournalExpansionsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).tiers,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.journal.getJournalInstance(
          accessToken: token,
          region: region,
          locale: locale,
          journalInstanceId: 63,
        )).id,
        63,
      );
      expect(
        (await battleNet.wow.journal.getJournalEncounter(
          accessToken: token,
          region: region,
          locale: locale,
          journalEncounterId: 89,
        )).id,
        89,
      );

      expect(
        (await battleNet.wow.mount.getMountsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).mounts,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.mount.getMount(
          accessToken: token,
          region: region,
          locale: locale,
          mountId: 6,
        )).id,
        6,
      );

      expect(
        (await battleNet.wow.pet.getPetsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).pets,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.pet.getPet(
          accessToken: token,
          region: region,
          locale: locale,
          petId: 39,
        )).id,
        39,
      );
      expect(
        (await battleNet.wow.pet.getPetAbility(
          accessToken: token,
          region: region,
          locale: locale,
          petAbilityId: 110,
        )).id,
        110,
      );
    });

    test('Playable Class, Race, Specialization', () async {
      expect(
        (await battleNet.wow.playableClass.getPlayableClassesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).classes,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.playableClass.getPlayableClass(
          accessToken: token,
          region: region,
          locale: locale,
          classId: 1,
        )).id,
        1,
      );
      expect(
        (await battleNet.wow.playableRace.getPlayableRace(
          accessToken: token,
          region: region,
          locale: locale,
          raceId: 1,
        )).id,
        1,
      );
      expect(
        (await battleNet.wow.playableSpecialization
                .getPlayableSpecializationsIndex(
                  accessToken: token,
                  region: region,
                  locale: locale,
                ))
            .characterSpecializations,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.playableSpecialization.getPlayableSpecialization(
          accessToken: token,
          region: region,
          locale: locale,
          specId: 262,
        )).id,
        262,
      );
    });

    test('PvP, Quest, Spell, Talent', () async {
      final PvpSeasonsIndexResponse pvpIdx = await battleNet.wow.pvpSeason
          .getPvpSeasonsIndex(
            accessToken: token,
            region: region,
            locale: locale,
          );
      expect(pvpIdx.seasons, isNotEmpty);
      expect(
        (await battleNet.wow.pvpSeason.getPvpSeason(
          accessToken: token,
          region: region,
          locale: locale,
          pvpSeasonId: pvpIdx.currentSeasonId!,
        )).id,
        pvpIdx.currentSeasonId,
      );
      expect(
        (await battleNet.wow.pvpTier.getPvpTiersIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).tiers,
        isNotEmpty,
      );

      expect(
        (await battleNet.wow.quest.getQuest(
          accessToken: token,
          region: region,
          locale: locale,
          questId: 2,
        )).id,
        2,
      );
      expect(
        (await battleNet.wow.spell.getSpell(
          accessToken: token,
          region: region,
          locale: locale,
          spellId: 196607,
        )).id,
        196607,
      );

      expect(
        (await battleNet.wow.talent.getTalentTreesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).specTalentTrees,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.talent.getTalentTree(
          accessToken: token,
          region: region,
          locale: locale,
          talentTreeId: 774,
          specId: 254,
        )).id,
        774,
      );
      expect(
        (await battleNet.wow.talent.getTalent(
          accessToken: token,
          region: region,
          locale: locale,
          talentId: 117163,
        )).id,
        117163,
      );
    });
  });
}
