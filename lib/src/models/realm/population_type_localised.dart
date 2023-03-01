import 'dart:convert';

import 'package:battle_net/src/models/common/enum_values.dart';
import 'package:meta/meta.dart';

import 'name_localised.dart';

@immutable
class PopulationTypeLocalised {
  const PopulationTypeLocalised({
    required this.name,
    required this.type,
  });

  final NameLocalised name;
  final PopulationType type;

  PopulationTypeLocalised copyWith({
    NameLocalised? name,
    PopulationType? type,
  }) =>
      PopulationTypeLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory PopulationTypeLocalised.fromRawJson(String str) =>
      PopulationTypeLocalised.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopulationTypeLocalised.fromJson(Map<String, dynamic> json) =>
      PopulationTypeLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: populationTypeValues.map[json['type']]!,
      );

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'type': populationTypeValues.reverse[type],
      };

  @override
  String toString() {
    return 'PopulationTypeLocalised{name: $name, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopulationTypeLocalised &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}

enum PopulationType { LOW, MEDIUM, FULL, HIGH, LOCKED, RECOMMENDED, OFFLINE }

final EnumValues<PopulationType> populationTypeValues =
    EnumValues<PopulationType>(<String, PopulationType>{
  'LOW': PopulationType.LOW,
  'MEDIUM': PopulationType.MEDIUM,
  'HIGH': PopulationType.HIGH,
  'FULL': PopulationType.FULL,
  'LOCKED': PopulationType.LOCKED,
  'RECOMMENDED': PopulationType.RECOMMENDED,
  'OFFLINE': PopulationType.OFFLINE,
});
