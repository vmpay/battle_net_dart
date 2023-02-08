import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/self.dart';

/// Realm region data model
@immutable
class Region {
  const Region({
    required this.key,
    required this.name,
    required this.id,
  });

  final Self key;
  final String name;
  final int id;

  Region copyWith({
    Self? key,
    String? name,
    int? id,
  }) =>
      Region(
        key: key ?? this.key,
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        key: Self.fromJson(json['key']),
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'key': key.toJson(),
        'name': name,
        'id': id,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => key.hashCode ^ name.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'Region{key: $key, name: $name, id: $id}';
  }
}
