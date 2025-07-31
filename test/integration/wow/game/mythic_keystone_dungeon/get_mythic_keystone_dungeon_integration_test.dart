// test/integration/wow/game/mythic_keystone_dungeon/get_mythic_keystone_dungeon_integration_test.dart
import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/oauth/models/client_credentials_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_period_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_periods_index_response.dart';
import 'package:test/test.dart';

import '../../../credentials.dart';

void main() {
  group('Mythic Keystone Data Integration Tests (BattleNet Facade)', () {
    late BattleNet battleNet;
    late String accessToken;

    int knownPeriodId = 1019;

    setUpAll(() async {
      battleNet = BattleNet(
        clientId: clientId,
        clientSecret: clientSecret,
        enableReleaseLogging: false,
      );
      try {
        final ClientCredentialsResponse credentials = await battleNet
            .postClientCredentials();
        accessToken = credentials.accessToken;

        // Fetch a dynamic period ID and affix ID to make tests more robust
        try {
          final MythicKeystonePeriodsIndexResponse periodsIndex =
              await battleNet.getMythicKeystonePeriodsIndex(
                accessToken: accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamic,
                locale: BattleNetLocale.enUS,
              );
          if (periodsIndex.periods.isNotEmpty) {
            knownPeriodId = periodsIndex.periods.first.id;
            print('Using dynamic period ID for tests: $knownPeriodId');
          }
          // Use current if available
          knownPeriodId = periodsIndex.currentPeriod.id;
          print('Using current period ID for tests: $knownPeriodId');
        } catch (e) {
          print(
            'Warning: Could not fetch dynamic IDs for testing, using defaults. Error: $e',
          );
        }
      } catch (e) {
        throw Exception(
          'Failed to get access token for integration tests: $e.',
        );
      }
    });

    const BattleNetRegion testRegion = BattleNetRegion.us;
    const BattleNetLocale testLocale = BattleNetLocale.enUS;

    test(
      'getMythicKeystonePeriod - success',
      () async {
        final MythicKeystonePeriodResponse response = await battleNet
            .getMythicKeystonePeriod(
              accessToken: accessToken,
              region: testRegion,
              namespace: BattleNetNamespace.dynamic,
              locale: testLocale,
              periodId: knownPeriodId,
            );
        expect(response, isA<MythicKeystonePeriodResponse>());
        expect(response.id, knownPeriodId);
        expect(response.startTime, isNotNull);
        print(
          'Fetched Period ID: ${response.id}, Start: ${response.startTime}',
        );
      },
      timeout: const Timeout(Duration(seconds: 20)),
    );

    test(
      'getMythicKeystonePeriod - not found (404)',
      () async {
        try {
          await battleNet.getMythicKeystonePeriod(
            accessToken: accessToken,
            region: testRegion,
            namespace: BattleNetNamespace.dynamic,
            locale: testLocale,
            periodId: 999999,
          );
          fail('Should have thrown an exception for non-existent period.');
        } catch (e) {
          expect(e, isA<Exception>());
          expect(e.toString().toLowerCase(), contains('not found'));
          print('Correctly caught error for non-existent period: $e');
        }
      },
      timeout: const Timeout(Duration(seconds: 20)),
    );
  });
}
