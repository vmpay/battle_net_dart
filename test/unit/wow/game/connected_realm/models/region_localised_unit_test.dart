import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/region_localised.dart';
import 'package:test/test.dart';

void main() {
  const RegionLocalised expectedRegionLocalised = RegionLocalised(
    name: NameLocalised(
      itIt: 'Nord America',
      ruRu: 'Северная Америка',
      enGb: 'North America',
      zhTw: '北美',
      koKr: '미국',
      enUs: 'North America',
      esMx: 'Norteamérica',
      ptBr: 'América do Norte',
      esEs: 'Norteamérica',
      zhCn: '北美',
      frFr: 'Amérique du Nord',
      deDe: 'Nordamerika',
    ),
    id: 1,
  );

  group('RegionLocalised', () {
    test('should create an instance from a JSON string', () {
      final RegionLocalised regionLocalised = RegionLocalised.fromRawJson(
        '{"name": {"it_IT": "Nord America","ru_RU": "Северная Америка","en_GB": "North America","zh_TW": "北美","ko_KR": "미국","en_US": "North America","es_MX": "Norteamérica","pt_BR": "América do Norte","es_ES": "Norteamérica","zh_CN": "北美","fr_FR": "Amérique du Nord","de_DE": "Nordamerika"}, "id": 1}',
      );
      expect(regionLocalised, equals(expectedRegionLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedRegionLocalised.toRawJson(),
        equals(
          '{"name":{"it_IT":"Nord America","ru_RU":"Северная Америка","en_GB":"North America","zh_TW":"北美","ko_KR":"미국","en_US":"North America","es_MX":"Norteamérica","pt_BR":"América do Norte","es_ES":"Norteamérica","zh_CN":"北美","fr_FR":"Amérique du Nord","de_DE":"Nordamerika"},"id":1}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final RegionLocalised copiedRegionLocalised = expectedRegionLocalised
          .copyWith(id: 2);
      expect(copiedRegionLocalised.id, equals(2));
      expect(copiedRegionLocalised.name, equals(expectedRegionLocalised.name));
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedRegionLocalised.toString(),
        equals(
          'RegionLocalised{name: NameLocalised{itIt: Nord America, ruRu: Северная Америка, enGb: North America, zhTw: 北美, koKr: 미국, enUs: North America, esMx: Norteamérica, ptBr: América do Norte, esEs: Norteamérica, zhCn: 北美, frFr: Amérique du Nord, deDe: Nordamerika}, id: 1}',
        ),
      );
    });
  });
}
