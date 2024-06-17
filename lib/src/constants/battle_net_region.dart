/// API data is limited to specific regions. For example, US APIs accessed
/// through us.battle.net only contain data from US battlegroups and realms.
/// Locale support is limited to locations supported on Blizzard community game sites.
enum BattleNetRegion {
  us,
  eu,
  kr,
  tw,
}

/// [BattleNetRegion] query and title parameters mapper
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
    }
  }
}
