// test/integration/wow/game/mythic_keystone_affix/get_mythic_keystone_affix_data_integration_test.dart
import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/oauth/models/client_credentials_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_media_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affixes_index_response.dart';
import 'package:test/test.dart';

import '../../../credentials.dart';

void main() {
  group('Mythic Keystone Affix Data Integration Tests', () {
    late BattleNet battleNet;
    late String accessToken;

    int knownAffixId = 10;

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

        try {
          final MythicKeystoneAffixesIndexResponse affixesIndex =
              await battleNet.getMythicKeystoneAffixesIndex(
                accessToken: accessToken,
                region: BattleNetRegion.us,
                namespace: BattleNetNamespace.dynamic,
                locale: BattleNetLocale.enUS,
              );
          if (affixesIndex.affixes.isNotEmpty) {
            knownAffixId = affixesIndex.affixes.first.id;
            print(
              'Dynamically fetched affix ID for tests: $knownAffixId (${affixesIndex.affixes.first.name})',
            );
          } else {
            print(
              'Warning: Affix index was empty. Using default knownAffixId: $knownAffixId',
            );
          }
        } catch (e) {
          print(
            'Warning: Could not fetch dynamic affix ID for testing, using default $knownAffixId. Error: $e',
          );
        }
      } catch (e) {
        throw Exception(
          'Failed to get access token for integration tests: $e. Ensure credentials are valid and Battle.net services are reachable.',
        );
      }
    });

    // Consistent test parameters
    const BattleNetRegion testRegion = BattleNetRegion.us;
    const BattleNetLocale testLocale = BattleNetLocale.enUS;
    const Duration defaultTimeout = Duration(seconds: 30);

    test(
      'should return a valid Mythic Keystone Affixes Index',
      () async {
        final MythicKeystoneAffixesIndexResponse response = await battleNet
            .getMythicKeystoneAffixesIndex(
              accessToken: accessToken,
              region: testRegion,
              namespace: BattleNetNamespace.static,
              locale: testLocale,
            );

        expect(response, isNotNull);
        expect(response, isA<MythicKeystoneAffixesIndexResponse>());
        expect(
          response.links,
          isNotNull,
          reason: 'Response _links should not be null',
        );
        expect(
          response.links.self,
          isNotNull,
          reason: '_links.self should not be null',
        );
        expect(response.links.self.href, contains('/data/wow/keystone-affix/'));

        expect(response.affixes, isNotNull);
        expect(response.affixes, isA<List<KeyNameIdData>>());
        expect(
          response.affixes,
          isNotEmpty,
          reason: 'Affixes list should not be empty',
        );

        final KeyNameIdData firstAffix = response.affixes.first;
        expect(firstAffix.id, isA<int>());
        expect(firstAffix.id, greaterThan(0));
        expect(firstAffix.name, isA<String>());
        expect(firstAffix.name, isNotEmpty);
        expect(firstAffix.key, isNotNull);
        expect(firstAffix.key.href, contains('/data/wow/keystone-affix/'));

        print(
          'Successfully fetched Mythic Keystone Affixes Index for ${testRegion.name}. Found ${response.affixes.length} affixes. First: ${firstAffix.name} (ID: ${firstAffix.id})',
        );
      },
      timeout: const Timeout(defaultTimeout),
    );

    test(
      'should return a valid Mythic Keystone Affix by ID',
      () async {
        final MythicKeystoneAffixResponse response = await battleNet
            .getMythicKeystoneAffix(
              accessToken: accessToken,
              region: testRegion,
              namespace: BattleNetNamespace.static,
              locale: testLocale,
              keystoneAffixId: knownAffixId,
            );

        expect(response, isNotNull);
        expect(response, isA<MythicKeystoneAffixResponse>());
        expect(response.id, knownAffixId);

        expect(response.links, isNotNull);
        expect(
          response.links.self.href,
          contains('/data/wow/keystone-affix/$knownAffixId'),
        );

        expect(response.name, isNotNull);
        expect(response.name, isA<String>());
        expect(
          response.name.toString(),
          isNotEmpty,
          reason: 'Affix name should not be empty',
        );

        expect(response.description, isNotNull);
        expect(response.description, isA<String>());
        expect(
          response.description.toString(),
          isNotEmpty,
          reason: 'Affix description should not be empty',
        );

        expect(
          response.media,
          isNotNull,
          reason: 'Affix media link should not be null',
        );
        expect(response.media.id, isA<int>());
        expect(response.media.id, greaterThan(0));
        expect(
          response.media.key.href,
          contains('/data/wow/media/keystone-affix/'),
        );

        print(
          'Successfully fetched Mythic Keystone Affix for ID $knownAffixId: ${response.name}',
        );
      },
      timeout: const Timeout(defaultTimeout),
    );

    test(
      'should return valid Media for a Mythic Keystone Affix by ID',
      () async {
        final MythicKeystoneAffixMediaResponse response = await battleNet
            .getMythicKeystoneAffixMedia(
              accessToken: accessToken,
              region: testRegion,
              namespace: BattleNetNamespace.static,
              locale: testLocale,
              keystoneAffixId: knownAffixId,
            );

        expect(response, isNotNull);
        expect(response, isA<MythicKeystoneAffixMediaResponse>());
        // Some media endpoints include the original entity ID in the response for context
        expect(
          response.id,
          knownAffixId,
          reason: 'Media response should include the affix ID',
        );

        expect(response.links, isNotNull);
        expect(
          response.links.self.href,
          contains('/data/wow/media/keystone-affix/$knownAffixId'),
        );

        expect(response.assets, isNotNull);
        expect(response.assets, isA<List<Asset>>());
        expect(
          response.assets,
          isNotEmpty,
          reason: 'Assets list should not be empty for affix media',
        );

        final Asset firstAsset = response.assets.first;
        expect(firstAsset.key, isA<String>()); // e.g., "icon"
        expect(firstAsset.key, isNotEmpty);
        expect(firstAsset.value, isA<String>()); // URL
        expect(
          firstAsset.value,
          startsWith('http'),
          reason: 'Asset value should be a URL',
        );
        expect(firstAsset.fileDataId, isA<int>());

        print(
          'Successfully fetched Media for Mythic Keystone Affix ID $knownAffixId. First asset key: "${firstAsset.key}"',
        );
      },
      timeout: const Timeout(defaultTimeout),
    );

    test(
      'getMythicKeystoneAffix - should fail for non-existent affix ID',
      () async {
        const int nonExistentAffixId =
            9999999; // An ID that is extremely unlikely to exist
        try {
          await battleNet.getMythicKeystoneAffix(
            accessToken: accessToken,
            region: testRegion,
            namespace: BattleNetNamespace.dynamic,
            locale: testLocale,
            keystoneAffixId: nonExistentAffixId,
          );
          fail(
            'Expected an exception for a non-existent affix ID, but none was thrown.',
          );
        } catch (e) {
          expect(e, isA<Exception>());
          expect(
            e.toString().toLowerCase(),
            contains('not found'),
            reason: 'Error message should indicate an API error',
          );
          print(
            'Correctly caught error for non-existent affix ID $nonExistentAffixId: $e',
          );
        }
      },
      timeout: const Timeout(defaultTimeout),
    );
  });
}
