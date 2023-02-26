import 'dart:convert';

import 'package:meta/meta.dart';

import 'name_localised.dart';

@immutable
class RegionLocalised {
  const RegionLocalised({
    required this.name,
    required this.id,
  });

  final NameLocalised name;
  final int id;

  RegionLocalised copyWith({
    NameLocalised? name,
    int? id,
  }) =>
      RegionLocalised(
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory RegionLocalised.fromRawJson(String str) =>
      RegionLocalised.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionLocalised.fromJson(Map<String, dynamic> json) =>
      RegionLocalised(
        name: NameLocalised.fromJson(json['name']),
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
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
