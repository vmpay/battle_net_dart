import 'dart:convert';

import 'package:meta/meta.dart';

/// Represents the data model for a self-reference URL.
///
/// This class is immutable and encapsulates a single string [href] representing
/// a URL that references itself.
@immutable
class Self {
  /// Constructs a [Self] instance.
  ///
  /// The [href] parameter is required and represents the URL string.
  const Self({
    required this.href,
  });

  /// The URL string that references itself.
  final String href;

  /// Creates a [Self] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [Self] instance using [fromJson].
  factory Self.fromRawJson(String str) => Self.fromJson(json.decode(str));

  /// Converts this [Self] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [Self] instance from a JSON map [json].
  ///
  /// Constructs a [Self] instance from a map retrieved from JSON,
  /// extracting the [href] as a string.
  factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json['href'],
      );

  /// Converts this [Self] instance to a JSON map.
  ///
  /// Converts the instance's [href] directly to a JSON-compatible format.
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
