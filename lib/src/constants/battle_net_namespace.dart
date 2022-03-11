enum BattleNetNamespace {
  static,
  dynamic,
  profile,
  staticClassic1x,
  dynamicClassic1x,
  staticClassic,
  dynamicClassic,
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
