import 'dart:convert';
import 'package:meta/meta.dart';

import 'self.dart';

/// Request url confirmation holder data model
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
