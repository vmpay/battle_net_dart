import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/guild_models.dart';

/// Client for the Guild Profile API (`battleNet.wow.guild`).
///
/// [namespace] defaults to [BattleNetNamespace.profile] (Retail).
/// Guild name slugs are lowercased automatically before building request paths.
class GuildClient extends ApiClient {
  /// Creates a [GuildClient].
  GuildClient({required super.connectionTimeout, super.client});

  String _basePath(String realmSlug, String nameSlug) =>
      '/data/wow/guild/$realmSlug/${nameSlug.toLowerCase()}';

  /// Returns a guild's summary profile.
  Future<GuildResponse> getGuild({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String nameSlug,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: _basePath(realmSlug, nameSlug),
    parse: GuildResponse.new,
  );

  /// Returns a guild's recent activity log.
  Future<GuildActivityResponse> getGuildActivity({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String nameSlug,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, nameSlug)}/activity',
    parse: GuildActivityResponse.new,
  );

  /// Returns a guild's achievements.
  Future<GuildAchievementsResponse> getGuildAchievements({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String nameSlug,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, nameSlug)}/achievements',
    parse: GuildAchievementsResponse.new,
  );

  /// Returns a guild's member roster.
  Future<GuildRosterResponse> getGuildRoster({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String nameSlug,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, nameSlug)}/roster',
    parse: GuildRosterResponse.new,
  );
}
