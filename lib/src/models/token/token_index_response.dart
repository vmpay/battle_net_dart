import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/links.dart';

/// WoW Token index response model
@immutable
class TokenIndexResponse {
  const TokenIndexResponse({
    required this.links,
    required this.lastUpdatedTimestamp,
    required this.price,
  });

  final Links links;
  final int lastUpdatedTimestamp;
  final int price;

  factory TokenIndexResponse.fromRawJson(String str) =>
      TokenIndexResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenIndexResponse.fromJson(Map<String, dynamic> json) =>
      TokenIndexResponse(
        links: Links.fromJson(json['_links']),
        lastUpdatedTimestamp: json['last_updated_timestamp'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_links': links.toJson(),
        'last_updated_timestamp': lastUpdatedTimestamp,
        'price': price,
      };

  @override
  String toString() {
    return 'TokenIndex{links: $links, lastUpdatedTimestamp: $lastUpdatedTimestamp, price: $price}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenIndexResponse &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          lastUpdatedTimestamp == other.lastUpdatedTimestamp &&
          price == other.price;

  @override
  int get hashCode =>
      links.hashCode ^ lastUpdatedTimestamp.hashCode ^ price.hashCode;
}
