import 'package:meta/meta.dart';

/// A value object representing a WoW: Forever character's unique region-wide
/// identifier, composed of a first name and surname in lowercase.
///
/// Forever characters are realmless: they are identified by
/// `{name}-{surname}` (all lowercase), e.g. `ada-brightwood`.
///
/// Example:
/// ```dart
/// final slug = ForeverCharacterSlug(name: 'Ada', surname: 'Brightwood');
/// print(slug.value); // ada-brightwood
/// ```
@immutable
class ForeverCharacterSlug {
  /// The slug string used in API paths, e.g. `ada-brightwood`.
  final String value;

  /// Creates a [ForeverCharacterSlug] from [name] and [surname].
  ///
  /// Both are lowercased automatically before concatenation.
  ForeverCharacterSlug({required String name, required String surname})
    : value = '${name.toLowerCase()}-${surname.toLowerCase()}';

  /// Creates a [ForeverCharacterSlug] directly from a pre-formatted [slug]
  /// string (e.g. `'ada-brightwood'`).
  ///
  /// The slug is stored as-is; callers are responsible for correct casing.
  const ForeverCharacterSlug.fromSlug(this.value);

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterSlug &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
