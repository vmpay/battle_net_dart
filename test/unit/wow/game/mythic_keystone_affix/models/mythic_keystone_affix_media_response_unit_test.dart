import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_media_response.dart';
import 'package:test/test.dart';

void main() {
  group('MythicKeystoneAffixMediaResponse', () {
    test('fromJson', () {
      final MythicKeystoneAffixMediaResponse
      response = MythicKeystoneAffixMediaResponse.fromJson(const <
        String,
        dynamic
      >{
        '_links': <String, Map<String, String>>{
          'self': <String, String>{
            'href':
                'https://us.api.blizzard.com/data/wow/media/keystone-affix/1?namespace=static-9.2.7_43706-us',
          },
        },
        'assets': <Map<String, Object>>[
          <String, Object>{
            'key': 'icon',
            'value':
                'https://render.worldofwarcraft.com/us/icons/56/ability_ironmaidens_whirlofblood.jpg',
            'file_data_id': 1022486,
          },
        ],
        'id': 123,
      });

      expect(
        response.links.self.href,
        'https://us.api.blizzard.com/data/wow/media/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
      expect(response.assets[0].key, 'icon');
      expect(response.id, 123);
    });

    test('toRawJson', () {
      const MythicKeystoneAffixMediaResponse response =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'a')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      expect(
        response.toRawJson(),
        '{"_links":{"self":{"href":"a"}},"assets":[{"key":"a","value":"b","file_data_id":1}],"id":123}',
      );
    });

    test('equality', () {
      const MythicKeystoneAffixMediaResponse response1 =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'a')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      const MythicKeystoneAffixMediaResponse response2 =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'a')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      const MythicKeystoneAffixMediaResponse response3 =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'b')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      expect(response1, response2);
      expect(response1 == response2, isTrue);
      expect(response1 == response3, isFalse);
    });

    test('hashCode', () {
      const MythicKeystoneAffixMediaResponse response1 =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'a')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      const MythicKeystoneAffixMediaResponse response2 =
          MythicKeystoneAffixMediaResponse(
            links: Links(self: Self(href: 'a')),
            assets: <Asset>[Asset(key: 'a', value: 'b', fileDataId: 1)],
            id: 123,
          );
      expect(response1.hashCode, response2.hashCode);
    });
  });

  group('Asset', () {
    test('fromJson', () {
      final Asset asset = Asset.fromJson(const <String, dynamic>{
        'key': 'icon',
        'value':
            'https://render.worldofwarcraft.com/us/icons/56/ability_ironmaidens_whirlofblood.jpg',
        'file_data_id': 1022486,
      });

      expect(asset.key, 'icon');
      expect(
        asset.value,
        'https://render.worldofwarcraft.com/us/icons/56/ability_ironmaidens_whirlofblood.jpg',
      );
      expect(asset.fileDataId, 1022486);
    });

    test('toJson', () {
      const Asset asset = Asset(key: 'a', value: 'b', fileDataId: 1);
      expect(asset.toJson(), <String, dynamic>{
        'key': 'a',
        'value': 'b',
        'file_data_id': 1,
      });
    });

    test('toString', () {
      const Asset asset = Asset(key: 'a', value: 'b', fileDataId: 1);
      expect(asset.toString(), 'Asset{key: a, value: b, fileDataId: 1}');
    });

    test('equality', () {
      const Asset asset1 = Asset(key: 'a', value: 'b', fileDataId: 1);
      const Asset asset2 = Asset(key: 'a', value: 'b', fileDataId: 1);
      const Asset asset3 = Asset(key: 'c', value: 'd', fileDataId: 2);
      expect(asset1, asset2);
      expect(asset1 == asset2, isTrue);
      expect(asset1 == asset3, isFalse);
    });

    test('hashCode', () {
      const Asset asset1 = Asset(key: 'a', value: 'b', fileDataId: 1);
      const Asset asset2 = Asset(key: 'a', value: 'b', fileDataId: 1);
      expect(asset1.hashCode, asset2.hashCode);
    });
  });
}
