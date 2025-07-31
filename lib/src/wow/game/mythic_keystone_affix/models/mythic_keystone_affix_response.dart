// models/mythic_keystone_affix_response.dart
import 'dart:convert';

import 'package:battle_net/src/models/common/links.dart';
import 'package:meta/meta.dart';

import 'key.dart';

/// Represents a Mythic Keystone Affix response.
///
/// This class contains details about a specific Mythic Keystone affix,
/// including its links, ID, name, description, and associated media.
@immutable
class MythicKeystoneAffixResponse {
  /// Links associated with the affix response.
  final Links links;

  /// The unique identifier of the affix.
  final int id;

  /// The name of the affix.
  final String name;

  /// The description of the affix.
  final String description;

  /// Media information for the affix.
  final Media media;

  /// Creates an instance of [MythicKeystoneAffixResponse].
  ///
  /// All fields are required.
  const MythicKeystoneAffixResponse({
    required this.links,
    required this.id,
    required this.name,
    required this.description,
    required this.media,
  });

  /// Creates an instance of [MythicKeystoneAffixResponse] from a raw JSON string.
  factory MythicKeystoneAffixResponse.fromRawJson(String str) =>
      MythicKeystoneAffixResponse.fromJson(json.decode(str));

  /// Converts this instance to a raw JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [MythicKeystoneAffixResponse] from a JSON map.
  factory MythicKeystoneAffixResponse.fromJson(Map<String, dynamic> json) =>
      MythicKeystoneAffixResponse(
        links: Links.fromJson(json['_links']),
        id: json['id'],
        name: json['name'],
        description: json['description'],
        media: Media.fromJson(json['media']),
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    '_links': links.toJson(),
    'id': id,
    'name': name,
    'description': description,
    'media': media.toJson(),
  };

  @override
  String toString() {
    return 'MythicKeystoneAffixResponse{links: $links, id: $id, name: $name, description: $description, media: $media}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MythicKeystoneAffixResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          media == other.media;

  @override
  int get hashCode => Object.hash(links, id, name, description, media);
}

/// Represents media information for a Mythic Keystone Affix.
@immutable
class Media {
  /// The key associated with the media.
  final Key key;

  /// The unique identifier of the media.
  final int id;

  /// Creates an instance of [Media].
  ///
  /// All fields are required.
  const Media({required this.key, required this.id});

  /// Creates an instance of [Media] from a JSON map.
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(key: Key.fromJson(json['key']), id: json['id']);
  }

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'key': key.toJson(), 'id': id};
  }

  @override
  String toString() {
    return 'Media{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Media &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          id == other.id;

  @override
  int get hashCode => Object.hash(key, id);
}
