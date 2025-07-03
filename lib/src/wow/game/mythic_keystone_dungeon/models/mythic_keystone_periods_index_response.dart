// models/mythic_keystone_periods_index_response.dart
import 'dart:convert';

import 'package:battle_net/src/models/common/links.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Represents the index response for Mythic Keystone periods.
///
/// This class encapsulates a list of Mythic Keystone periods and the current period.
@immutable
class MythicKeystonePeriodsIndexResponse {
  /// Links associated with the Mythic Keystone periods index response.
  final Links links;

  /// A list of Mythic Keystone periods.
  final List<Period> periods;

  /// The current Mythic Keystone period.
  final Period currentPeriod;

  /// Creates an instance of [MythicKeystonePeriodsIndexResponse].
  ///
  /// All fields are required.
  const MythicKeystonePeriodsIndexResponse({
    required this.links,
    required this.periods,
    required this.currentPeriod,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  MythicKeystonePeriodsIndexResponse copyWith({
    Links? links,
    List<Period>? periods,
    Period? currentPeriod,
  }) => MythicKeystonePeriodsIndexResponse(
    links: links ?? this.links,
    periods: periods ?? this.periods,
    currentPeriod: currentPeriod ?? this.currentPeriod,
  );

  @override
  String toString() {
    return 'MythicKeystonePeriodsIndexResponse{links: $links, periods: $periods, currentPeriod: $currentPeriod}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MythicKeystonePeriodsIndexResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          const DeepCollectionEquality().equals(periods, other.periods) &&
          currentPeriod == other.currentPeriod;

  @override
  int get hashCode =>
      links.hashCode ^ Object.hashAll(periods) ^ currentPeriod.hashCode;

  /// Creates an instance of [MythicKeystonePeriodsIndexResponse] from a JSON string.
  factory MythicKeystonePeriodsIndexResponse.fromRawJson(String str) =>
      MythicKeystonePeriodsIndexResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [MythicKeystonePeriodsIndexResponse] from a JSON map.
  factory MythicKeystonePeriodsIndexResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return MythicKeystonePeriodsIndexResponse(
      links: Links.fromJson(json['_links']),
      periods: json['periods'] == null
          ? <Period>[]
          : List<Period>.from(
              json['periods']!.map(
                (dynamic x) => Period.fromJson(x as Map<String, dynamic>),
              ),
            ),
      currentPeriod: Period.fromJson(json['current_period']),
    );
  }

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    '_links': links.toJson(),
    'periods': List<dynamic>.from(periods.map((Period x) => x.toJson())),
    'current_period': currentPeriod.toJson(),
  };
}

/// Represents a Mythic Keystone period.
@immutable
class Period {
  /// The unique identifier of the period.
  final int id;

  /// Creates an instance of [Period].
  ///
  /// [id] is the unique identifier of the period.
  const Period({required this.id});

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  Period copyWith({int? id}) => Period(id: id ?? this.id);

  /// Creates an instance of [Period] from a JSON map.
  factory Period.fromJson(Map<String, dynamic> json) => Period(id: json['id']);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id};

  @override
  String toString() {
    return 'Period{id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Period && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
