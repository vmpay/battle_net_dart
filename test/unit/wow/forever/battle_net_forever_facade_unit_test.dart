import 'package:battle_net/battle_net.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('BattleNet facade - WoW: Forever', () {
    const String token = 'token';
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;
    final ForeverCharacterSlug slug = ForeverCharacterSlug(
      name: 'Ada',
      surname: 'Brightwood',
    );
    final List<String> paths = <String>[];

    late BattleNet battleNet;

    setUp(() {
      paths.clear();
      battleNet = BattleNet(
        clientId: 'id',
        clientSecret: 'secret',
        logLevel: LogLevel.NONE,
        httpClient: MockClient((http.Request request) async {
          paths.add(request.url.path);
          if (request.url.host == 'oauth.battle.net') {
            return http.Response(
              '{"access_token":"new","token_type":"bearer","expires_in":1,'
              '"scope":"wow.profile","sub":"1","id_token":"x"}',
              200,
            );
          }
          return http.Response('{}', 200);
        }),
      );
    });

    test('character endpoints are forwarded to the expected paths', () async {
      await battleNet.getForeverCharacterProfile(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterEquipment(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterMedia(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterAchievements(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterStatistics(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterDungeonEncounters(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterPvpSummary(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterCompletedQuests(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterReputations(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterProfessions(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterSpecializations(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterTitles(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );
      await battleNet.getForeverCharacterCollections(
        accessToken: token,
        region: region,
        locale: locale,
        slug: slug,
      );

      const String base = '/profile/wow/character/ada-brightwood';
      expect(paths, <String>[
        base,
        '$base/equipment',
        '$base/character-media',
        '$base/achievements',
        '$base/achievements/statistics',
        '$base/encounters/dungeons',
        '$base/pvp-summary',
        '$base/quests/completed',
        '$base/reputations',
        '$base/professions',
        '$base/specializations',
        '$base/titles',
        '$base/collections',
      ]);
    });

    test('account, item and ruleset endpoints are forwarded', () async {
      await battleNet.getForeverAccountProfile(
        accessToken: token,
        region: region,
        locale: locale,
      );
      await battleNet.getItemData(
        accessToken: token,
        region: region,
        locale: locale,
        itemId: 19019,
      );
      await battleNet.getForeverRulesetIndex(
        accessToken: token,
        region: region,
        locale: locale,
      );
      await battleNet.getForeverRuleset(
        accessToken: token,
        region: region,
        locale: locale,
        rulesetId: 1,
      );
      final ForeverAuctionPageResponse auctions = await battleNet
          .getForeverRulesetAuctions(
            accessToken: token,
            region: region,
            locale: locale,
            rulesetId: 1,
            page: 2,
            pageSize: 10,
          );

      expect(paths, <String>[
        '/profile/user/wow',
        '/data/wow/item/19019',
        '/data/wow/ruleset/index',
        '/data/wow/ruleset/1',
        '/data/wow/ruleset/1/auctions/index',
      ]);
      expect(auctions.page, 2);
      expect(auctions.pageSize, 10);
    });

    test('refreshAccessToken is forwarded to the OAuth client', () async {
      final AuthorizationCodeResponse res = await battleNet.refreshAccessToken(
        refreshToken: 'refresh',
      );
      expect(res.accessToken, 'new');
      expect(paths, <String>['/oauth/token']);
    });

    test('foreverStaticVersion defaults to 1.60.1_70399', () {
      expect(battleNet.foreverStaticVersion, '1.60.1_70399');
    });
  });
}
