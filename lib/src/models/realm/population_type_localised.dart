import 'dart:convert';

import 'package:battle_net/src/models/common/enum_values.dart';
import 'package:meta/meta.dart';

import 'name_localised.dart';

/// A class representing localized population type data for a realm.
@immutable
class PopulationTypeLocalised {
  /// Creates an instance of [PopulationTypeLocalised].
  ///
  /// All fields are required.
  const PopulationTypeLocalised({
    required this.name,
    required this.type,
  });

  /// The localized name of the population type.
  final NameLocalised name;

  /// The type of population.
  final PopulationType type;

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  PopulationTypeLocalised copyWith({
    NameLocalised? name,
    PopulationType? type,
  }) =>
      PopulationTypeLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  /// Creates an instance of [PopulationTypeLocalised] from a JSON string.
  factory PopulationTypeLocalised.fromRawJson(String str) =>
      PopulationTypeLocalised.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [PopulationTypeLocalised] from a JSON map.
  factory PopulationTypeLocalised.fromJson(Map<String, dynamic> json) =>
      PopulationTypeLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: populationTypeValues.map[json['type']]!,
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
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

/// Enum representing the different types of population statuses for a realm.
enum PopulationType { LOW, MEDIUM, FULL, HIGH, LOCKED, RECOMMENDED, OFFLINE }

/// A helper class to map population type values to and from strings.
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
