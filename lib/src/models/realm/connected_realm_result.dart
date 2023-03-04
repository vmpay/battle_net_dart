import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/self.dart';
import 'connected_realm_search_data.dart';

/// Connected realm result data model
@immutable
class ConnectedRealmResult {
  const ConnectedRealmResult({
    required this.key,
    required this.data,
  });

  final Self key;
  final ConnectedRealmSearchData data;

  ConnectedRealmResult copyWith({
    Self? key,
    ConnectedRealmSearchData? data,
  }) =>
      ConnectedRealmResult(
        key: key ?? this.key,
        data: data ?? this.data,
      );

  factory ConnectedRealmResult.fromRawJson(String str) =>
      ConnectedRealmResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConnectedRealmResult.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmResult(
        key: Self.fromJson(json['key']),
        data: ConnectedRealmSearchData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key.toJson(),
        'data': data.toJson(),
      };

  @override
  String toString() {
    return 'ConnectedRealmResult{key: $key, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectedRealmResult &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          data == other.data;

  @override
  int get hashCode => key.hashCode ^ data.hashCode;
}
