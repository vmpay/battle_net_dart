import 'dart:convert';

import 'package:meta/meta.dart';

/// Realm population data model
@immutable
class Population {
  const Population({
    required this.type,
    required this.name,
  });

  // FULL, HIGH, MEDIUM, LOW, RECOMMENDED
  final String type;
  final String name;

  Population copyWith({
    String? type,
    String? name,
  }) =>
      Population(
        type: type ?? this.type,
        name: name ?? this.name,
      );

  factory Population.fromRawJson(String str) =>
      Population.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Population.fromJson(Map<String, dynamic> json) => Population(
        type: json['type'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Population &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          name == other.name;

  @override
  int get hashCode => type.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Population{type: $type, name: $name}';
  }
}
