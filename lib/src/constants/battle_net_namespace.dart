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
}

/// Extension on [BattleNetNamespace] to provide the string representation of the namespace.
extension BattleNetNamespaceExtension on BattleNetNamespace {
  /// Returns the string representation of the [BattleNetNamespace] enum value.
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
    }
  }
}
