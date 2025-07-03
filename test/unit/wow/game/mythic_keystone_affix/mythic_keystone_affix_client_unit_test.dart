// test/unit/wow/game/mythic_keystone_affix/mythic_keystone_affix_client_unit_test.dart
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_media_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affixes_index_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/mythic_keystone_affix_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

const String sampleMythicKeystoneAffixesIndexJson = '''
{
    "_links": {
        "self": {
            "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/?namespace=static-11.1.7_61131-eu"
        }
    },
    "affixes": [
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-11.1.7_61131-eu"
            },
            "name": "Overflowing",
            "id": 1
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/2?namespace=static-11.1.7_61131-eu"
            },
            "name": "Skittish",
            "id": 2
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/3?namespace=static-11.1.7_61131-eu"
            },
            "name": "Volcanic",
            "id": 3
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/4?namespace=static-11.1.7_61131-eu"
            },
            "name": "Necrotic",
            "id": 4
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/5?namespace=static-11.1.7_61131-eu"
            },
            "name": "Teeming",
            "id": 5
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/6?namespace=static-11.1.7_61131-eu"
            },
            "name": "Raging",
            "id": 6
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/7?namespace=static-11.1.7_61131-eu"
            },
            "name": "Bolstering",
            "id": 7
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/8?namespace=static-11.1.7_61131-eu"
            },
            "name": "Sanguine",
            "id": 8
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/9?namespace=static-11.1.7_61131-eu"
            },
            "name": "Tyrannical",
            "id": 9
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/10?namespace=static-11.1.7_61131-eu"
            },
            "name": "Fortified",
            "id": 10
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/11?namespace=static-11.1.7_61131-eu"
            },
            "name": "Bursting",
            "id": 11
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/12?namespace=static-11.1.7_61131-eu"
            },
            "name": "Grievous",
            "id": 12
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/13?namespace=static-11.1.7_61131-eu"
            },
            "name": "Explosive",
            "id": 13
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/14?namespace=static-11.1.7_61131-eu"
            },
            "name": "Quaking",
            "id": 14
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/16?namespace=static-11.1.7_61131-eu"
            },
            "name": "Infested",
            "id": 16
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/117?namespace=static-11.1.7_61131-eu"
            },
            "name": "Reaping",
            "id": 117
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/119?namespace=static-11.1.7_61131-eu"
            },
            "name": "Beguiling",
            "id": 119
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/120?namespace=static-11.1.7_61131-eu"
            },
            "name": "Awakened",
            "id": 120
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/128?namespace=static-11.1.7_61131-eu"
            },
            "name": "Tormented",
            "id": 128
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/129?namespace=static-11.1.7_61131-eu"
            },
            "name": "Infernal",
            "id": 129
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/121?namespace=static-11.1.7_61131-eu"
            },
            "name": "Prideful",
            "id": 121
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/122?namespace=static-11.1.7_61131-eu"
            },
            "name": "Inspiring",
            "id": 122
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/123?namespace=static-11.1.7_61131-eu"
            },
            "name": "Spiteful",
            "id": 123
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/124?namespace=static-11.1.7_61131-eu"
            },
            "name": "Storming",
            "id": 124
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/130?namespace=static-11.1.7_61131-eu"
            },
            "name": "Encrypted",
            "id": 130
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/135?namespace=static-11.1.7_61131-eu"
            },
            "name": "Afflicted",
            "id": 135
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/136?namespace=static-11.1.7_61131-eu"
            },
            "name": "Incorporeal",
            "id": 136
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/132?namespace=static-11.1.7_61131-eu"
            },
            "name": "Thundering",
            "id": 132
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/131?namespace=static-11.1.7_61131-eu"
            },
            "name": "Shrouded",
            "id": 131
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/144?namespace=static-11.1.7_61131-eu"
            },
            "name": "Thorned",
            "id": 144
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/133?namespace=static-11.1.7_61131-eu"
            },
            "name": "Focused",
            "id": 133
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/134?namespace=static-11.1.7_61131-eu"
            },
            "name": "Entangling",
            "id": 134
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/137?namespace=static-11.1.7_61131-eu"
            },
            "name": "Shielding",
            "id": 137
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/145?namespace=static-11.1.7_61131-eu"
            },
            "name": "Reckless",
            "id": 145
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/146?namespace=static-11.1.7_61131-eu"
            },
            "name": "Attuned",
            "id": 146
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/158?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Voidbound",
            "id": 158
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/153?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Frenzied",
            "id": 153
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/162?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Pulsar",
            "id": 162
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/152?namespace=static-11.1.7_61131-eu"
            },
            "name": "Challenger's Peril",
            "id": 152
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/165?namespace=static-11.1.7_61131-eu"
            },
            "name": null,
            "id": 165
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/148?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Ascendant",
            "id": 148
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/147?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Guile",
            "id": 147
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/159?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Oblivion",
            "id": 159
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/keystone-affix/160?namespace=static-11.1.7_61131-eu"
            },
            "name": "Xal'atath's Bargain: Devour",
            "id": 160
        }
    ]
}''';
const String sampleMythicKeystoneAffixJson = '''
{
    "_links": {
        "self": {
            "href": "https://us.api.blizzard.com/data/wow/keystone-affix/10?namespace=static-11.1.7_61131-us"
        }
    },
    "id": 10,
    "name": "Fortified",
    "description": "Non-boss enemies have 20% more health and inflict up to 20% increased damage.",
    "media": {
        "key": {
            "href": "https://us.api.blizzard.com/data/wow/media/keystone-affix/10?namespace=static-11.1.7_61131-us"
        },
        "id": 10
    }
}''';
const String sampleMythicKeystoneAffixMediaJson = '''
{
  "_links": {
    "self": {
      "href": "https://us.api.blizzard.com/data/wow/media/keystone-affix/1?namespace=static-11.1.7_61131-us"
    }
  },
  "assets": [
    {
      "key": "icon",
      "value": "https://render.worldofwarcraft.com/us/icons/56/inv_misc_volatilewater.jpg",
      "file_data_id": 463570
    }
  ],
  "id": 1
}''';

void main() {
  group('MythicKeystoneAffixClient Unit Tests', () {
    late MythicKeystoneAffixClient affixClient;
    late MockClient mockHttpClient;

    const String accessToken = 'dummy_access_token';
    const BattleNetRegion region = BattleNetRegion.us;
    const BattleNetLocale locale = BattleNetLocale.enUS;
    const int connectionTimeout = 5000;

    setUp(() {
      // MockClient will be created with a handler in each test
      Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
    });

    // --- Tests for getMythicKeystoneAffixesIndex ---
    test('getMythicKeystoneAffixesIndex - success', () async {
      mockHttpClient = MockClient((http.Request request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/data/wow/keystone-affix/index');
        expect(request.headers['Authorization'], 'Bearer $accessToken');
        return http.Response(
          sampleMythicKeystoneAffixesIndexJson,
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });

      affixClient = MythicKeystoneAffixClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );
      final MythicKeystoneAffixesIndexResponse result = await affixClient
          .getMythicKeystoneAffixesIndex(
            accessToken: accessToken,
            region: region,
            namespace: BattleNetNamespace.dynamic,
            locale: locale,
          );

      expect(result.affixes, isNotEmpty);
      expect(result.affixes.length, 44);
      expect(result.affixes.first.id, 1);
    });

    test('getMythicKeystoneAffixesIndex - API error', () async {
      mockHttpClient = MockClient((http.Request request) async {
        return http.Response('{"error":"failed"}', 500);
      });
      affixClient = MythicKeystoneAffixClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );

      expect(
        () => affixClient.getMythicKeystoneAffixesIndex(
          accessToken: accessToken,
          region: region,
          namespace: BattleNetNamespace.dynamic,
          locale: locale,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // --- Tests for getMythicKeystoneAffix ---
    test('getMythicKeystoneAffix - success', () async {
      mockHttpClient = MockClient((http.Request request) async {
        expect(request.url.path, '/data/wow/keystone-affix/10');
        return http.Response(
          sampleMythicKeystoneAffixJson,
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      affixClient = MythicKeystoneAffixClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );

      final MythicKeystoneAffixResponse result = await affixClient
          .getMythicKeystoneAffix(
            accessToken: accessToken,
            region: region,
            namespace: BattleNetNamespace.dynamic,
            locale: locale,
            keystoneAffixId: 10,
          );
      expect(result.id, 10);
      expect(result.name.toString(), contains('Fortified'));
      expect(result.media.id, 10);
    });

    // --- Tests for getMythicKeystoneAffixMedia ---
    test('getMythicKeystoneAffixMedia - success', () async {
      mockHttpClient = MockClient((http.Request request) async {
        expect(request.url.path, '/data/wow/media/keystone-affix/10');
        return http.Response(
          sampleMythicKeystoneAffixMediaJson,
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      affixClient = MythicKeystoneAffixClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );

      final MythicKeystoneAffixMediaResponse result = await affixClient
          .getMythicKeystoneAffixMedia(
            accessToken: accessToken,
            region: region,
            namespace: BattleNetNamespace.static,
            locale: locale,
            keystoneAffixId: 10,
          );
      expect(result.id, 1);
      expect(result.assets, isNotEmpty);
      expect(result.assets.first.key, 'icon');
    });
  });
}
