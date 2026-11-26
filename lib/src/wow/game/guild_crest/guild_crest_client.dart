import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/guild_crest_models.dart';

/// Client for the Guild Crest API (`battleNet.wow.guildCrest`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class GuildCrestClient extends ApiClient {
  /// Creates a [GuildCrestClient].
  GuildCrestClient({required super.connectionTimeout, super.client});

  /// Returns an index of guild crest components (emblems, borders, colors).
  Future<GuildCrestComponentsIndexResponse> getGuildCrestComponentsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/guild-crest/index',
    parse: GuildCrestComponentsIndexResponse.new,
  );

  /// Returns media for a guild crest border by [borderId].
  Future<MediaResponse> getGuildCrestBorderMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int borderId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/guild-crest/border/$borderId',
    parse: MediaResponse.new,
  );

  /// Returns media for a guild crest emblem by [emblemId].
  Future<MediaResponse> getGuildCrestEmblemMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int emblemId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/guild-crest/emblem/$emblemId',
    parse: MediaResponse.new,
  );
}
