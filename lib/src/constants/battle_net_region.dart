/// API data is limited to specific regions. For example, US APIs accessed
/// through us.battle.net only contain data from US battlegroups and realms.
/// Locale support is limited to locations supported on Blizzard community game sites.
enum BattleNetRegion {
  /// North America region.
  us,

  /// Europe region.
  eu,

  /// Korea region.
  kr,

  /// Taiwan region.
  tw,
}

/// Extension on [BattleNetRegion] to provide slug and name representations.
extension BattleNetRegionExtension on BattleNetRegion {
  /// Returns the slug representation of the [BattleNetRegion] enum value.
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

  /// Returns the full name representation of the [BattleNetRegion] enum value.
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
