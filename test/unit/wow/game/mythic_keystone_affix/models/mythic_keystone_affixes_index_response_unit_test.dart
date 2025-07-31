import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/key.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/mythic_keystone_affixes_index_response.dart';
import 'package:test/test.dart';

void main() {
  group('MythicKeystoneAffixesIndexResponse', () {
    test('fromJson', () {
      final MythicKeystoneAffixesIndexResponse response =
          MythicKeystoneAffixesIndexResponse.fromRawJson('''
        {
          "_links": {
            "self": {
              "href": "https://us.api.blizzard.com/data/wow/keystone-affix/index?namespace=static-9.2.7_43706-us"
            }
          },
          "affixes": [
            {
              "key": {
                "href": "https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us"
              },
              "name": "Overflowing",
              "id": 1
            }
          ]
        }
      ''');

      expect(
        response.links.self.href,
        'https://us.api.blizzard.com/data/wow/keystone-affix/index?namespace=static-9.2.7_43706-us',
      );
      expect(response.affixes[0].name, 'Overflowing');
    });

    test('toRawJson', () {
      const MythicKeystoneAffixesIndexResponse response =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'a')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'b'),
                name: 'c',
                id: 1,
              ),
            ],
          );
      expect(
        response.toRawJson(),
        '{"_links":{"self":{"href":"a"}},"affixes":[{"key":{"href":"b"},"name":"c","id":1}]}',
      );
    });

    test('equality', () {
      const MythicKeystoneAffixesIndexResponse response1 =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'a')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'b'),
                name: 'c',
                id: 1,
              ),
            ],
          );
      const MythicKeystoneAffixesIndexResponse response2 =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'a')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'b'),
                name: 'c',
                id: 1,
              ),
            ],
          );
      const MythicKeystoneAffixesIndexResponse response3 =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'z')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'y'),
                name: 'x',
                id: 2,
              ),
            ],
          );
      expect(response1, response2);
      expect(response1 == response2, isTrue);
      expect(response1 == response3, isFalse);
    });

    test('hashCode', () {
      const MythicKeystoneAffixesIndexResponse response1 =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'a')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'b'),
                name: 'c',
                id: 1,
              ),
            ],
          );
      const MythicKeystoneAffixesIndexResponse response2 =
          MythicKeystoneAffixesIndexResponse(
            links: Links(self: Self(href: 'a')),
            affixes: <KeyNameIdData>[
              KeyNameIdData(
                key: Key(href: 'b'),
                name: 'c',
                id: 1,
              ),
            ],
          );
      expect(response1.hashCode, response2.hashCode);
    });
  });

  group('KeyNameIdData', () {
    test('toString', () {
      const KeyNameIdData data = KeyNameIdData(
        key: Key(href: 'b'),
        name: 'c',
        id: 1,
      );
      expect(
        data.toString(),
        'KeyNameIdData{key: Key{href: b}, name: c, id: 1}',
      );
    });

    test('equality', () {
      const KeyNameIdData data1 = KeyNameIdData(
        key: Key(href: 'b'),
        name: 'c',
        id: 1,
      );
      const KeyNameIdData data2 = KeyNameIdData(
        key: Key(href: 'b'),
        name: 'c',
        id: 1,
      );
      const KeyNameIdData data3 = KeyNameIdData(
        key: Key(href: 'y'),
        name: 'x',
        id: 2,
      );
      expect(data1, data2);
      expect(data1 == data2, isTrue);
      expect(data1 == data3, isFalse);
    });

    test('hashCode', () {
      const KeyNameIdData data1 = KeyNameIdData(
        key: Key(href: 'b'),
        name: 'c',
        id: 1,
      );
      const KeyNameIdData data2 = KeyNameIdData(
        key: Key(href: 'b'),
        name: 'c',
        id: 1,
      );
      expect(data1.hashCode, data2.hashCode);
    });
  });
}
