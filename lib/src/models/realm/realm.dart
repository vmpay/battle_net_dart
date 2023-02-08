import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/self.dart';
import 'population.dart';
import 'region.dart';

/// Realm data model
@immutable
class Realm {
  const Realm({
    required this.id,
    required this.region,
    required this.connectedRealm,
    required this.name,
    required this.category,
    required this.locale,
    required this.timezone,
    required this.type,
    required this.isTournament,
    required this.slug,
  });

  final int id;
  final Region region;
  final Self connectedRealm;
  final String name;
  final String category;
  final String locale;
  final String timezone;
  final Population type;
  final bool isTournament;
  final String slug;

  Realm copyWith({
    int? id,
    Region? region,
    Self? connectedRealm,
    String? name,
    String? category,
    String? locale,
    String? timezone,
    Population? type,
    bool? isTournament,
    String? slug,
  }) =>
      Realm(
        id: id ?? this.id,
        region: region ?? this.region,
        connectedRealm: connectedRealm ?? this.connectedRealm,
        name: name ?? this.name,
        category: category ?? this.category,
        locale: locale ?? this.locale,
        timezone: timezone ?? this.timezone,
        type: type ?? this.type,
        isTournament: isTournament ?? this.isTournament,
        slug: slug ?? this.slug,
      );

  factory Realm.fromRawJson(String str) => Realm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Realm.fromJson(Map<String, dynamic> json) => Realm(
        id: json['id'],
        region: Region.fromJson(json['region']),
        connectedRealm: Self.fromJson(json['connected_realm']),
        name: json['name'],
        category: json['category'],
        locale: json['locale'],
        timezone: json['timezone'],
        type: Population.fromJson(json['type']),
        isTournament: json['is_tournament'],
        slug: json['slug'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'region': region.toJson(),
        'connected_realm': connectedRealm.toJson(),
        'name': name,
        'category': category,
        'locale': locale,
        'timezone': timezone,
        'type': type.toJson(),
        'is_tournament': isTournament,
        'slug': slug,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Realm &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          region == other.region &&
          connectedRealm == other.connectedRealm &&
          name == other.name &&
          category == other.category &&
          locale == other.locale &&
          timezone == other.timezone &&
          type == other.type &&
          isTournament == other.isTournament &&
          slug == other.slug;

  @override
  int get hashCode =>
      id.hashCode ^
      region.hashCode ^
      connectedRealm.hashCode ^
      name.hashCode ^
      category.hashCode ^
      locale.hashCode ^
      timezone.hashCode ^
      type.hashCode ^
      isTournament.hashCode ^
      slug.hashCode;

  @override
  String toString() {
    return 'Realm{id: $id, region: $region, connectedRealm: $connectedRealm, name: $name, category: $category, locale: $locale, timezone: $timezone, type: $type, isTournament: $isTournament, slug: $slug}';
  }
}
