import 'dart:convert';

import 'package:meta/meta.dart';

import '../common/links.dart';

/// Represents the response model for WoW Token index information.
///
/// This class is immutable and encapsulates data related to WoW Token index,
/// including links, last updated timestamp, and current price.
@immutable
class TokenIndexResponse {
  /// Constructs a [TokenIndexResponse] instance.
  ///
  /// The [links] parameter is required and represents the links associated with the response.
  /// The [lastUpdatedTimestamp] parameter is required and indicates the timestamp when the data was last updated.
  /// The [price] parameter is required and represents the current price of the WoW Token.
  const TokenIndexResponse({
    required this.links,
    required this.lastUpdatedTimestamp,
    required this.price,
  });

  /// Links associated with the token index response.
  final Links links;

  /// Timestamp indicating when the token index data was last updated.
  final int lastUpdatedTimestamp;

  /// Current price of the WoW Token.
  final int price;

  /// Creates a [TokenIndexResponse] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [TokenIndexResponse] instance using [fromJson].
  factory TokenIndexResponse.fromRawJson(String str) =>
      TokenIndexResponse.fromJson(json.decode(str));

  /// Converts this [TokenIndexResponse] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [TokenIndexResponse] instance from a JSON map [json].
  ///
  /// Constructs a [TokenIndexResponse] instance from a map retrieved from JSON,
  /// extracting the [links] as a [Links] instance, [lastUpdatedTimestamp] as an integer,
  /// and [price] as an integer.
  factory TokenIndexResponse.fromJson(Map<String, dynamic> json) =>
      TokenIndexResponse(
        links: Links.fromJson(json['_links']),
        lastUpdatedTimestamp: json['last_updated_timestamp'],
        price: json['price'],
      );

  /// Converts this [TokenIndexResponse] instance to a JSON map.
  ///
  /// Converts the instance's [links] to JSON using [links.toJson],
  /// and includes [lastUpdatedTimestamp] and [price] directly.
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
