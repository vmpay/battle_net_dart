import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'connected_realm_result.dart';

/// A class that represents the response from a connected realm search.
@immutable
class ConnectedRealmSearchResponse {
  /// The current page number of the search results.
  final int page;

  /// The number of results per page.
  final int pageSize;

  /// The maximum number of results per page.
  final int maxPageSize;

  /// The total number of pages of results.
  final int pageCount;

  /// The list of search results for connected realms.
  final List<ConnectedRealmResult> results;

  /// Creates an instance of [ConnectedRealmSearchResponse].
  ///
  /// All fields are required.
  const ConnectedRealmSearchResponse({
    required this.page,
    required this.pageSize,
    required this.maxPageSize,
    required this.pageCount,
    required this.results,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  ConnectedRealmSearchResponse copyWith({
    int? page,
    int? pageSize,
    int? maxPageSize,
    int? pageCount,
    List<ConnectedRealmResult>? results,
  }) =>
      ConnectedRealmSearchResponse(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        maxPageSize: maxPageSize ?? this.maxPageSize,
        pageCount: pageCount ?? this.pageCount,
        results: results ?? this.results,
      );

  /// Creates an instance of [ConnectedRealmSearchResponse] from a JSON string.
  factory ConnectedRealmSearchResponse.fromRawJson(String str) =>
      ConnectedRealmSearchResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [ConnectedRealmSearchResponse] from a JSON map.
  factory ConnectedRealmSearchResponse.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmSearchResponse(
        page: json['page'],
        pageSize: json['pageSize'],
        maxPageSize: json['maxPageSize'],
        pageCount: json['pageCount'],
        results: List<ConnectedRealmResult>.from(json['results']
            .map((dynamic x) => ConnectedRealmResult.fromJson(x))),
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        'maxPageSize': maxPageSize,
        'pageCount': pageCount,
        'results': List<dynamic>.from(results.map((dynamic x) => x.toJson())),
      };

  @override
  String toString() {
    return 'ConnectedRealmSearchResponse{page: $page, pageSize: $pageSize, maxPageSize: $maxPageSize, pageCount: $pageCount, results: $results}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectedRealmSearchResponse &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          pageSize == other.pageSize &&
          maxPageSize == other.maxPageSize &&
          pageCount == other.pageCount &&
          const DeepCollectionEquality().equals(results, other.results);

  @override
  int get hashCode =>
      page.hashCode ^
      pageSize.hashCode ^
      maxPageSize.hashCode ^
      pageCount.hashCode ^
      Object.hashAll(results);
}
