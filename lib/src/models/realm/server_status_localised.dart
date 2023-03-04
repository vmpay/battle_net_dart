import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/enum_values.dart';
import 'name_localised.dart';

/// Server status data model
@immutable
class ServerStatusLocalised {
  const ServerStatusLocalised({
    required this.name,
    required this.type,
  });

  final NameLocalised name;
  final ServerStatus type;

  ServerStatusLocalised copyWith({
    NameLocalised? name,
    ServerStatus? type,
  }) =>
      ServerStatusLocalised(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory ServerStatusLocalised.fromRawJson(String str) =>
      ServerStatusLocalised.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServerStatusLocalised.fromJson(Map<String, dynamic> json) =>
      ServerStatusLocalised(
        name: NameLocalised.fromJson(json['name']),
        type: serverStatusValues.map[json['type']]!,
      );

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

enum ServerStatus { UP, DOWN }

final EnumValues<ServerStatus> serverStatusValues =
    EnumValues<ServerStatus>(<String, ServerStatus>{
  'UP': ServerStatus.UP,
  'DOWN': ServerStatus.DOWN,
});
