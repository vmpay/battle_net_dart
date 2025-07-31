// test/integration/wow/game/mythic_keystone_dungeon/get_mythic_keystone_periods_index_integration_test.dart
import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/oauth/models/client_credentials_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_periods_index_response.dart';
import 'package:test/test.dart';

import '../../../credentials.dart';

void main() {
  group('getMythicKeystonePeriodsIndex Integration Tests', () {
    late BattleNet battleNet;
    late String accessToken;

    setUpAll(() async {
      battleNet = BattleNet(
        clientId: clientId,
        clientSecret: clientSecret,
        enableReleaseLogging: false,
      ); // Enable logging for debugging
      try {
        final ClientCredentialsResponse credentials = await battleNet
            .postClientCredentials();
        accessToken = credentials.accessToken;
      } catch (e) {
        throw Exception(
          'Failed to get access token for integration tests: $e. Ensure credentials are valid and Battle.net services are reachable.',
        );
      }
    });

    test(
      'should return a valid Mythic Keystone Periods Index for US region',
      () async {
        const BattleNetRegion region = BattleNetRegion.us;
        const BattleNetNamespace namespace = BattleNetNamespace.dynamic;
        const BattleNetLocale locale = BattleNetLocale.enUS;

        try {
          final MythicKeystonePeriodsIndexResponse response = await battleNet
              .getMythicKeystonePeriodsIndex(
                accessToken: accessToken,
                region: region,
                namespace: namespace,
                locale: locale,
              );

          expect(response, isNotNull);
          expect(response, isA<MythicKeystonePeriodsIndexResponse>());

          // Basic checks based on the expected structure
          expect(response.links, isNotNull);
          expect(response.links.self, isNotNull);
          expect(
            response.links.self.href,
            contains('/data/wow/mythic-keystone/period/'),
          );

          expect(response.periods, isNotNull);
          expect(response.periods, isA<List<Period>>());

          if (response.periods.isNotEmpty) {
            final Period firstPeriod = response.periods.first;
            expect(firstPeriod.id, isA<int>());
            expect(firstPeriod.id, greaterThan(0));
          }

          expect(response.currentPeriod, isA<Period>());
          expect(response.currentPeriod.id, greaterThan(0));

          print(
            'Successfully fetched Mythic Keystone Periods Index for ${region.name}. Found ${response.periods.length} periods.',
          );
          print('Current period ID: ${response.currentPeriod}');
        } catch (e) {
          fail(
            'getMythicKeystonePeriodsIndex threw an exception: $e. Check API status and request parameters.',
          );
        }
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'should return a valid Mythic Keystone Periods Index for EU region',
      () async {
        const BattleNetRegion region = BattleNetRegion.eu;
        const BattleNetNamespace namespace =
            BattleNetNamespace.dynamic; // Or dynamic-eu
        const BattleNetLocale locale = BattleNetLocale.enGB;

        try {
          final MythicKeystonePeriodsIndexResponse response = await battleNet
              .getMythicKeystonePeriodsIndex(
                accessToken: accessToken,
                region: region,
                namespace: namespace,
                locale: locale,
              );

          expect(response, isNotNull);
          expect(response, isA<MythicKeystonePeriodsIndexResponse>());
          expect(
            response.links.self.href,
            contains('/data/wow/mythic-keystone/period/'),
          );
          expect(response.periods, isNotNull);

          if (response.periods.isNotEmpty) {
            expect(response.periods.first.id, isA<int>());
          }
          print(
            'Successfully fetched Mythic Keystone Periods Index for ${region.name}. Found ${response.periods.length} periods.',
          );
        } catch (e) {
          fail(
            'getMythicKeystonePeriodsIndex threw an exception for EU: $e. Check API status and request parameters.',
          );
        }
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
