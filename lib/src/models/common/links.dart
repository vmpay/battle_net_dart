import 'dart:convert';

import 'package:meta/meta.dart';

import 'self.dart';

/// Represents the data model for holding request URL confirmations.
///
/// This class is immutable and encapsulates a [self] instance of [Self] class
/// which represents a self-reference URL.
@immutable
class Links {
  /// Constructs a [Links] instance.
  ///
  /// The [self] parameter is required and represents a self-reference URL instance.
  const Links({
    required this.self,
  });

  /// The self-reference URL instance.
  final Self self;

  /// Creates a [Links] instance from a raw JSON string [str].
  ///
  /// Converts the JSON string into a map using [json.decode], and then constructs
  /// a [Links] instance using [fromJson].
  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  /// Converts this [Links] instance to a raw JSON string representation.
  ///
  /// Converts the instance to a map using [toJson], and then encodes it to a JSON
  /// string using [json.encode].
  String toRawJson() => json.encode(toJson());

  /// Creates a [Links] instance from a JSON map [json].
  ///
  /// Constructs a [Links] instance from a map retrieved from JSON,
  /// extracting the [self] as a [Self] instance.
  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: Self.fromJson(json['self']),
      );

  /// Converts this [Links] instance to a JSON map.
  ///
  /// Converts the instance's [self] to a JSON-compatible format.
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
