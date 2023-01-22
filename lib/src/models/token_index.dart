import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class TokenIndex {
  const TokenIndex({
    required this.links,
    required this.lastUpdatedTimestamp,
    required this.price,
  });

  final Links links;
  final int lastUpdatedTimestamp;
  final int price;

  factory TokenIndex.fromRawJson(String str) =>
      TokenIndex.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenIndex.fromJson(Map<String, dynamic> json) => TokenIndex(
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
      other is TokenIndex &&
          runtimeType == other.runtimeType &&
          links == other.links &&
          lastUpdatedTimestamp == other.lastUpdatedTimestamp &&
          price == other.price;

  @override
  int get hashCode =>
      links.hashCode ^ lastUpdatedTimestamp.hashCode ^ price.hashCode;
}

@immutable
class Links {
  const Links({
    required this.self,
  });

  final Self self;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: Self.fromJson(json['self']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'self': self.toJson(),
      };

  @override
  String toString() {
    return 'Links{self: $self}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Links && runtimeType == other.runtimeType && self == other.self;

  @override
  int get hashCode => self.hashCode;
}

@immutable
class Self {
  const Self({
    required this.href,
  });

  final String href;

  factory Self.fromRawJson(String str) => Self.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json['href'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'href': href,
      };

  @override
  String toString() {
    return 'Self{href: $href}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Self && runtimeType == other.runtimeType && href == other.href;

  @override
  int get hashCode => href.hashCode;
}
