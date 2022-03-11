enum BattleNetLocale {
  en_US,
  es_MX,
  pt_BR,
  de_DE,
  en_GB,
  es_ES,
  fr_FR,
  it_IT,
  ru_RU,
  ko_KR,
  zh_TW,
  zh_CN,
}

extension BattleNetLocaleExtension on BattleNetLocale {
  String get name {
    switch (this) {
      case BattleNetLocale.en_US:
        return 'en_US';
      case BattleNetLocale.es_MX:
        return 'es_MX';
      case BattleNetLocale.pt_BR:
        return 'pt_BR';
      case BattleNetLocale.de_DE:
        return 'de_DE';
      case BattleNetLocale.en_GB:
        return 'en_GB';
      case BattleNetLocale.es_ES:
        return 'es_ES';
      case BattleNetLocale.fr_FR:
        return 'fr_FR';
      case BattleNetLocale.it_IT:
        return 'it_IT';
      case BattleNetLocale.ru_RU:
        return 'ru_RU';
      case BattleNetLocale.ko_KR:
        return 'ko_KR';
      case BattleNetLocale.zh_TW:
        return 'zh_TW';
      case BattleNetLocale.zh_CN:
        return 'zh_CN';
    }
  }
}
