import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/wow/game/token/models/token_index_response.dart';
import 'package:battle_net/src/wow/game/token/token_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('TokenClient', () {
    late TokenClient tokenClient;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((http.Request request) async {
        if (request.url.path == '/data/wow/token/') {
          return http.Response(
            '{"_links": {"self": {"href": "https://eu.api.blizzard.com/data/wow/token/?namespace=dynamic-eu"}},"last_updated_timestamp": 1675888263000,"price": 2508420000}',
            200,
          );
        }
        return http.Response('Error', 404);
      });
      tokenClient = TokenClient(connectionTimeout: 5000, client: mockClient);
    });

    test('getTokenIndex - success', () async {
      final TokenIndexResponse response = await tokenClient.getTokenIndex(
        accessToken: 'test_token',
        region: BattleNetRegion.eu,
        namespace: BattleNetNamespace.dynamic,
        locale: BattleNetLocale.enUS,
      );

      expect(response.price, equals(2508420000));
      expect(response.lastUpdatedTimestamp, equals(1675888263000));
    });

    test('getTokenIndex - error', () async {
      mockClient = MockClient((http.Request request) async {
        return http.Response('Error', 500);
      });
      tokenClient = TokenClient(connectionTimeout: 5000, client: mockClient);

      expect(
        () => tokenClient.getTokenIndex(
          accessToken: 'test_token',
          region: BattleNetRegion.eu,
          namespace: BattleNetNamespace.dynamic,
          locale: BattleNetLocale.enUS,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
