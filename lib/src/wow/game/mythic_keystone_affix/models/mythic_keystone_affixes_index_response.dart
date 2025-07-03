// models/mythic_keystone_affixes_index_response.dart
import 'dart:convert';

import 'package:battle_net/src/models/common/links.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'key.dart';

/// Represents the index response for Mythic Keystone affixes.
///
/// This class contains links and a list of Mythic Keystone affixes.
@immutable
class MythicKeystoneAffixesIndexResponse {
  /// Links associated with the affix index response.
  final Links links;

  /// A list of Mythic Keystone affixes.
  final List<KeyNameIdData> affixes;

  /// Creates an instance of [MythicKeystoneAffixesIndexResponse].
  ///
  /// All fields are required.
  const MythicKeystoneAffixesIndexResponse({
    required this.links,
    required this.affixes,
  });

  /// Creates an instance of [MythicKeystoneAffixesIndexResponse] from a raw JSON string.
  factory MythicKeystoneAffixesIndexResponse.fromRawJson(String str) =>
      MythicKeystoneAffixesIndexResponse.fromJson(json.decode(str));

  /// Converts this instance to a raw JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [MythicKeystoneAffixesIndexResponse] from a JSON map.
  factory MythicKeystoneAffixesIndexResponse.fromJson(
    Map<String, dynamic> json,
  ) => MythicKeystoneAffixesIndexResponse(
    links: Links.fromJson(json['_links']),
    affixes: json['affixes'] == null
        ? <KeyNameIdData>[]
        : List<KeyNameIdData>.from(
            json['affixes']!.map((dynamic x) => KeyNameIdData.fromJson(x)),
          ),
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    '_links': links.toJson(),
    'affixes': List<dynamic>.from(affixes.map((KeyNameIdData x) => x.toJson())),
  };

  @override
  String toString() {
    return 'MythicKeystoneAffixesIndexResponse{links: $links, affixes: $affixes}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MythicKeystoneAffixesIndexResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          const DeepCollectionEquality().equals(affixes, other.affixes);

  @override
  int get hashCode =>
      Object.hash(links, const DeepCollectionEquality().hash(affixes));
}

/// Represents key, name, and ID data for a Mythic Keystone affix.
@immutable
class KeyNameIdData {
  /// The key associated with the affix.
  final Key key;

  /// The name of the affix.
  final String? name;

  /// The unique identifier of the affix.
  final int id;

  /// Creates an instance of [KeyNameIdData].
  ///
  /// All fields are required.
  const KeyNameIdData({
    required this.key,
    required this.name,
    required this.id,
  });

  /// Creates an instance of [KeyNameIdData] from a JSON map.
  factory KeyNameIdData.fromJson(Map<String, dynamic> json) => KeyNameIdData(
    key: Key.fromJson(json['key']),
    name: json['name'] is String ? json['name'] : null,
    id: json['id'],
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'key': key.toJson(),
    'name': name,
    'id': id,
  };

  @override
  String toString() {
    return 'KeyNameIdData{key: $key, name: $name, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyNameIdData &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => Object.hash(key, name, id);
}
