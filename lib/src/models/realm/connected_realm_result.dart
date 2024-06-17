import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/self.dart';
import 'connected_realm_search_data.dart';

/// A class that represents the result of a connected realm query.
@immutable
class ConnectedRealmResult {
  /// The key information for the connected realm.
  final Self key;

  /// The data associated with the connected realm.
  final ConnectedRealmSearchData data;

  /// Creates an instance of [ConnectedRealmResult].
  ///
  /// All fields are required.
  const ConnectedRealmResult({
    required this.key,
    required this.data,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  ConnectedRealmResult copyWith({
    Self? key,
    ConnectedRealmSearchData? data,
  }) =>
      ConnectedRealmResult(
        key: key ?? this.key,
        data: data ?? this.data,
      );

  /// Creates an instance of [ConnectedRealmResult] from a JSON string.
  factory ConnectedRealmResult.fromRawJson(String str) =>
      ConnectedRealmResult.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [ConnectedRealmResult] from a JSON map.
  factory ConnectedRealmResult.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmResult(
        key: Self.fromJson(json['key']),
        data: ConnectedRealmSearchData.fromJson(json['data']),
      );

  /// Converts this instance to a JSON map.
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
