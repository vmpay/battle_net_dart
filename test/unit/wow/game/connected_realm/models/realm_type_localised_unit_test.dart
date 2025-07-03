import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_type_localised.dart';
import 'package:test/test.dart';

void main() {
  const RealmTypeLocalised expectedRealmTypeLocalised = RealmTypeLocalised(
    name: NameLocalised(
      itIt: 'Normale',
      ruRu: 'Обычный',
      enGb: 'Normal',
      zhTw: '一般',
      koKr: '일반',
      enUs: 'Normal',
      esMx: 'Normal',
      ptBr: 'Normal',
      esEs: 'Normal',
      zhCn: '普通',
      frFr: 'Normal',
      deDe: 'Normal',
    ),
    type: RealmType.NORMAL,
  );

  group('RealmTypeLocalised', () {
    test('should create an instance from a JSON string', () {
      final RealmTypeLocalised
      realmTypeLocalised = RealmTypeLocalised.fromRawJson(
        '{"name": {"it_IT": "Normale","ru_RU": "Обычный","en_GB": "Normal","zh_TW": "一般","ko_KR": "일반","en_US": "Normal","es_MX": "Normal","pt_BR": "Normal","es_ES": "Normal","zh_CN": "普通","fr_FR": "Normal","de_DE": "Normal"}, "type": "NORMAL"}',
      );
      expect(realmTypeLocalised, equals(expectedRealmTypeLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedRealmTypeLocalised.toRawJson(),
        equals(
          '{"name":{"it_IT":"Normale","ru_RU":"Обычный","en_GB":"Normal","zh_TW":"一般","ko_KR":"일반","en_US":"Normal","es_MX":"Normal","pt_BR":"Normal","es_ES":"Normal","zh_CN":"普通","fr_FR":"Normal","de_DE":"Normal"},"type":"NORMAL"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final RealmTypeLocalised copiedRealmTypeLocalised =
          expectedRealmTypeLocalised.copyWith(type: RealmType.RP);
      expect(copiedRealmTypeLocalised.type, equals(RealmType.RP));
      expect(
        copiedRealmTypeLocalised.name,
        equals(expectedRealmTypeLocalised.name),
      );
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedRealmTypeLocalised.toString(),
        equals(
          'RealmTypeLocalised{name: NameLocalised{itIt: Normale, ruRu: Обычный, enGb: Normal, zhTw: 一般, koKr: 일반, enUs: Normal, esMx: Normal, ptBr: Normal, esEs: Normal, zhCn: 普通, frFr: Normal, deDe: Normal}, type: RealmType.NORMAL}',
        ),
      );
    });
  });
}
