/// Scopes are used to request specific information from a site user.
/// Applications do not require any additional scopes to use Battle.net login.
/// Without scopes, applications can only gain access to a user's account ID
/// and BattleTag. To get any more specific user information, an application
/// needs to request permission from the user with scopes.
enum BattleNetScope {
  wowProfile,
  sc2Profile,
  d3Profile,
  openid,
}

/// [BattleNetScope] query parameter mapper
extension BattleNetScopeExtension on BattleNetScope {
  String get name {
    switch (this) {
      case BattleNetScope.wowProfile:
        return 'wow.profile';
      case BattleNetScope.sc2Profile:
        return 'sc2.profile';
      case BattleNetScope.d3Profile:
        return 'd3.profile';
      case BattleNetScope.openid:
        return 'openid';
    }
  }
}
