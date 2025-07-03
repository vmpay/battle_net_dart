import 'package:meta/meta.dart';

/// Represents a key with a self-referencing URL.
@immutable
class Key {
  /// The URL string for the key.
  final String href;

  /// Creates an instance of [Key].
  ///
  /// [href] is the URL string.
  const Key({required this.href});

  /// Creates an instance of [Key] from a JSON map.
  factory Key.fromJson(Map<String, dynamic> json) => Key(href: json['href']);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{'href': href};

  @override
  String toString() {
    return 'Key{href: $href}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Key && runtimeType == other.runtimeType && href == other.href;

  @override
  int get hashCode => href.hashCode;
}
