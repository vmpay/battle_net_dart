import 'dart:convert';
import 'package:meta/meta.dart';

/// Request url confirmation data model
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
