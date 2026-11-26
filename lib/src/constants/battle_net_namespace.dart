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

  /// Profile Classic namespace (`profile-classic-{region}`).
  profileClassic,

  /// Profile Classic 1x (Classic Era) namespace (`profile-classic1x-{region}`).
  profileClassic1x,

  /// Profile Forever namespace (`profile-forever-{region}`).
  profileForever,

  /// Dynamic Forever namespace (`dynamic-forever-{region}`).
  dynamicForever,

  /// Static Forever namespace (`static-forever-{region}`).
  ///
  /// Blizzard resolves it to the current WoW: Forever game build
  /// (for example `static-1.60.1_70399-forever-eu`).
  staticForever,

  /// Static Forever namespace for item lookups (`static-forever-{region}`).
  @Deprecated(
    'Identical to staticForever. Use BattleNetNamespace.staticForever; '
    'this value will be removed in 0.5.0.',
  )
  staticForeverItem,
}

/// Extension on [BattleNetNamespace] to provide the string representation of the namespace.
extension BattleNetNamespaceExtension on BattleNetNamespace {
  /// Returns the namespace prefix. `doGet` appends `-{region}` to it.
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
      case BattleNetNamespace.profileClassic:
        return 'profile-classic';
      case BattleNetNamespace.profileClassic1x:
        return 'profile-classic1x';
      case BattleNetNamespace.profileForever:
        return 'profile-forever';
      case BattleNetNamespace.dynamicForever:
        return 'dynamic-forever';
      case BattleNetNamespace.staticForever:
      case BattleNetNamespace.staticForeverItem:
        return 'static-forever';
    }
  }
}
