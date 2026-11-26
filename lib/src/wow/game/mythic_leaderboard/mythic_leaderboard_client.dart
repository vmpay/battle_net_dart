import 'package:battle_net/src/constants/battle_net_faction.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import '../mythic_keystone_dungeon/models/mythic_keystone_models.dart';

/// Client for the Mythic Keystone Leaderboard API
/// (`battleNet.wow.mythicKeystoneLeaderboard`).
class MythicKeystoneLeaderboardClient extends ApiClient {
  /// Creates a [MythicKeystoneLeaderboardClient].
  MythicKeystoneLeaderboardClient({
    required super.connectionTimeout,
    super.client,
  });

  /// Returns an index of Mythic Keystone leaderboards for a connected realm.
  Future<MythicKeystoneLeaderboardsIndexResponse>
  getMythicKeystoneLeaderboardsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int connectedRealmId,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path:
        '/data/wow/connected-realm/$connectedRealmId/mythic-leaderboard/index',
    parse: MythicKeystoneLeaderboardsIndexResponse.new,
  );

  /// Returns a weekly Mythic Keystone leaderboard for a dungeon and [period].
  Future<MythicKeystoneLeaderboardResponse> getMythicKeystoneLeaderboard({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int connectedRealmId,
    required int dungeonId,
    required int period,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path:
        '/data/wow/connected-realm/$connectedRealmId/mythic-leaderboard/$dungeonId/period/$period',
    parse: MythicKeystoneLeaderboardResponse.new,
  );
}

/// Client for the Mythic Raid Leaderboard API
/// (`battleNet.wow.mythicRaidLeaderboard`).
class MythicRaidLeaderboardClient extends ApiClient {
  /// Creates a [MythicRaidLeaderboardClient].
  MythicRaidLeaderboardClient({required super.connectionTimeout, super.client});

  /// Returns the Hall of Fame leaderboard for a [raid] slug (for example
  /// `uldir`) and [faction].
  Future<MythicRaidLeaderboardResponse> getMythicRaidLeaderboard({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String raid,
    required BattleNetFaction faction,
    BattleNetNamespace namespace = BattleNetNamespace.dynamic,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/leaderboard/hall-of-fame/$raid/${faction.name}',
    parse: MythicRaidLeaderboardResponse.new,
  );
}
