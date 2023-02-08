import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../common/links.dart';
import '../common/self.dart';
import 'population.dart';
import 'realm.dart';

/// Connected realm response model
@immutable
class ConnectedRealmResponse {
  const ConnectedRealmResponse({
    required this.links,
    required this.id,
    required this.hasQueue,
    required this.status,
    required this.population,
    required this.realms,
    required this.mythicLeaderboards,
    required this.auctions,
  });

  final Links links;
  final int id;
  final bool hasQueue;
  final Population status;
  final Population population;
  final List<Realm> realms;
  final Self mythicLeaderboards;
  final Self auctions;

  ConnectedRealmResponse copyWith({
    Links? links,
    int? id,
    bool? hasQueue,
    Population? status,
    Population? population,
    List<Realm>? realms,
    Self? mythicLeaderboards,
    Self? auctions,
  }) =>
      ConnectedRealmResponse(
        links: links ?? this.links,
        id: id ?? this.id,
        hasQueue: hasQueue ?? this.hasQueue,
        status: status ?? this.status,
        population: population ?? this.population,
        realms: realms ?? this.realms,
        mythicLeaderboards: mythicLeaderboards ?? this.mythicLeaderboards,
        auctions: auctions ?? this.auctions,
      );

  factory ConnectedRealmResponse.fromRawJson(String str) =>
      ConnectedRealmResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConnectedRealmResponse.fromJson(Map<String, dynamic> json) =>
      ConnectedRealmResponse(
        links: Links.fromJson(json['_links']),
        id: json['id'],
        hasQueue: json['has_queue'],
        status: Population.fromJson(json['status']),
        population: Population.fromJson(json['population']),
        realms: List<Realm>.from(json['realms'].map((x) => Realm.fromJson(x))),
        mythicLeaderboards: Self.fromJson(json['mythic_leaderboards']),
        auctions: Self.fromJson(json['auctions']),
      );

  Map<String, dynamic> toJson() => {
        '_links': links.toJson(),
        'id': id,
        'has_queue': hasQueue,
        'status': status.toJson(),
        'population': population.toJson(),
        'realms': List<dynamic>.from(realms.map((x) => x.toJson())),
        'mythic_leaderboards': mythicLeaderboards.toJson(),
        'auctions': auctions.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectedRealmResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          id == other.id &&
          hasQueue == other.hasQueue &&
          status == other.status &&
          population == other.population &&
          const DeepCollectionEquality().equals(realms, other.realms) &&
          mythicLeaderboards == other.mythicLeaderboards &&
          auctions == other.auctions;

  @override
  int get hashCode =>
      links.hashCode ^
      id.hashCode ^
      hasQueue.hashCode ^
      status.hashCode ^
      population.hashCode ^
      Object.hashAll(realms) ^
      mythicLeaderboards.hashCode ^
      auctions.hashCode;

  @override
  String toString() {
    return 'ConnectedRealmResponse{links: $links, id: $id, hasQueue: $hasQueue, status: $status, population: $population, realms: $realms, mythicLeaderboards: $mythicLeaderboards, auctions: $auctions}';
  }
}
