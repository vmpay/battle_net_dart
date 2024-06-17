import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'population_type_localised.dart';
import 'realm_localised.dart';
import 'server_status_localised.dart';

/// A class that represents the data associated with a connected realm search.
@immutable
class ConnectedRealmSearchData {
  /// The list of localized realms associated with the connected realm.
  final List<RealmLocalised> realms;

  /// The unique identifier for the connected realm.
  final int id;

  /// Indicates if there is a queue to enter the realm.
  final bool hasQueue;

  /// The status of the server.
  final ServerStatusLocalised status;

  /// The population type of the server.
  final PopulationTypeLocalised population;

  /// Creates an instance of [ConnectedRealmSearchData].
  ///
  /// All fields are required.
  const ConnectedRealmSearchData({
    required this.realms,
    required this.id,
    required this.hasQueue,
    required this.status,
    required this.population,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  ConnectedRealmSearchData copyWith({
    List<RealmLocalised>? realms,
    int? id,
    bool? hasQueue,
    ServerStatusLocalised? status,
    PopulationTypeLocalised? population,
  }) =>
      ConnectedRealmSearchData(
        realms: realms ?? this.realms,
        id: id ?? this.id,
        hasQueue: hasQueue ?? this.hasQueue,
        status: status ?? this.status,
        population: population ?? this.population,
      );

  /// Creates an instance of [ConnectedRealmSearchData] from a JSON string.
  factory ConnectedRealmSearchData.fromRawJson(String str) =>
      ConnectedRealmSearchData.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [ConnectedRealmSearchData] from a JSON map.
  factory ConnectedRealmSearchData.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmSearchData(
        realms: List<RealmLocalised>.from(
            json['realms'].map((dynamic x) => RealmLocalised.fromJson(x))),
        id: json['id'],
        hasQueue: json['has_queue'],
        status: ServerStatusLocalised.fromJson(json['status']),
        population: PopulationTypeLocalised.fromJson(json['population']),
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'realms': List<dynamic>.from(realms.map((dynamic x) => x.toJson())),
        'id': id,
        'has_queue': hasQueue,
        'status': status.toJson(),
        'population': population.toJson(),
      };

  @override
  String toString() {
    return 'ConnectedRealmSearchData{realms: $realms, id: $id, hasQueue: $hasQueue, status: $status, population: $population}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectedRealmSearchData &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(realms, other.realms) &&
          id == other.id &&
          hasQueue == other.hasQueue &&
          status == other.status &&
          population == other.population;

  @override
  int get hashCode =>
      Object.hashAll(realms) ^
      id.hashCode ^
      hasQueue.hashCode ^
      status.hashCode ^
      population.hashCode;
}
