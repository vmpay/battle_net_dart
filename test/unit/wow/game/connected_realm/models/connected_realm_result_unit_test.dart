import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/connected_realm_result.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/connected_realm_search_data.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/population_type_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_type_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/region_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/server_status_localised.dart';
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
  const RealmLocalised expectedRealmLocalised = RealmLocalised(
    isTournament: false,
    timezone: RealmTimezone.AMERICA_LOS_ANGELES,
    name: expectedNameLocalised,
    id: 4,
    region: expectedRegionLocalised,
    category: NameLocalised(
      itIt: 'Stati Uniti',
      ruRu: 'США',
      enGb: 'United States',
      zhTw: '美國',
      koKr: '미국',
      enUs: 'United States',
      esMx: 'Estados Unidos',
      ptBr: 'Estados Unidos',
      esEs: 'Estados Unidos',
      zhCn: '美国',
      frFr: 'États-Unis',
      deDe: 'Vereinigte Staaten',
    ),
    locale: RealmLocale.EN_US,
    type: expectedRealmTypeLocalised,
    slug: 'kilrogg',
  );
  const ConnectedRealmSearchData expectedConnectedRealmSearchData =
      ConnectedRealmSearchData(
        realms: <RealmLocalised>[expectedRealmLocalised],
        id: 4,
        hasQueue: false,
        status: expectedServerStatusLocalised,
        population: expectedPopulationTypeLocalised,
      );
  const ConnectedRealmResult
  expectedConnectedRealmResult = ConnectedRealmResult(
    key: Self(
      href:
          'https://us.api.blizzard.com/data/wow/connected-realm/4?namespace=dynamic-us',
    ),
    data: expectedConnectedRealmSearchData,
  );

  group('ConnectedRealmResult', () {
    test('should create an instance from a JSON string', () {
      final ConnectedRealmResult
      connectedRealmResult = ConnectedRealmResult.fromRawJson(
        '{"key": {"href": "https://us.api.blizzard.com/data/wow/connected-realm/4?namespace=dynamic-us"}, "data": {"realms": [{"is_tournament": false,"timezone": "America/Los_Angeles","name": {"it_IT": "Kilrogg","ru_RU": "Kilrogg","en_GB": "Kilrogg","zh_TW": "基爾羅格","ko_KR": "Kilrogg","en_US": "Kilrogg","es_MX": "Kilrogg","pt_BR": "Kilrogg","es_ES": "Kilrogg","zh_CN": "基尔罗格","fr_FR": "Kilrogg","de_DE": "Kilrogg"},"id": 4,"region": {"name": {"it_IT": "Nord America","ru_RU": "Северная Америка","en_GB": "North America","zh_TW": "北美","ko_KR": "미국","en_US": "North America","es_MX": "Norteamérica","pt_BR": "América do Norte","es_ES": "Norteamérica","zh_CN": "北美","fr_FR": "Amérique du Nord","de_DE": "Nordamerika"},"id": 1},"category": {"it_IT": "Stati Uniti","ru_RU": "США","en_GB": "United States","zh_TW": "美國","ko_KR": "미국","en_US": "United States","es_MX": "Estados Unidos","pt_BR": "Estados Unidos","es_ES": "Estados Unidos","zh_CN": "美国","fr_FR": "États-Unis","de_DE": "Vereinigte Staaten"},"locale": "enUS","type": {"name": {"it_IT": "Normale","ru_RU": "Обычный","en_GB": "Normal","zh_TW": "一般","ko_KR": "일반","en_US": "Normal","es_MX": "Normal","pt_BR": "Normal","es_ES": "Normal","zh_CN": "普通","fr_FR": "Normal","de_DE": "Normal"},"type": "NORMAL"},"slug": "kilrogg"}],"id": 4,"has_queue": false,"status": {"name": {"it_IT": "Attivo","ru_RU": "Работает","en_GB": "Up","zh_TW": "正常","ko_KR": "정상","en_US": "Up","es_MX": "Disponible","pt_BR": "Para Cima","es_ES": "Activo","zh_CN": "正常","fr_FR": "En ligne","de_DE": "Verfügbar"},"type": "UP"},"population": {"name": {"it_IT": "Saturo","ru_RU": "Нет мест","en_GB": "Full","zh_TW": "滿","ko_KR": "정원초과","en_US": "Full","es_MX": "Lleno","pt_BR": "Completo","es_ES": "Lleno","zh_CN": "满","fr_FR": "Complet","de_DE": "Voll"},"type": "FULL"}}}',
      );
      expect(connectedRealmResult, equals(expectedConnectedRealmResult));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedConnectedRealmResult.toRawJson(),
        equals(
          '{"key":{"href":"https://us.api.blizzard.com/data/wow/connected-realm/4?namespace=dynamic-us"},"data":{"realms":[{"is_tournament":false,"timezone":"America/Los_Angeles","name":{"it_IT":"Kilrogg","ru_RU":"Kilrogg","en_GB":"Kilrogg","zh_TW":"基爾羅格","ko_KR":"Kilrogg","en_US":"Kilrogg","es_MX":"Kilrogg","pt_BR":"Kilrogg","es_ES":"Kilrogg","zh_CN":"基尔罗格","fr_FR":"Kilrogg","de_DE":"Kilrogg"},"id":4,"region":{"name":{"it_IT":"Nord America","ru_RU":"Северная Америка","en_GB":"North America","zh_TW":"北美","ko_KR":"미국","en_US":"North America","es_MX":"Norteamérica","pt_BR":"América do Norte","es_ES":"Norteamérica","zh_CN":"北美","fr_FR":"Amérique du Nord","de_DE":"Nordamerika"},"id":1},"category":{"it_IT":"Stati Uniti","ru_RU":"США","en_GB":"United States","zh_TW":"美國","ko_KR":"미국","en_US":"United States","es_MX":"Estados Unidos","pt_BR":"Estados Unidos","es_ES":"Estados Unidos","zh_CN":"美国","fr_FR":"États-Unis","de_DE":"Vereinigte Staaten"},"locale":"enUS","type":{"name":{"it_IT":"Normale","ru_RU":"Обычный","en_GB":"Normal","zh_TW":"一般","ko_KR":"일반","en_US":"Normal","es_MX":"Normal","pt_BR":"Normal","es_ES":"Normal","zh_CN":"普通","fr_FR":"Normal","de_DE":"Normal"},"type":"NORMAL"},"slug":"kilrogg"}],"id":4,"has_queue":false,"status":{"name":{"it_IT":"Attivo","ru_RU":"Работает","en_GB":"Up","zh_TW":"正常","ko_KR":"정상","en_US":"Up","es_MX":"Disponible","pt_BR":"Para Cima","es_ES":"Activo","zh_CN":"正常","fr_FR":"En ligne","de_DE":"Verfügbar"},"type":"UP"},"population":{"name":{"it_IT":"Saturo","ru_RU":"Нет мест","en_GB":"Full","zh_TW":"滿","ko_KR":"정원초과","en_US":"Full","es_MX":"Lleno","pt_BR":"Completo","es_ES":"Lleno","zh_CN":"满","fr_FR":"Complet","de_DE":"Voll"},"type":"FULL"}}}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final ConnectedRealmResult copiedConnectedRealmResult =
          expectedConnectedRealmResult.copyWith(
            key: const Self(href: 'new-href'),
          );
      expect(copiedConnectedRealmResult.key.href, equals('new-href'));
      expect(
        copiedConnectedRealmResult.data,
        equals(expectedConnectedRealmResult.data),
      );
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedConnectedRealmResult.toString(),
        equals(
          'ConnectedRealmResult{key: Self{href: https://us.api.blizzard.com/data/wow/connected-realm/4?namespace=dynamic-us}, data: ConnectedRealmSearchData{realms: [RealmLocalised{isTournament: false, timezone: RealmTimezone.AMERICA_LOS_ANGELES, name: NameLocalised{itIt: Kilrogg, ruRu: Kilrogg, enGb: Kilrogg, zhTw: 基爾羅格, koKr: Kilrogg, enUs: Kilrogg, esMx: Kilrogg, ptBr: Kilrogg, esEs: Kilrogg, zhCn: 基尔罗格, frFr: Kilrogg, deDe: Kilrogg}, id: 4, region: RegionLocalised{name: NameLocalised{itIt: Nord America, ruRu: Северная Америка, enGb: North America, zhTw: 北美, koKr: 미국, enUs: North America, esMx: Norteamérica, ptBr: América do Norte, esEs: Norteamérica, zhCn: 北美, frFr: Amérique du Nord, deDe: Nordamerika}, id: 1}, category: NameLocalised{itIt: Stati Uniti, ruRu: США, enGb: United States, zhTw: 美國, koKr: 미국, enUs: United States, esMx: Estados Unidos, ptBr: Estados Unidos, esEs: Estados Unidos, zhCn: 美国, frFr: États-Unis, deDe: Vereinigte Staaten}, locale: RealmLocale.EN_US, type: RealmTypeLocalised{name: NameLocalised{itIt: Normale, ruRu: Обычный, enGb: Normal, zhTw: 一般, koKr: 일반, enUs: Normal, esMx: Normal, ptBr: Normal, esEs: Normal, zhCn: 普通, frFr: Normal, deDe: Normal}, type: RealmType.NORMAL}, slug: kilrogg}], id: 4, hasQueue: false, status: ServerStatusLocalised{name: NameLocalised{itIt: Attivo, ruRu: Работает, enGb: Up, zhTw: 正常, koKr: 정상, enUs: Up, esMx: Disponible, ptBr: Para Cima, esEs: Activo, zhCn: 正常, frFr: En ligne, deDe: Verfügbar}, type: ServerStatus.UP}, population: PopulationTypeLocalised{name: NameLocalised{itIt: Saturo, ruRu: Нет мест, enGb: Full, zhTw: 滿, koKr: 정원초과, enUs: Full, esMx: Lleno, ptBr: Completo, esEs: Lleno, zhCn: 满, frFr: Complet, deDe: Voll}, type: PopulationType.FULL}}}',
        ),
      );
    });
  });
}
