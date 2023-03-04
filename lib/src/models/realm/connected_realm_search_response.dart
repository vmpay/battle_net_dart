import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'connected_realm_result.dart';

/// Connected realm search data model
@immutable
class ConnectedRealmSearchResponse {
  const ConnectedRealmSearchResponse({
    required this.page,
    required this.pageSize,
    required this.maxPageSize,
    required this.pageCount,
    required this.results,
  });

  final int page;
  final int pageSize;
  final int maxPageSize;
  final int pageCount;
  final List<ConnectedRealmResult> results;

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

  factory ConnectedRealmSearchResponse.fromRawJson(String str) =>
      ConnectedRealmSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConnectedRealmSearchResponse.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmSearchResponse(
        page: json['page'],
        pageSize: json['pageSize'],
        maxPageSize: json['maxPageSize'],
        pageCount: json['pageCount'],
        results: List<ConnectedRealmResult>.from(json['results']
            .map((dynamic x) => ConnectedRealmResult.fromJson(x))),
      );

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
