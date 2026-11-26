import 'package:battle_net/battle_net.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/wow/forever/forever_character_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('ForeverCharacterClient Unit Tests', () {
    const String accessToken = 'dummy_token';
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;
    final ForeverCharacterSlug slug = ForeverCharacterSlug(
      name: 'Ada',
      surname: 'Brightwood',
    );

    setUp(() {
      Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
    });

    ForeverCharacterClient makeClient(
      Future<http.Response> Function(http.Request) handler,
    ) => ForeverCharacterClient(
      connectionTimeout: 5,
      client: MockClient(handler),
    );

    test('getForeverCharacterProfile - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(req.url.path, '/profile/wow/character/ada-brightwood');
        expect(req.url.queryParameters['namespace'], 'profile-forever-eu');
        return http.Response(
          '{"slug":"ada-brightwood","name":"Ada","surname":"Brightwood","level":60,"achievement_points":1200,"gender":{"type":"FEMALE"},"race":{"id":1},"character_class":{"id":8}}',
          200,
        );
      });
      final ForeverCharacterProfileResponse res = await client
          .getForeverCharacterProfile(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.slug, 'ada-brightwood');
      expect(res.level, 60);
      expect(res.gender, 1);
      expect(res.raceId, 1);
      expect(res.classId, 8);
    });

    test(
      'getForeverCharacterProfile - 404 BLZWEBAPI00000404 throws BattleNetNotFoundException',
      () async {
        final ForeverCharacterClient client = makeClient(
          (_) async => http.Response(
            '{"code":404,"type":"BLZWEBAPI00000404","detail":"Not Found"}',
            404,
          ),
        );
        expect(
          () => client.getForeverCharacterProfile(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          ),
          throwsA(isA<BattleNetNotFoundException>()),
        );
      },
    );

    test('getForeverCharacterProfile - 500 throws Exception', () async {
      final ForeverCharacterClient client = makeClient(
        (_) async => http.Response('error', 500),
      );
      expect(
        () => client.getForeverCharacterProfile(
          accessToken: accessToken,
          region: region,
          locale: locale,
          slug: slug,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test(
      'getForeverCharacterEquipment - 200 OK (including null equipped_items)',
      () async {
        final ForeverCharacterClient client = makeClient((
          http.Request req,
        ) async {
          expect(
            req.url.path,
            '/profile/wow/character/ada-brightwood/equipment',
          );
          return http.Response(
            '{"character":{"slug":"ada-brightwood"},"equipped_items":[{"item":{"id":19019},"slot":{"type":"MAIN_HAND"},"name":"Thunderfury","level":{"value":80}}]}',
            200,
          );
        });
        final ForeverCharacterEquipmentResponse res = await client
            .getForeverCharacterEquipment(
              accessToken: accessToken,
              region: region,
              locale: locale,
              slug: slug,
            );
        expect(res.equippedItems?.first.itemId, 19019);
        expect(res.equippedItems?.first.slot, 'MAIN_HAND');
      },
    );

    test('getForeverCharacterMedia - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/character-media',
        );
        return http.Response(
          '{"character":{"slug":"ada-brightwood"},"assets":[{"key":"avatar","value":"https://render.worldofwarcraft.com/forever-eu/avatar.jpg","file_data_id":123}]}',
          200,
        );
      });
      final ForeverCharacterMediaResponse res = await client
          .getForeverCharacterMedia(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.assets?.first.key, 'avatar');
      expect(res.assets?.first.fileDataId, 123);
    });

    test('getForeverCharacterAchievements - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/achievements',
        );
        return http.Response(
          '{"total_points":500,"achievements":[{"id":6,"completed_timestamp":1700000000}]}',
          200,
        );
      });
      final ForeverCharacterAchievementsResponse res = await client
          .getForeverCharacterAchievements(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.totalPoints, 500);
      expect(res.achievements.first.id, 6);
    });

    test('getForeverCharacterStatistics - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/achievements/statistics',
        );
        return http.Response(
          '{"total_quantity":10,"statistics":[{"id":1,"name":"Deaths","quantity":5,"last_updated_timestamp":1700000000}]}',
          200,
        );
      });
      final ForeverCharacterStatisticsResponse res = await client
          .getForeverCharacterStatistics(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.statistics.first.name, 'Deaths');
    });

    test('getForeverCharacterDungeonEncounters - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/encounters/dungeons',
        );
        return http.Response(
          '{"expansions":[{"expansion":{"id":1,"name":"Classic"},"instances":[{"instance":{"id":43,"name":"Wailing Caverns"},"modes":[{"progress":{"encounters":[{"encounter":{"id":585,"name":"Lady Anacondra"},"completed_count":2,"last_kill_timestamp":1700000000}]}}]}]}]}',
          200,
        );
      });
      final ForeverCharacterEncountersResponse res = await client
          .getForeverCharacterDungeonEncounters(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(
        res.expansions.first.instances.first.encounters.first.completedCount,
        2,
      );
    });

    test('getForeverCharacterPvpSummary - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/pvp-summary',
        );
        return http.Response('{"honor_level":10,"honorable_kills":250}', 200);
      });
      final ForeverCharacterPvpSummaryResponse res = await client
          .getForeverCharacterPvpSummary(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.honorLevel, 10);
      expect(res.honorableKills, 250);
    });

    test('getForeverCharacterCompletedQuests - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/quests/completed',
        );
        return http.Response(
          '{"quests":[{"id":7,"title":"Kobold Camp Cleanup"}]}',
          200,
        );
      });
      final ForeverCharacterQuestsResponse res = await client
          .getForeverCharacterCompletedQuests(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.quests.first.id, 7);
    });

    test('getForeverCharacterReputations - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/reputations',
        );
        return http.Response(
          '{"reputations":[{"faction":{"id":72,"name":"Stormwind"},"standing":{"value":42000}}]}',
          200,
        );
      });
      final ForeverCharacterReputationsResponse res = await client
          .getForeverCharacterReputations(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.reputations.first.factionName, 'Stormwind');
      expect(res.reputations.first.standing, 42000);
    });

    test('getForeverCharacterProfessions - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/professions',
        );
        return http.Response(
          '{"primaries":[{"profession":{"id":171,"name":"Alchemy"},"tiers":[{"skill_points":300,"max_skill_points":300}]}],"secondaries":[]}',
          200,
        );
      });
      final ForeverCharacterProfessionsResponse res = await client
          .getForeverCharacterProfessions(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.primaries.first.professionName, 'Alchemy');
      expect(res.primaries.first.skillPoints, 300);
    });

    test('getForeverCharacterSpecializations - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/specializations',
        );
        return http.Response(
          '{"active_specialization":{"id":64,"name":"Frost"},"specializations":[{"specialization":{"id":64,"name":"Frost"}}]}',
          200,
        );
      });
      final ForeverCharacterSpecializationsResponse res = await client
          .getForeverCharacterSpecializations(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.activeSpecName, 'Frost');
      expect(res.specializations.first.specId, 64);
    });

    test('getForeverCharacterTitles - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(req.url.path, '/profile/wow/character/ada-brightwood/titles');
        return http.Response(
          '{"active_title":{"id":1},"titles":[{"id":1,"name":"Private"}]}',
          200,
        );
      });
      final ForeverCharacterTitlesResponse res = await client
          .getForeverCharacterTitles(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.activeTitleId, 1);
      expect(res.titles.first.name, 'Private');
    });

    test('getForeverCharacterCollections - 200 OK', () async {
      final ForeverCharacterClient client = makeClient((
        http.Request req,
      ) async {
        expect(
          req.url.path,
          '/profile/wow/character/ada-brightwood/collections',
        );
        return http.Response(
          '{"mounts":[{"mount":{"id":1,"name":"Brown Horse"}}],"pets":[{"species":{"id":39,"name":"Mechanical Squirrel"}}]}',
          200,
        );
      });
      final ForeverCharacterCollectionsResponse res = await client
          .getForeverCharacterCollections(
            accessToken: accessToken,
            region: region,
            locale: locale,
            slug: slug,
          );
      expect(res.mounts?.first.name, 'Brown Horse');
      expect(res.pets?.first.name, 'Mechanical Squirrel');
    });
  });
}
