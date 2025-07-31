import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/server_status_localised.dart';
import 'package:test/test.dart';

void main() {
  const ServerStatusLocalised expectedServerStatusLocalised =
      ServerStatusLocalised(
        name: NameLocalised(
          itIt: 'Attivo',
          ruRu: 'Работает',
          enGb: 'Up',
          zhTw: '正常',
          koKr: '정상',
          enUs: 'Up',
          esMx: 'Disponible',
          ptBr: 'Para Cima',
          esEs: 'Activo',
          zhCn: '正常',
          frFr: 'En ligne',
          deDe: 'Verfügbar',
        ),
        type: ServerStatus.UP,
      );

  group('ServerStatusLocalised', () {
    test('should create an instance from a JSON string', () {
      final ServerStatusLocalised
      serverStatusLocalised = ServerStatusLocalised.fromRawJson(
        '{"name": {"it_IT": "Attivo","ru_RU": "Работает","en_GB": "Up","zh_TW": "正常","ko_KR": "정상","en_US": "Up","es_MX": "Disponible","pt_BR": "Para Cima","es_ES": "Activo","zh_CN": "正常","fr_FR": "En ligne","de_DE": "Verfügbar"}, "type": "UP"}',
      );
      expect(serverStatusLocalised, equals(expectedServerStatusLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedServerStatusLocalised.toRawJson(),
        equals(
          '{"name":{"it_IT":"Attivo","ru_RU":"Работает","en_GB":"Up","zh_TW":"正常","ko_KR":"정상","en_US":"Up","es_MX":"Disponible","pt_BR":"Para Cima","es_ES":"Activo","zh_CN":"正常","fr_FR":"En ligne","de_DE":"Verfügbar"},"type":"UP"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final ServerStatusLocalised copiedServerStatusLocalised =
          expectedServerStatusLocalised.copyWith(type: ServerStatus.DOWN);
      expect(copiedServerStatusLocalised.type, equals(ServerStatus.DOWN));
      expect(
        copiedServerStatusLocalised.name,
        equals(expectedServerStatusLocalised.name),
      );
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedServerStatusLocalised.toString(),
        equals(
          'ServerStatusLocalised{name: NameLocalised{itIt: Attivo, ruRu: Работает, enGb: Up, zhTw: 正常, koKr: 정상, enUs: Up, esMx: Disponible, ptBr: Para Cima, esEs: Activo, zhCn: 正常, frFr: En ligne, deDe: Verfügbar}, type: ServerStatus.UP}',
        ),
      );
    });
  });
}
