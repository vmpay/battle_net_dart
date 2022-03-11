enum BattleNetRegion {
  us,
  eu,
  kr,
  tw,
  cn,
}

extension BattleNetRegionExtension on BattleNetRegion {
  String get name {
    switch (this) {
      case BattleNetRegion.us:
        return 'us';
      case BattleNetRegion.eu:
        return 'eu';
      case BattleNetRegion.kr:
        return 'kr';
      case BattleNetRegion.tw:
        return 'tw';
      case BattleNetRegion.cn:
        return 'cn';
    }
  }
}
