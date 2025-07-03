import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/key.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affix_response.dart';
import 'package:test/test.dart';

void main() {
  group('MythicKeystoneAffixResponse', () {
    test('fromJson', () {
      final MythicKeystoneAffixResponse response =
          MythicKeystoneAffixResponse.fromRawJson('''
        {
          "_links": {
            "self": {
              "href": "https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us"
            }
          },
          "id": 1,
          "name": "Overflowing",
          "description": "Healing in excess of a target's maximum health is instead converted to a heal absorption effect.",
          "media": {
            "key": {
              "href": "https://us.api.blizzard.com/data/wow/media/keystone-affix/1?namespace=static-9.2.7_43706-us"
            },
            "id": 1
          }
        }
      ''');

      expect(
        response.links.self.href,
        'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
      expect(response.id, 1);
      expect(response.name, 'Overflowing');
      expect(
        response.description,
        'Healing in excess of a target\'s maximum health is instead converted to a heal absorption effect.',
      );
      expect(
        response.media.key.href,
        'https://us.api.blizzard.com/data/wow/media/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
      expect(response.media.id, 1);
    });

    test('toRawJson', () {
      const MythicKeystoneAffixResponse response = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'a')),
        id: 1,
        name: 'b',
        description: 'c',
        media: Media(key: Key(href: 'd'), id: 2),
      );
      expect(
        response.toRawJson(),
        '{"_links":{"self":{"href":"a"}},"id":1,"name":"b","description":"c","media":{"key":{"href":"d"},"id":2}}',
      );
    });

    test('equality', () {
      const MythicKeystoneAffixResponse response1 = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'a')),
        id: 1,
        name: 'b',
        description: 'c',
        media: Media(key: Key(href: 'd'), id: 2),
      );
      const MythicKeystoneAffixResponse response2 = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'a')),
        id: 1,
        name: 'b',
        description: 'c',
        media: Media(key: Key(href: 'd'), id: 2),
      );
      const MythicKeystoneAffixResponse response3 = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'z')),
        id: 9,
        name: 'y',
        description: 'x',
        media: Media(key: Key(href: 'w'), id: 8),
      );
      expect(response1, response2);
      expect(response1 == response2, isTrue);
      expect(response1 == response3, isFalse);
    });

    test('hashCode', () {
      const MythicKeystoneAffixResponse response1 = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'a')),
        id: 1,
        name: 'b',
        description: 'c',
        media: Media(key: Key(href: 'd'), id: 2),
      );
      const MythicKeystoneAffixResponse response2 = MythicKeystoneAffixResponse(
        links: Links(self: Self(href: 'a')),
        id: 1,
        name: 'b',
        description: 'c',
        media: Media(key: Key(href: 'd'), id: 2),
      );
      expect(response1.hashCode, response2.hashCode);
    });
  });

  group('Media', () {
    test('toString', () {
      const Media media = Media(key: Key(href: 'd'), id: 2);
      expect(media.toString(), 'Media{key: Key{href: d}, id: 2}');
    });

    test('equality', () {
      const Media media1 = Media(key: Key(href: 'd'), id: 2);
      const Media media2 = Media(key: Key(href: 'd'), id: 2);
      const Media media3 = Media(key: Key(href: 'w'), id: 8);
      expect(media1, media2);
      expect(media1 == media2, isTrue);
      expect(media1 == media3, isFalse);
    });

    test('hashCode', () {
      const Media media1 = Media(key: Key(href: 'd'), id: 2);
      const Media media2 = Media(key: Key(href: 'd'), id: 2);
      expect(media1.hashCode, media2.hashCode);
    });
  });
}
