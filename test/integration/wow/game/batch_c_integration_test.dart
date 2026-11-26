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

  group('Batch C Live Integration Smoke Tests (EU)', () {
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;

    test('AzeriteEssence, Covenant, GuildCrest, Heirloom, Media', () async {
      expect(
        (await battleNet.wow.azeriteEssence.getAzeriteEssencesIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).azeriteEssences,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.azeriteEssence.getAzeriteEssence(
          accessToken: token,
          region: region,
          locale: locale,
          azeriteEssenceId: 16,
        )).id,
        16,
      );
      expect(
        (await battleNet.wow.covenant.getCovenant(
          accessToken: token,
          region: region,
          locale: locale,
          covenantId: 1,
        )).id,
        1,
      );
      expect(
        (await battleNet.wow.covenant.getSoulbind(
          accessToken: token,
          region: region,
          locale: locale,
          soulbindId: 4,
        )).id,
        4,
      );
      expect(
        (await battleNet.wow.covenant.getConduit(
          accessToken: token,
          region: region,
          locale: locale,
          conduitId: 19,
        )).id,
        19,
      );
      expect(
        (await battleNet.wow.guildCrest.getGuildCrestComponentsIndex(
          accessToken: token,
          region: region,
          locale: locale,
        )).emblems,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.heirloom.getHeirloom(
          accessToken: token,
          region: region,
          locale: locale,
          heirloomId: 1,
        )).id,
        1,
      );
      expect(
        (await battleNet.wow.media.searchMedia(
          accessToken: token,
          region: region,
          locale: locale,
          filters: <String, String>{'tags': 'item'},
          pageSize: 2,
        )).results,
        isNotEmpty,
      );
    });

    test(
      'ModifiedCrafting, PowerType, Reputation, TechTalent, Title, Toy',
      () async {
        expect(
          (await battleNet.wow.modifiedCrafting.getModifiedCraftingIndex(
            accessToken: token,
            region: region,
            locale: locale,
          )).categoriesHref,
          isNotEmpty,
        );
        expect(
          (await battleNet.wow.modifiedCrafting.getModifiedCraftingCategory(
            accessToken: token,
            region: region,
            locale: locale,
            categoryId: 1,
          )).id,
          1,
        );
        expect(
          (await battleNet.wow.powerType.getPowerType(
            accessToken: token,
            region: region,
            locale: locale,
            powerTypeId: 10,
          )).id,
          10,
        );
        expect(
          (await battleNet.wow.reputation.getReputationFaction(
            accessToken: token,
            region: region,
            locale: locale,
            reputationFactionId: 1091,
          )).id,
          1091,
        );
        expect(
          (await battleNet.wow.reputation.getReputationTiers(
            accessToken: token,
            region: region,
            locale: locale,
            reputationTiersId: 0,
          )).tiers,
          isNotEmpty,
        );
        expect(
          (await battleNet.wow.techTalent.getTechTalentTree(
            accessToken: token,
            region: region,
            locale: locale,
            techTalentTreeId: 31,
          )).id,
          31,
        );
        expect(
          (await battleNet.wow.techTalent.getTechTalent(
            accessToken: token,
            region: region,
            locale: locale,
            techTalentId: 39,
          )).id,
          39,
        );
        expect(
          (await battleNet.wow.title.getTitle(
            accessToken: token,
            region: region,
            locale: locale,
            titleId: 140,
          )).id,
          140,
        );
        expect(
          (await battleNet.wow.toy.getToy(
            accessToken: token,
            region: region,
            locale: locale,
            toyId: 30,
          )).id,
          30,
        );
      },
    );
  });
}
