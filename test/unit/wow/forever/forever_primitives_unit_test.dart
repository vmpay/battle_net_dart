import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

void main() {
  group('ForeverCharacterSlug', () {
    test('formats name and surname as lowercase hyphenated slug', () {
      final ForeverCharacterSlug slug = ForeverCharacterSlug(
        name: 'Ada',
        surname: 'Brightwood',
      );
      expect(slug.value, 'ada-brightwood');
      expect(slug.toString(), 'ada-brightwood');
    });

    test('fromSlug preserves provided slug', () {
      const ForeverCharacterSlug slug = ForeverCharacterSlug.fromSlug(
        'thrall-hellscream',
      );
      expect(slug.value, 'thrall-hellscream');
    });

    test('equality and hashCode', () {
      final ForeverCharacterSlug a = ForeverCharacterSlug(
        name: 'Ada',
        surname: 'Brightwood',
      );
      const ForeverCharacterSlug b = ForeverCharacterSlug.fromSlug(
        'ada-brightwood',
      );
      final ForeverCharacterSlug c = ForeverCharacterSlug(
        name: 'Jaina',
        surname: 'Proudmoore',
      );
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(c)));
    });
  });

  group('BattleNetNotFoundException', () {
    test('toString includes url and optional body', () {
      const BattleNetNotFoundException exWithBody = BattleNetNotFoundException(
        url: '/profile/wow/character/ada-brightwood',
        body: 'BLZWEBAPI00000404',
      );
      expect(
        exWithBody.toString(),
        contains('/profile/wow/character/ada-brightwood'),
      );
      expect(exWithBody.toString(), contains('BLZWEBAPI00000404'));

      const BattleNetNotFoundException exNoBody = BattleNetNotFoundException(
        url: '/data/wow/item/1',
      );
      expect(
        exNoBody.toString(),
        'BattleNetNotFoundException: Resource not found at /data/wow/item/1',
      );
    });
  });

  group('BattleNetNamespace Forever values', () {
    test('name returns expected string', () {
      expect(BattleNetNamespace.profileForever.name, 'profile-forever');
      expect(BattleNetNamespace.dynamicForever.name, 'dynamic-forever');
      expect(BattleNetNamespace.staticForever.name, 'static-forever');
      expect(BattleNetNamespace.staticForeverItem.name, 'static-forever');
    });
  });
}
