import 'dart:convert';

import 'package:battle_net/src/models/common/enum_values.dart';
import 'package:meta/meta.dart';

import 'name_localised.dart';

/// Represents a localized realm type with its name and type.
///
/// This class is immutable and represents data related to a realm type,
/// including its localized name and its specific type enum.
@immutable
class RealmTypeLocalised {
  /// Constructs a [RealmTypeLocalised] instance.
  ///
  /// The [name] parameter is required and represents the localized name of the realm type.
  /// The [type] parameter is required and represents the specific type of the realm.
  const RealmTypeLocalised({
    required this.name,
    required this.type,
  });

  /// The localized name of the realm type.
  final NameLocalised name;

  /// The specific type of the realm.
  final RealmType type;

  /// Creates a copy of this [RealmTypeLocalised] instance with optional new values.
  ///
  /// Returns a new [RealmTypeLocalised] instance with the specified fields replaced
  /// by the new values if provided, or unchanged if not.
  RealmTypeLocalised copyWith({
    NameLocalised? name,
    RealmType? type,
  }) =>
      RealmTypeLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  /// Creates a [RealmTypeLocalised] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [RealmTypeLocalised] instance using [fromJson].
  factory RealmTypeLocalised.fromRawJson(String str) =>
      RealmTypeLocalised.fromJson(json.decode(str));

  /// Converts this [RealmTypeLocalised] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [RealmTypeLocalised] instance from a JSON map [json].
  ///
  /// Constructs a [RealmTypeLocalised] instance from a map retrieved from JSON,
  /// extracting the [name] as a [NameLocalised] instance and the [type] as a
  /// [RealmType] enum value using [realmTypeValues].
  factory RealmTypeLocalised.fromJson(Map<String, dynamic> json) =>
      RealmTypeLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: realmTypeValues.map[json['type']]!,
      );

  /// Converts this [RealmTypeLocalised] instance to a JSON map.
  ///
  /// Converts the instance's [name] to JSON using [name.toJson] and maps the
  /// [type] enum value to its string representation using [realmTypeValues.reverse].
  Map<String, dynamic> toJson() => <String, dynamic>{
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

/// Enumerates different types of realms.
enum RealmType {
  /// Normal realm type.
  NORMAL,

  /// Role-playing realm type.
  RP,

  /// Player vs Player realm type.
  PVP,

  /// Player vs Player Role-playing realm type.
  PVP_RP,
}

/// Mapping of string values to [RealmType] enum values and vice versa.
final EnumValues<RealmType> realmTypeValues =
    EnumValues<RealmType>(<String, RealmType>{
  'NORMAL': RealmType.NORMAL,
  'RP': RealmType.RP,
  'PVP': RealmType.PVP,
  'PVP_RP': RealmType.PVP_RP,
});
