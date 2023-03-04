import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'population_type_localised.dart';
import 'realm_localised.dart';
import 'server_status_localised.dart';

/// Connected realm response model
@immutable
class ConnectedRealmSearchData {
  const ConnectedRealmSearchData({
    required this.realms,
    required this.id,
    required this.hasQueue,
    required this.status,
    required this.population,
  });

  final List<RealmLocalised> realms;
  final int id;
  final bool hasQueue;
  final ServerStatusLocalised status;
  final PopulationTypeLocalised population;

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

  factory ConnectedRealmSearchData.fromRawJson(String str) =>
      ConnectedRealmSearchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConnectedRealmSearchData.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmSearchData(
        realms: List<RealmLocalised>.from(
            json['realms'].map((dynamic x) => RealmLocalised.fromJson(x))),
        id: json['id'],
        hasQueue: json['has_queue'],
        status: ServerStatusLocalised.fromJson(json['status']),
        population: PopulationTypeLocalised.fromJson(json['population']),
      );

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
