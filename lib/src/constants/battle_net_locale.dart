/// All available API resources provide localized strings using the locale query
/// string parameter. Supported locales vary from region to region and align with
/// those supported on Blizzard community sites.
enum BattleNetLocale {
  enUS,
  esMX,
  ptBR,
  deDE,
  enGB,
  esES,
  frFR,
  itIT,
  ruRU,
  koKR,
  zhTW,
  zhCN,
}

/// [BattleNetLocale] query parameter mapper
extension BattleNetLocaleExtension on BattleNetLocale {
  String get name {
    switch (this) {
      case BattleNetLocale.enUS:
        return 'en_US';
      case BattleNetLocale.esMX:
        return 'es_MX';
      case BattleNetLocale.ptBR:
        return 'pt_BR';
      case BattleNetLocale.deDE:
        return 'de_DE';
      case BattleNetLocale.enGB:
        return 'en_GB';
      case BattleNetLocale.esES:
        return 'es_ES';
      case BattleNetLocale.frFR:
        return 'fr_FR';
      case BattleNetLocale.itIT:
        return 'it_IT';
      case BattleNetLocale.ruRU:
        return 'ru_RU';
      case BattleNetLocale.koKR:
        return 'ko_KR';
      case BattleNetLocale.zhTW:
        return 'zh_TW';
      case BattleNetLocale.zhCN:
        return 'zh_CN';
    }
  }
}
