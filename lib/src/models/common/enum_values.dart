/// Utility class for mapping enum values to and from strings.
///
/// This class provides functionality to map between enum values [T] and their
/// corresponding string representations. It accepts a [map] containing mappings
/// from string keys to enum values [T].
class EnumValues<T> {
  /// A map that associates string keys with enum values [T].
  Map<String, T> map;

  /// A late-initialized map that associates enum values [T] with their string keys.
  late Map<T, String> reverseMap;

  /// Constructs an [EnumValues] instance with a [map] of string keys to enum values [T].
  EnumValues(this.map);

  /// Returns a map that associates enum values [T] with their corresponding string keys.
  ///
  /// The [reverseMap] is constructed lazily from the [map] provided during initialization.
  Map<T, String> get reverse {
    reverseMap = map.map((String k, T v) => MapEntry<T, String>(v, k));
    return reverseMap;
  }
}
