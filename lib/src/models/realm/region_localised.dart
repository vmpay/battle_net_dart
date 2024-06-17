import 'dart:convert';

import 'package:meta/meta.dart';

import 'name_localised.dart';

/// Represents a localized region with its name and ID.
///
/// This class is immutable and represents data related to a region,
/// including its localized name and unique identifier.
@immutable
class RegionLocalised {
  /// Constructs a [RegionLocalised] instance.
  ///
  /// The [name] parameter is required and represents the localized name of the region.
  /// The [id] parameter is required and represents the unique identifier of the region.
  const RegionLocalised({
    required this.name,
    required this.id,
  });

  /// The localized name of the region.
  final NameLocalised name;

  /// The unique identifier of the region.
  final int id;

  /// Creates a copy of this [RegionLocalised] instance with optional new values.
  ///
  /// Returns a new [RegionLocalised] instance with the specified fields replaced
  /// by the new values if provided, or unchanged if not.
  RegionLocalised copyWith({
    NameLocalised? name,
    int? id,
  }) =>
      RegionLocalised(
        name: name ?? this.name,
        id: id ?? this.id,
      );

  /// Creates a [RegionLocalised] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [RegionLocalised] instance using [fromJson].
  factory RegionLocalised.fromRawJson(String str) =>
      RegionLocalised.fromJson(json.decode(str));

  /// Converts this [RegionLocalised] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [RegionLocalised] instance from a JSON map [json].
  ///
  /// Constructs a [RegionLocalised] instance from a map retrieved from JSON,
  /// extracting the [name] as a [NameLocalised] instance and the [id] as an integer.
  factory RegionLocalised.fromJson(Map<String, dynamic> json) =>
      RegionLocalised(
        name: NameLocalised.fromJson(json['name']),
        id: json['id'],
      );

  /// Converts this [RegionLocalised] instance to a JSON map.
  ///
  /// Converts the instance's [name] to JSON using [name.toJson], and includes
  /// the [id] directly as part of the JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name.toJson(),
        'id': id,
      };

  @override
  String toString() {
    return 'RegionLocalised{name: $name, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionLocalised &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
