import 'package:battle_net/battle_net.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/wow/forever/forever_account_client.dart';
import 'package:battle_net/src/wow/forever/forever_item_client.dart';
import 'package:battle_net/src/wow/forever/forever_ruleset_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  const String accessToken = 'dummy_token';
  const BattleNetRegion region = BattleNetRegion.eu;
  const BattleNetLocale locale = BattleNetLocale.enGB;

  setUp(() {
    Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
  });

  group('ForeverAccountClient Unit Tests', () {
    test('getForeverAccountProfile - 200 OK', () async {
      // Note: requires a user access token with wow.profile scope.
      final ForeverAccountClient client = ForeverAccountClient(
        connectionTimeout: 5,
        client: MockClient((http.Request req) async {
          expect(req.url.path, '/profile/user/wow');
          expect(req.url.queryParameters['namespace'], 'profile-forever-eu');
          return http.Response(
            '{"wow_accounts":[{"id":1,"characters":[{"slug":"ada-brightwood","name":"Ada","level":60,"playable_class":{"id":8},"playable_race":{"id":1}}]}]}',
            200,
          );
        }),
      );
      final ForeverAccountProfileResponse res = await client
          .getForeverAccountProfile(
            accessToken: accessToken,
            region: region,
            locale: locale,
          );
      expect(res.wowAccounts.length, 1);
      expect(res.wowAccounts.first.characters.first.slug, 'ada-brightwood');
    });

    test('getForeverAccountProfile - 401 throws Exception', () async {
      final ForeverAccountClient client = ForeverAccountClient(
        connectionTimeout: 5,
        client: MockClient((_) async => http.Response('Unauthorized', 401)),
      );
      expect(
        () => client.getForeverAccountProfile(
          accessToken: accessToken,
          region: region,
          locale: locale,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('ForeverItemClient Unit Tests', () {
    test('getItemData - 200 OK', () async {
      final ForeverItemClient client = ForeverItemClient(
        connectionTimeout: 5,
        client: MockClient((http.Request req) async {
          expect(req.url.path, '/data/wow/item/19019');
          expect(req.url.queryParameters['namespace'], 'static-forever-eu');
          return http.Response(
            '{"id":19019,"name":"Thunderfury, Blessed Blade of the Windseeker","quality":{"type":"LEGENDARY"},"level":80,"required_level":60,"item_class":{"id":2},"item_subclass":{"id":7}}',
            200,
          );
        }),
      );
      final ForeverItemResponse res = await client.getItemData(
        accessToken: accessToken,
        region: region,
        locale: locale,
        itemId: 19019,
      );
      expect(res.id, 19019);
      expect(res.quality, 5);
      expect(res.itemLevel, 80);
    });

    test(
      'getItemData - 404 BLZWEBAPI00000404 throws BattleNetNotFoundException',
      () async {
        final ForeverItemClient client = ForeverItemClient(
          connectionTimeout: 5,
          client: MockClient(
            (_) async => http.Response('{"type":"BLZWEBAPI00000404"}', 404),
          ),
        );
        expect(
          () => client.getItemData(
            accessToken: accessToken,
            region: region,
            locale: locale,
            itemId: 999999,
          ),
          throwsA(isA<BattleNetNotFoundException>()),
        );
      },
    );
  });

  group('ForeverRulesetClient Unit Tests', () {
    test('getForeverRulesetIndex - 200 OK', () async {
      final ForeverRulesetClient client = ForeverRulesetClient(
        connectionTimeout: 5,
        client: MockClient((http.Request req) async {
          expect(req.url.path, '/data/wow/ruleset/index');
          expect(req.url.queryParameters['namespace'], 'dynamic-forever-eu');
          return http.Response(
            '{"rulesets":[{"id":1,"name":"Normal"},{"id":2,"name":"PvP"}]}',
            200,
          );
        }),
      );
      final ForeverRulesetIndexResponse res = await client
          .getForeverRulesetIndex(
            accessToken: accessToken,
            region: region,
            locale: locale,
          );
      expect(res.rulesets.length, 2);
      expect(res.rulesets.first.name, 'Normal');
    });

    test('getForeverRuleset - 200 OK', () async {
      final ForeverRulesetClient client = ForeverRulesetClient(
        connectionTimeout: 5,
        client: MockClient((http.Request req) async {
          expect(req.url.path, '/data/wow/ruleset/1');
          return http.Response(
            '{"id":1,"name":"Normal","slug":"normal","population":{"value":3}}',
            200,
          );
        }),
      );
      final ForeverRulesetResponse res = await client.getForeverRuleset(
        accessToken: accessToken,
        region: region,
        locale: locale,
        rulesetId: 1,
      );
      expect(res.id, 1);
      expect(res.slug, 'normal');
      expect(res.population, 3);
    });

    test('getForeverRulesetAuctions - client-side pagination', () async {
      const String payload =
          '{"auctions":['
          '{"id":1,"item":{"id":100},"quantity":1,"buyout":500,"time_left":"LONG"},'
          '{"id":2,"item":{"id":101},"quantity":5,"unit_price":100,"time_left":"SHORT"},'
          '{"id":3,"item":{"id":102},"quantity":2,"bid":200,"time_left":"MEDIUM"}'
          ']}';
      final ForeverRulesetClient client = ForeverRulesetClient(
        connectionTimeout: 5,
        client: MockClient((http.Request req) async {
          expect(req.url.path, '/data/wow/ruleset/1/auctions/index');
          return http.Response(payload, 200);
        }),
      );

      final ForeverAuctionPageResponse page1 = await client
          .getForeverRulesetAuctions(
            accessToken: accessToken,
            region: region,
            locale: locale,
            rulesetId: 1,
            page: 1,
            pageSize: 2,
          );
      expect(page1.totalAuctions, 3);
      expect(page1.totalPages, 2);
      expect(page1.hasNextPage, isTrue);
      expect(page1.auctions.length, 2);
      expect(page1.auctions.first.itemId, 100);

      final ForeverAuctionPageResponse page2 = await client
          .getForeverRulesetAuctions(
            accessToken: accessToken,
            region: region,
            locale: locale,
            rulesetId: 1,
            page: 2,
            pageSize: 2,
          );
      expect(page2.hasNextPage, isFalse);
      expect(page2.auctions.length, 1);
      expect(page2.auctions.first.id, 3);
    });
  });
}
