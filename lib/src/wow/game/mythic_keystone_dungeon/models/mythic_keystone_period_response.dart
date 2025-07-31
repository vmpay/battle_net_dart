// models/mythic_keystone_period_response.dart
import 'dart:convert';

import 'package:battle_net/src/models/common/links.dart';
import 'package:meta/meta.dart';

/// Represents a Mythic Keystone period response.
///
/// This class encapsulates information about a specific Mythic Keystone period,
/// including its ID, start and end times, and associated links.
@immutable
class MythicKeystonePeriodResponse {
  /// Links associated with the Mythic Keystone period response.
  final Links links;

  /// The unique identifier of the Mythic Keystone period.
  final int id;

  /// The start time of the Mythic Keystone period.
  final DateTime startTime;

  /// The end time of the Mythic Keystone period.
  final DateTime endTime;

  /// Creates an instance of [MythicKeystonePeriodResponse].
  ///
  /// All fields are required.
  const MythicKeystonePeriodResponse({
    required this.links,
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  MythicKeystonePeriodResponse copyWith({
    Links? links,
    int? id,
    DateTime? startTime,
    DateTime? endTime,
  }) => MythicKeystonePeriodResponse(
    links: links ?? this.links,
    id: id ?? this.id,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );

  /// Creates an instance of [MythicKeystonePeriodResponse] from a JSON string.
  factory MythicKeystonePeriodResponse.fromRawJson(String str) =>
      MythicKeystonePeriodResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [MythicKeystonePeriodResponse] from a JSON map.
  factory MythicKeystonePeriodResponse.fromJson(Map<String, dynamic> json) =>
      MythicKeystonePeriodResponse(
        links: Links.fromJson(json['_links']),
        id: json['id'],
        startTime: DateTime.fromMillisecondsSinceEpoch(
          json['start_timestamp'],
          isUtc: true,
        ),
        endTime: DateTime.fromMillisecondsSinceEpoch(
          json['end_timestamp'],
          isUtc: true,
        ),
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    '_links': links.toJson(),
    'id': id,
    'start_timestamp': startTime.millisecondsSinceEpoch,
    'end_timestamp': endTime.millisecondsSinceEpoch,
  };

  @override
  String toString() {
    return 'MythicKeystonePeriodResponse{links: $links, id: $id, startTime: $startTime, endTime: $endTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MythicKeystonePeriodResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode =>
      links.hashCode ^ id.hashCode ^ startTime.hashCode ^ endTime.hashCode;
}
