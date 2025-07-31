import 'package:battle_net/src/wow/game/connected_realm/models/name_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/realm_type_localised.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/region_localised.dart';
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

  group('RealmLocalised', () {
    test('should create an instance from a JSON string', () {
      final RealmLocalised realmLocalised = RealmLocalised.fromRawJson(
        '{"is_tournament": false,"timezone": "America/Los_Angeles","name": {"it_IT": "Kilrogg","ru_RU": "Kilrogg","en_GB": "Kilrogg","zh_TW": "基爾羅格","ko_KR": "Kilrogg","en_US": "Kilrogg","es_MX": "Kilrogg","pt_BR": "Kilrogg","es_ES": "Kilrogg","zh_CN": "基尔罗格","fr_FR": "Kilrogg","de_DE": "Kilrogg"},"id": 4,"region": {"name": {"it_IT": "Nord America","ru_RU": "Северная Америка","en_GB": "North America","zh_TW": "北美","ko_KR": "미국","en_US": "North America","es_MX": "Norteamérica","pt_BR": "América do Norte","es_ES": "Norteamérica","zh_CN": "北美","fr_FR": "Amérique du Nord","de_DE": "Nordamerika"},"id": 1},"category": {"it_IT": "Stati Uniti","ru_RU": "США","en_GB": "United States","zh_TW": "美國","ko_KR": "미국","en_US": "United States","es_MX": "Estados Unidos","pt_BR": "Estados Unidos","es_ES": "Estados Unidos","zh_CN": "美国","fr_FR": "États-Unis","de_DE": "Vereinigte Staaten"},"locale": "enUS","type": {"name": {"it_IT": "Normale","ru_RU": "Обычный","en_GB": "Normal","zh_TW": "一般","ko_KR": "일반","en_US": "Normal","es_MX": "Normal","pt_BR": "Normal","es_ES": "Normal","zh_CN": "普通","fr_FR": "Normal","de_DE": "Normal"},"type": "NORMAL"}, "slug": "kilrogg"}',
      );
      expect(realmLocalised, equals(expectedRealmLocalised));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expectedRealmLocalised.toRawJson(),
        equals(
          '{"is_tournament":false,"timezone":"America/Los_Angeles","name":{"it_IT":"Kilrogg","ru_RU":"Kilrogg","en_GB":"Kilrogg","zh_TW":"基爾羅格","ko_KR":"Kilrogg","en_US":"Kilrogg","es_MX":"Kilrogg","pt_BR":"Kilrogg","es_ES":"Kilrogg","zh_CN":"基尔罗格","fr_FR":"Kilrogg","de_DE":"Kilrogg"},"id":4,"region":{"name":{"it_IT":"Nord America","ru_RU":"Северная Америка","en_GB":"North America","zh_TW":"北美","ko_KR":"미국","en_US":"North America","es_MX":"Norteamérica","pt_BR":"América do Norte","es_ES":"Norteamérica","zh_CN":"北美","fr_FR":"Amérique du Nord","de_DE":"Nordamerika"},"id":1},"category":{"it_IT":"Stati Uniti","ru_RU":"США","en_GB":"United States","zh_TW":"美國","ko_KR":"미국","en_US":"United States","es_MX":"Estados Unidos","pt_BR":"Estados Unidos","es_ES":"Estados Unidos","zh_CN":"美国","fr_FR":"États-Unis","de_DE":"Vereinigte Staaten"},"locale":"enUS","type":{"name":{"it_IT":"Normale","ru_RU":"Обычный","en_GB":"Normal","zh_TW":"一般","ko_KR":"일반","en_US":"Normal","es_MX":"Normal","pt_BR":"Normal","es_ES":"Normal","zh_CN":"普通","fr_FR":"Normal","de_DE":"Normal"},"type":"NORMAL"},"slug":"kilrogg"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final RealmLocalised copiedRealmLocalised = expectedRealmLocalised
          .copyWith(slug: 'new-slug');
      expect(copiedRealmLocalised.slug, equals('new-slug'));
      expect(copiedRealmLocalised.name, equals(expectedRealmLocalised.name));
    });

    test('should have a meaningful string representation', () {
      expect(
        expectedRealmLocalised.toString(),
        equals(
          'RealmLocalised{isTournament: false, timezone: RealmTimezone.AMERICA_LOS_ANGELES, name: NameLocalised{itIt: Kilrogg, ruRu: Kilrogg, enGb: Kilrogg, zhTw: 基爾羅格, koKr: Kilrogg, enUs: Kilrogg, esMx: Kilrogg, ptBr: Kilrogg, esEs: Kilrogg, zhCn: 基尔罗格, frFr: Kilrogg, deDe: Kilrogg}, id: 4, region: RegionLocalised{name: NameLocalised{itIt: Nord America, ruRu: Северная Америка, enGb: North America, zhTw: 北美, koKr: 미국, enUs: North America, esMx: Norteamérica, ptBr: América do Norte, esEs: Norteamérica, zhCn: 北美, frFr: Amérique du Nord, deDe: Nordamerika}, id: 1}, category: NameLocalised{itIt: Stati Uniti, ruRu: США, enGb: United States, zhTw: 美國, koKr: 미국, enUs: United States, esMx: Estados Unidos, ptBr: Estados Unidos, esEs: Estados Unidos, zhCn: 美国, frFr: États-Unis, deDe: Vereinigte Staaten}, locale: RealmLocale.EN_US, type: RealmTypeLocalised{name: NameLocalised{itIt: Normale, ruRu: Обычный, enGb: Normal, zhTw: 一般, koKr: 일반, enUs: Normal, esMx: Normal, ptBr: Normal, esEs: Normal, zhCn: 普通, frFr: Normal, deDe: Normal}, type: RealmType.NORMAL}, slug: kilrogg}',
        ),
      );
    });
  });
}
