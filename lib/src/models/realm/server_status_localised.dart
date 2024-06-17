import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/enum_values.dart';
import 'name_localised.dart';

/// Represents the localized server status with its name and type.
///
/// This class is immutable and represents data related to a server status,
/// including its localized name and type (UP or DOWN).
@immutable
class ServerStatusLocalised {
  /// Constructs a [ServerStatusLocalised] instance.
  ///
  /// The [name] parameter is required and represents the localized name of the server status.
  /// The [type] parameter is required and represents the type of server status (UP or DOWN).
  const ServerStatusLocalised({
    required this.name,
    required this.type,
  });

  /// The localized name of the server status.
  final NameLocalised name;

  /// The type of server status, either UP or DOWN.
  final ServerStatus type;

  /// Creates a copy of this [ServerStatusLocalised] instance with optional new values.
  ///
  /// Returns a new [ServerStatusLocalised] instance with the specified fields replaced
  /// by the new values if provided, or unchanged if not.
  ServerStatusLocalised copyWith({
    NameLocalised? name,
    ServerStatus? type,
  }) =>
      ServerStatusLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  /// Creates a [ServerStatusLocalised] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [ServerStatusLocalised] instance using [fromJson].
  factory ServerStatusLocalised.fromRawJson(String str) =>
      ServerStatusLocalised.fromJson(json.decode(str));

  /// Converts this [ServerStatusLocalised] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [ServerStatusLocalised] instance from a JSON map [json].
  ///
  /// Constructs a [ServerStatusLocalised] instance from a map retrieved from JSON,
  /// extracting the [name] as a [NameLocalised] instance and the [type] as a [ServerStatus].
  factory ServerStatusLocalised.fromJson(Map<String, dynamic> json) =>
      ServerStatusLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: serverStatusValues.map[json['type']]!,
      );

  /// Converts this [ServerStatusLocalised] instance to a JSON map.
  ///
  /// Converts the instance's [name] to JSON using [name.toJson], and includes
  /// the [type] as a string representation from [serverStatusValues.reverse].
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name.toJson(),
        'type': serverStatusValues.reverse[type],
      };

  @override
  String toString() {
    return 'ServerStatusLocalised{name: $name, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerStatusLocalised &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}

/// Enum representing server status types: UP or DOWN.
enum ServerStatus {
  UP, // The server is up and running.
  DOWN, // The server is currently down.
}

/// Holds mapping values for [ServerStatus] enum values and their string representations.
final EnumValues<ServerStatus> serverStatusValues =
    EnumValues<ServerStatus>(<String, ServerStatus>{
  'UP': ServerStatus.UP,
  'DOWN': ServerStatus.DOWN,
});
