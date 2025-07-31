import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/population_type_localised.dart';
import 'package:test/test.dart';

void main() {
  const PopulationTypeLocalised expectedPopulationTypeLocalised =
      PopulationTypeLocalised(
        name: NameLocalised(
          itIt: 'Saturo',
          ruRu: 'Нет мест',
          enGb: 'Full',
          zhTw: '滿',
          koKr: '정원초과',
          enUs: 'Full',
          esMx: 'Lleno',
          ptBr: 'Completo',
          esEs: 'Lleno',
          zhCn: '满',
          frFr: 'Complet',
          deDe: 'Voll',
        ),
        type: PopulationType.FULL,
      );

  group('PopulationTypeLocalised', () {
    test('should create an instance from a JSON string', () {
      final PopulationTypeLocalised
      populationTypeLocalised = PopulationTypeLocalised.fromRawJson(
        '{"name": {"it_IT": "Saturo","ru_RU": "Нет мест","en_GB": "Full","zh_TW": "滿","ko_KR": "정원초과","en_US": "Full","es_MX": "Lleno","pt_BR": "Completo","es_ES": "Lleno","zh_CN": "满","fr_FR": "Complet","de_DE": "Voll"}, "type": "FULL"}',
      );
      expect(populationTypeLocalised, equals(expectedPopulationTypeLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedPopulationTypeLocalised.toRawJson(),
        equals(
          '{"name":{"it_IT":"Saturo","ru_RU":"Нет мест","en_GB":"Full","zh_TW":"滿","ko_KR":"정원초과","en_US":"Full","es_MX":"Lleno","pt_BR":"Completo","es_ES":"Lleno","zh_CN":"满","fr_FR":"Complet","de_DE":"Voll"},"type":"FULL"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final PopulationTypeLocalised copiedPopulationTypeLocalised =
          expectedPopulationTypeLocalised.copyWith(type: PopulationType.LOW);
      expect(copiedPopulationTypeLocalised.type, equals(PopulationType.LOW));
      expect(
        copiedPopulationTypeLocalised.name,
        equals(expectedPopulationTypeLocalised.name),
      );
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedPopulationTypeLocalised.toString(),
        equals(
          'PopulationTypeLocalised{name: NameLocalised{itIt: Saturo, ruRu: Нет мест, enGb: Full, zhTw: 滿, koKr: 정원초과, enUs: Full, esMx: Lleno, ptBr: Completo, esEs: Lleno, zhCn: 满, frFr: Complet, deDe: Voll}, type: PopulationType.FULL}',
        ),
      );
    });
  });
}
