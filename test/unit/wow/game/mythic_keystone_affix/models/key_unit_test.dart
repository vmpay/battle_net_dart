import 'package:battle_net/src/wow/game/mythic_keystone_affix/models/key.dart';
import 'package:test/test.dart';

void main() {
  group('Key', () {
    test('fromJson', () {
      final Key key = Key.fromJson(const <String, dynamic>{
        'href':
            'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      });
      expect(
        key.href,
        'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
    });

    test('toJson', () {
      const Key key = Key(
        href:
            'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
      expect(key.toJson(), <String, dynamic>{
        'href':
            'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      });
    });

    test('toSring', () {
      const Key key = Key(
        href:
            'https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us',
      );
      expect(
        key.toString(),
        'Key{href: https://us.api.blizzard.com/data/wow/keystone-affix/1?namespace=static-9.2.7_43706-us}',
      );
    });

    test('equality', () {
      const Key key1 = Key(href: 'a');
      const Key key2 = Key(href: 'a');
      const Key key3 = Key(href: 'b');
      expect(key1, key2);
      expect(key1 == key2, isTrue);
      expect(key1 == key3, isFalse);
    });

    test('hashCode', () {
      const Key key1 = Key(href: 'a');
      const Key key2 = Key(href: 'a');
      expect(key1.hashCode, key2.hashCode);
    });
  });
}
