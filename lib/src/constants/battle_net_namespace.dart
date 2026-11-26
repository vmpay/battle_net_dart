/// Namespaces allow JSON documents to be published contextually in relation
/// to a specific patch or point in time.
enum BattleNetNamespace {
  /// Static namespace.
  static,

  /// Dynamic namespace.
  dynamic,

  /// Profile namespace.
  profile,

  /// Static Classic 1x namespace.
  staticClassic1x,

  /// Dynamic Classic 1x namespace.
  dynamicClassic1x,

  /// Static Classic namespace.
  staticClassic,

  /// Dynamic Classic namespace.
  dynamicClassic,

  /// Profile Forever namespace (`profile-forever-{region}`).
  profileForever,

  /// Dynamic Forever namespace (`dynamic-forever-{region}`).
  dynamicForever,

  /// Static Forever namespace — versioned (`static-{version}-forever-{region}`).
  ///
  /// Used for versioned static data such as item/spell lookups in WoW: Forever.
  /// Pass a `foreverStaticVersion` when constructing the [BattleNet] client to
  /// override the default version string.
  staticForever,

  /// Static Forever namespace — unversioned (`static-forever-{region}`).
  ///
  /// Used for item lookups where no pinned version is required.
  staticForeverItem,
}

/// Extension on [BattleNetNamespace] to provide the string representation of the namespace.
extension BattleNetNamespaceExtension on BattleNetNamespace {
  /// Returns the string representation of the [BattleNetNamespace] enum value.
  ///
  /// For [BattleNetNamespace.staticForever] the caller must append the version
  /// segment manually: `'${BattleNetNamespace.staticForever.name}-$version-forever'`.
  /// All other namespaces are complete prefix strings that `doGet` will
  /// append `-{region}` to automatically.
  String get name {
    switch (this) {
      case BattleNetNamespace.static:
        return 'static';
      case BattleNetNamespace.dynamic:
        return 'dynamic';
      case BattleNetNamespace.profile:
        return 'profile';
      case BattleNetNamespace.staticClassic1x:
        return 'static-classic1x';
      case BattleNetNamespace.dynamicClassic1x:
        return 'dynamic-classic1x';
      case BattleNetNamespace.staticClassic:
        return 'static-classic';
      case BattleNetNamespace.dynamicClassic:
        return 'dynamic-classic';
      case BattleNetNamespace.profileForever:
        return 'profile-forever';
      case BattleNetNamespace.dynamicForever:
        return 'dynamic-forever';
      case BattleNetNamespace.staticForever:
        // Callers must supply the version prefix; this base is intentionally
        // incomplete and resolved in ForeverItemClient / http_utils via
        // the foreverStaticVersion parameter.
        return 'static-forever';
      case BattleNetNamespace.staticForeverItem:
        return 'static-forever';
    }
  }
}
