import 'package:battle_net/src/wow/game/connected_realm/models/connected_realm_search_data.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/population_type_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/server_status_localised.dart';
import 'package:test/test.dart';

import '../../../../models/common/name_localised_data.dart';

void main() {
  group('ConnectedRealmSearchData', () {
    test('copyWith', () {
      const ConnectedRealmSearchData data = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );

      final ConnectedRealmSearchData data2 = data.copyWith(id: 2);
      expect(data2.id, 2);
      expect(data.id, 1);
    });

    test('toString', () {
      const ConnectedRealmSearchData data = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );
      expect(
        data.toString(),
        'ConnectedRealmSearchData{realms: [], id: 1, hasQueue: false, status: ServerStatusLocalised{name: NameLocalised{itIt: it_IT, ruRu: ru_RU, enGb: en_GB, zhTw: zh_TW, koKr: ko_KR, enUs: en_US, esMx: es_MX, ptBr: pt_BR, esEs: es_ES, zhCn: zh_CN, frFr: fr_FR, deDe: de_DE}, type: ServerStatus.UP}, population: PopulationTypeLocalised{name: NameLocalised{itIt: it_IT, ruRu: ru_RU, enGb: en_GB, zhTw: zh_TW, koKr: ko_KR, enUs: en_US, esMx: es_MX, ptBr: pt_BR, esEs: es_ES, zhCn: zh_CN, frFr: fr_FR, deDe: de_DE}, type: PopulationType.LOW}}',
      );
    });

    test('equality', () {
      const ConnectedRealmSearchData data1 = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );
      const ConnectedRealmSearchData data2 = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );
      const ConnectedRealmSearchData data3 = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 2,
        hasQueue: true,
        status: ServerStatusLocalised(
          type: ServerStatus.DOWN,
          name: NameLocalisedData.euLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.HIGH,
          name: NameLocalisedData.euLocalised,
        ),
      );
      expect(data1, data2);
      expect(data1 == data2, isTrue);
      expect(data1 == data3, isFalse);
    });

    test('hashCode', () {
      const ConnectedRealmSearchData data1 = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );
      const ConnectedRealmSearchData data2 = ConnectedRealmSearchData(
        realms: <RealmLocalised>[],
        id: 1,
        hasQueue: false,
        status: ServerStatusLocalised(
          type: ServerStatus.UP,
          name: NameLocalisedData.usLocalised,
        ),
        population: PopulationTypeLocalised(
          type: PopulationType.LOW,
          name: NameLocalisedData.usLocalised,
        ),
      );
      expect(data1.hashCode, data2.hashCode);
    });
  });
}
