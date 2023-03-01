import 'dart:convert';

import 'package:battle_net/src/models/common/enum_values.dart';
import 'package:meta/meta.dart';

import 'name_localised.dart';

@immutable
class RealmTypeLocalised {
  const RealmTypeLocalised({
    required this.name,
    required this.type,
  });

  final NameLocalised name;
  final RealmType type;

  RealmTypeLocalised copyWith({
    NameLocalised? name,
    RealmType? type,
  }) =>
      RealmTypeLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory RealmTypeLocalised.fromRawJson(String str) =>
      RealmTypeLocalised.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RealmTypeLocalised.fromJson(Map<String, dynamic> json) =>
      RealmTypeLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: realmTypeValues.map[json['type']]!,
      );

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'type': realmTypeValues.reverse[type],
      };

  @override
  String toString() {
    return 'RealmTypeLocalised{name: $name, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealmTypeLocalised &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}

enum RealmType { NORMAL, RP, PVP, PVP_RP }

final EnumValues<RealmType> realmTypeValues =
    EnumValues<RealmType>(<String, RealmType>{
  'NORMAL': RealmType.NORMAL,
  'RP': RealmType.RP,
  'PVP': RealmType.PVP,
  'PVP_RP': RealmType.PVP_RP,
});
