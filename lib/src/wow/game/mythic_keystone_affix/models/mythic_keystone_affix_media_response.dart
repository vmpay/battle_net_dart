// models/mythic_keystone_affix_media_response.dart
import 'dart:convert';

import 'package:battle_net/src/models/common/links.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Represents the media response for a Mythic Keystone Affix.
///
/// This class contains links, a list of assets, and the ID of the affix.
@immutable
class MythicKeystoneAffixMediaResponse {
  /// Links associated with the media response.
  final Links links;

  /// A list of assets related to the affix media.
  final List<Asset> assets;

  /// The unique identifier of the Mythic Keystone Affix.
  final int id;

  /// Creates an instance of [MythicKeystoneAffixMediaResponse].
  ///
  /// All fields are required.
  const MythicKeystoneAffixMediaResponse({
    required this.links,
    required this.assets,
    required this.id,
  });

  /// Creates an instance of [MythicKeystoneAffixMediaResponse] from a raw JSON string.
  factory MythicKeystoneAffixMediaResponse.fromRawJson(String str) =>
      MythicKeystoneAffixMediaResponse.fromJson(json.decode(str));

  /// Converts this instance to a raw JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [MythicKeystoneAffixMediaResponse] from a JSON map.
  factory MythicKeystoneAffixMediaResponse.fromJson(
    Map<String, dynamic> json,
  ) => MythicKeystoneAffixMediaResponse(
    links: Links.fromJson(json['_links']),
    assets: json['assets'] == null
        ? <Asset>[]
        : List<Asset>.from(
            json['assets']!.map((dynamic x) => Asset.fromJson(x)),
          ),
    id: json['id'],
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    '_links': links.toJson(),
    'assets': List<dynamic>.from(assets.map((Asset x) => x.toJson())),
    'id': id,
  };

  @override
  String toString() {
    return 'MythicKeystoneAffixMediaResponse{links: $links, assets: $assets, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MythicKeystoneAffixMediaResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          const DeepCollectionEquality().equals(assets, other.assets) &&
          id == other.id;

  @override
  int get hashCode =>
      Object.hash(links, const DeepCollectionEquality().hash(assets), id);
}

/// Represents an asset within the Mythic Keystone Affix Media Response.
@immutable
class Asset {
  /// The key of the asset.
  final String key;

  /// The value (URL) of the asset.
  final String value;

  /// The file data ID of the asset.
  final int fileDataId;

  /// Creates an instance of [Asset].
  ///
  /// All fields are required.
  const Asset({
    required this.key,
    required this.value,
    required this.fileDataId,
  });

  /// Creates an instance of [Asset] from a JSON map.
  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    key: json['key'],
    value: json['value'],
    fileDataId: json['file_data_id'],
  );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'key': key,
    'value': value,
    'file_data_id': fileDataId,
  };

  @override
  String toString() {
    return 'Asset{key: $key, value: $value, fileDataId: $fileDataId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Asset &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value &&
          fileDataId == other.fileDataId;

  @override
  int get hashCode => Object.hash(key, value, fileDataId);
}
