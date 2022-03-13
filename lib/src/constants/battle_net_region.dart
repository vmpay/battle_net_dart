enum BattleNetRegion {
  us,
  eu,
  kr,
  tw,
  cn,
}

extension BattleNetRegionExtension on BattleNetRegion {
  String get slug {
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

  String get name {
    switch (this) {
      case BattleNetRegion.us:
        return 'North America';
      case BattleNetRegion.eu:
        return 'Europe';
      case BattleNetRegion.kr:
        return 'Korea';
      case BattleNetRegion.tw:
        return 'Taiwan';
      case BattleNetRegion.cn:
        return 'China';
    }
  }
}
