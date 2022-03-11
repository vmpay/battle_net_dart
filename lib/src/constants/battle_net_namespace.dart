enum BattleNetNamespace {
  static,
  dynamic,
  profile,
}

extension BattleNetNamespaceExtension on BattleNetNamespace {
  String get name {
    switch (this) {
      case BattleNetNamespace.static:
        return 'static';
      case BattleNetNamespace.dynamic:
        return 'dynamic';
      case BattleNetNamespace.profile:
        return 'profile';
    }
  }
}
