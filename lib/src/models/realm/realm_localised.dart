import 'dart:convert';

import 'package:battle_net/src/models/common/enum_values.dart';
import 'package:meta/meta.dart';

import 'name_localised.dart';
import 'realm_type_localised.dart';
import 'region_localised.dart';

/// A class representing localized realm data.
@immutable
class RealmLocalised {
  /// Creates an instance of [RealmLocalised].
  ///
  /// All fields are required.
  const RealmLocalised({
    required this.isTournament,
    required this.timezone,
    required this.name,
    required this.id,
    required this.region,
    required this.category,
    required this.locale,
    required this.type,
    required this.slug,
  });

  /// Indicates if the realm is a tournament realm.
  final bool isTournament;

  /// The timezone of the realm.
  final RealmTimezone timezone;

  /// The localized name of the realm.
  final NameLocalised name;

  /// The unique identifier of the realm.
  final int id;

  /// The region of the realm.
  final RegionLocalised region;

  /// The category of the realm.
  final NameLocalised category;

  /// The locale of the realm.
  final RealmLocale locale;

  /// The type of the realm.
  final RealmTypeLocalised type;

  /// The unique slug of the realm.
  final String slug;

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  RealmLocalised copyWith({
    bool? isTournament,
    RealmTimezone? timezone,
    NameLocalised? name,
    int? id,
    RegionLocalised? region,
    NameLocalised? category,
    RealmLocale? locale,
    RealmTypeLocalised? type,
    String? slug,
  }) =>
      RealmLocalised(
        isTournament: isTournament ?? this.isTournament,
        timezone: timezone ?? this.timezone,
        name: name ?? this.name,
        id: id ?? this.id,
        region: region ?? this.region,
        category: category ?? this.category,
        locale: locale ?? this.locale,
        type: type ?? this.type,
        slug: slug ?? this.slug,
      );

  /// Creates an instance of [RealmLocalised] from a JSON string.
  factory RealmLocalised.fromRawJson(String str) =>
      RealmLocalised.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [RealmLocalised] from a JSON map.
  factory RealmLocalised.fromJson(Map<String, dynamic> json) => RealmLocalised(
        isTournament: json['is_tournament'],
        timezone: realmTimezoneValues.map[json['timezone']]!,
        name: NameLocalised.fromJson(json['name']),
        id: json['id'],
        region: RegionLocalised.fromJson(json['region']),
        category: NameLocalised.fromJson(json['category']),
        locale: realmLocaleValues.map[json['locale']]!,
        type: RealmTypeLocalised.fromJson(json['type']),
        slug: json['slug'],
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'is_tournament': isTournament,
        'timezone': realmTimezoneValues.reverse[timezone],
        'name': name.toJson(),
        'id': id,
        'region': region.toJson(),
        'category': category.toJson(),
        'locale': realmLocaleValues.reverse[locale],
        'type': type.toJson(),
        'slug': slug,
      };

  @override
  String toString() {
    return 'RealmLocalised{isTournament: $isTournament, timezone: $timezone, name: $name, id: $id, region: $region, category: $category, locale: $locale, type: $type, slug: $slug}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealmLocalised &&
          runtimeType == other.runtimeType &&
          isTournament == other.isTournament &&
          timezone == other.timezone &&
          name == other.name &&
          id == other.id &&
          region == other.region &&
          category == other.category &&
          locale == other.locale &&
          type == other.type &&
          slug == other.slug;

  @override
  int get hashCode =>
      isTournament.hashCode ^
      timezone.hashCode ^
      name.hashCode ^
      id.hashCode ^
      region.hashCode ^
      category.hashCode ^
      locale.hashCode ^
      type.hashCode ^
      slug.hashCode;
}

/// Enum representing the different locales supported for realms.
enum RealmLocale {
  FR_FR,
  DE_DE,
  EN_GB,
  EN_US,
  PT_PT,
  PT_BR,
  IT_IT,
  ES_ES,
  ES_MX,
  RU_RU,
  KO_KR,
  ZH_TW,
}

/// A mapping of string values to [RealmLocale] enums.
final EnumValues<RealmLocale> realmLocaleValues =
    EnumValues<RealmLocale>(<String, RealmLocale>{
  'deDE': RealmLocale.DE_DE,
  'enGB': RealmLocale.EN_GB,
  'enUS': RealmLocale.EN_US,
  'esES': RealmLocale.ES_ES,
  'esMX': RealmLocale.ES_MX,
  'frFR': RealmLocale.FR_FR,
  'itIT': RealmLocale.IT_IT,
  'ptPT': RealmLocale.PT_PT,
  'ptBR': RealmLocale.PT_BR,
  'ruRU': RealmLocale.RU_RU,
  'koKR': RealmLocale.KO_KR,
  'zhTW': RealmLocale.ZH_TW,
});

/// Enum representing the different timezones for realms.
enum RealmTimezone {
  EUROPE_PARIS,
  ASIA_SEOUL,
  ASIA_TAIPEI,
  AMERICA_LOS_ANGELES,
  AMERICA_CHICAGO,
  AMERICA_NEW_YORK,
  AMERICA_DENVER,
  AMERICA_SAO_PAULO,
  AUSTRALIA_MELBOURNE,
}

/// A mapping of string values to [RealmTimezone] enums.
final EnumValues<RealmTimezone> realmTimezoneValues =
    EnumValues<RealmTimezone>(<String, RealmTimezone>{
  'Europe/Paris': RealmTimezone.EUROPE_PARIS,
  'Asia/Seoul': RealmTimezone.ASIA_SEOUL,
  'Asia/Taipei': RealmTimezone.ASIA_TAIPEI,
  'America/Los_Angeles': RealmTimezone.AMERICA_LOS_ANGELES,
  'America/Chicago': RealmTimezone.AMERICA_CHICAGO,
  'America/New_York': RealmTimezone.AMERICA_NEW_YORK,
  'America/Denver': RealmTimezone.AMERICA_DENVER,
  'America/Sao_Paulo': RealmTimezone.AMERICA_SAO_PAULO,
  'Australia/Melbourne': RealmTimezone.AUSTRALIA_MELBOURNE,
});
