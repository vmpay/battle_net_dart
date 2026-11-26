import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Base class for Battle.net API response models.
///
/// Every model keeps the complete decoded JSON object in [raw] and exposes the
/// commonly used fields as typed getters. Fields that are not modelled can
/// still be read from [raw], so new fields added by Blizzard never break
/// parsing. Equality and [hashCode] are based on the content of [raw].
@immutable
abstract class ApiModel {
  /// Creates a model backed by the decoded JSON object [raw].
  ApiModel(Map<String, dynamic> raw)
    : raw = Map<String, dynamic>.unmodifiable(raw);

  /// The complete decoded JSON object returned by the API.
  final Map<String, dynamic> raw;

  static const DeepCollectionEquality _equality = DeepCollectionEquality();

  /// Decodes a raw JSON string into a JSON object.
  static Map<String, dynamic> decode(String source) =>
      json.decode(source) as Map<String, dynamic>;

  /// Returns the JSON encoding of [raw].
  String toRawJson() => json.encode(raw);

  /// Reads an integer field.
  @protected
  int? intOf(String key) => _asInt(raw[key]);

  /// Reads a string field. Returns `null` if the value is not a string.
  @protected
  String? stringOf(String key) => _asString(raw[key]);

  /// Reads a boolean field.
  @protected
  bool? boolOf(String key) {
    final Object? value = raw[key];
    return value is bool ? value : null;
  }

  /// Reads a nested JSON object.
  @protected
  Map<String, dynamic>? mapOf(String key) => _asMap(raw[key]);

  /// Reads the `type` of an enum-like object such as `{"type": "EPIC"}`.
  @protected
  String? typeOf(String key) => _asString(mapOf(key)?['type']);

  /// Reads the `href` of a link object such as `{"href": "https://..."}`.
  @protected
  String? hrefOf(String key) => _asString(mapOf(key)?['href']);

  /// Reads the `id` of a nested object such as `{"id": 1}`.
  @protected
  int? idOf(String key) => _asInt(mapOf(key)?['id']);

  /// Reads the `name` of a nested object such as `{"name": "Ravencrest"}`.
  @protected
  String? nameOf(String key) => _asString(mapOf(key)?['name']);

  /// Reads a list of JSON objects and converts every entry with [parse].
  @protected
  List<T> listOf<T>(String key, T Function(Map<String, dynamic> json) parse) {
    final Object? value = raw[key];
    if (value is! List<dynamic>) {
      return <T>[];
    }
    return List<T>.unmodifiable(
      value.whereType<Map<String, dynamic>>().map<T>(parse),
    );
  }

  /// Reads a nested resource reference.
  @protected
  KeyedRef? refOf(String key) {
    final Map<String, dynamic>? value = mapOf(key);
    return value == null ? null : KeyedRef(value);
  }

  /// Reads a list of resource references.
  @protected
  List<KeyedRef> refsOf(String key) => listOf<KeyedRef>(key, KeyedRef.new);

  /// Reads a list of link objects (`[{"href": "..."}]`) as URLs.
  @protected
  List<String> hrefsOf(String key) => List<String>.unmodifiable(
    listOf<String?>(
      key,
      (Map<String, dynamic> json) => _asString(json['href']),
    ).whereType<String>(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiModel &&
          other.runtimeType == runtimeType &&
          _equality.equals(raw, other.raw);

  @override
  int get hashCode => Object.hash(runtimeType, _equality.hash(raw));

  @override
  String toString() => '$runtimeType$raw';
}

int? _asInt(Object? value) => value is num ? value.toInt() : null;

String? _asString(Object? value) => value is String ? value : null;

Map<String, dynamic>? _asMap(Object? value) =>
    value is Map<String, dynamic> ? value : null;

/// A reference to another API resource, for example
/// `{"key": {"href": "..."}, "name": "Ravencrest", "id": 1, "slug": "ravencrest"}`.
class KeyedRef extends ApiModel {
  /// Creates a [KeyedRef] from its JSON object.
  KeyedRef(super.raw);

  /// The URL of the referenced resource.
  String? get href => hrefOf('key');

  /// The ID of the referenced resource.
  int? get id => intOf('id');

  /// The localized name of the referenced resource.
  String? get name => stringOf('name');

  /// The slug of the referenced resource, when available.
  String? get slug => stringOf('slug');
}

/// A single media asset, for example an icon URL.
class MediaAsset extends ApiModel {
  /// Creates a [MediaAsset] from its JSON object.
  MediaAsset(super.raw);

  /// The asset type, for example `icon`.
  String? get key => stringOf('key');

  /// The asset URL.
  String? get value => stringOf('value');

  /// The game client file data ID of the asset.
  int? get fileDataId => intOf('file_data_id');
}

/// Response of a media endpoint such as `/data/wow/media/item/{id}`.
class MediaResponse extends ApiModel {
  /// Creates a [MediaResponse] from its JSON object.
  MediaResponse(super.raw);

  /// The ID of the resource the media belongs to.
  int? get id => intOf('id');

  /// The media assets.
  List<MediaAsset> get assets => listOf<MediaAsset>('assets', MediaAsset.new);
}

/// A paged response of a `/data/wow/search/*` endpoint.
class SearchResponse extends ApiModel {
  /// Creates a [SearchResponse] from its JSON object.
  SearchResponse(super.raw);

  /// The current page (1-based).
  int? get page => intOf('page');

  /// The number of results on this page.
  int? get pageSize => intOf('pageSize');

  /// The maximum page size supported by the endpoint.
  int? get maxPageSize => intOf('maxPageSize');

  /// The total number of pages.
  int? get pageCount => intOf('pageCount');

  /// The results on this page.
  List<SearchResult> get results =>
      listOf<SearchResult>('results', SearchResult.new);
}

/// A single result of a search endpoint.
///
/// Search documents contain every locale, so localized fields in [data] are
/// maps keyed by locale, for example `{"en_US": "Thunderfury"}`.
class SearchResult extends ApiModel {
  /// Creates a [SearchResult] from its JSON object.
  SearchResult(super.raw);

  /// The URL of the matching resource.
  String? get href => hrefOf('key');

  /// The search document of the matching resource.
  Map<String, dynamic> get data => mapOf('data') ?? const <String, dynamic>{};

  /// The ID of the matching resource.
  int? get id => _asInt(data['id']);
}
