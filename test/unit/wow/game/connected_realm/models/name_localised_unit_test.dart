import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:test/test.dart';

void main() {
  const NameLocalised expectedNameLocalised = NameLocalised(
    itIt: 'Kilrogg',
    ruRu: 'Kilrogg',
    enGb: 'Kilrogg',
    zhTw: '基爾羅格',
    koKr: 'Kilrogg',
    enUs: 'Kilrogg',
    esMx: 'Kilrogg',
    ptBr: 'Kilrogg',
    esEs: 'Kilrogg',
    zhCn: '基尔罗格',
    frFr: 'Kilrogg',
    deDe: 'Kilrogg',
  );

  group('NameLocalised', () {
    test('should create an instance from a JSON string', () {
      final NameLocalised nameLocalised = NameLocalised.fromRawJson(
        '{"it_IT": "Kilrogg","ru_RU": "Kilrogg","en_GB": "Kilrogg","zh_TW": "基爾羅格","ko_KR": "Kilrogg","en_US": "Kilrogg","es_MX": "Kilrogg","pt_BR": "Kilrogg","es_ES": "Kilrogg","zh_CN": "基尔罗格","fr_FR": "Kilrogg","de_DE": "Kilrogg"}',
      );
      expect(nameLocalised, equals(expectedNameLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedNameLocalised.toRawJson(),
        equals(
          '{"it_IT":"Kilrogg","ru_RU":"Kilrogg","en_GB":"Kilrogg","zh_TW":"基爾羅格","ko_KR":"Kilrogg","en_US":"Kilrogg","es_MX":"Kilrogg","pt_BR":"Kilrogg","es_ES":"Kilrogg","zh_CN":"基尔罗格","fr_FR":"Kilrogg","de_DE":"Kilrogg"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final NameLocalised copiedNameLocalised = expectedNameLocalised.copyWith(
        itIt: 'new-it-it',
      );
      expect(copiedNameLocalised.itIt, equals('new-it-it'));
      expect(copiedNameLocalised.ruRu, equals(expectedNameLocalised.ruRu));
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedNameLocalised.toString(),
        equals(
          'NameLocalised{itIt: Kilrogg, ruRu: Kilrogg, enGb: Kilrogg, zhTw: 基爾羅格, koKr: Kilrogg, enUs: Kilrogg, esMx: Kilrogg, ptBr: Kilrogg, esEs: Kilrogg, zhCn: 基尔罗格, frFr: Kilrogg, deDe: Kilrogg}',
        ),
      );
    });
  });
}
