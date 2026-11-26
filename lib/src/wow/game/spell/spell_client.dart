import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/spell_models.dart';

/// Client for the Spell API (`battleNet.wow.spell`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class SpellClient extends ApiClient {
  /// Creates a [SpellClient].
  SpellClient({required super.connectionTimeout, super.client});

  /// Returns a spell by [spellId].
  Future<SpellResponse> getSpell({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int spellId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/spell/$spellId',
    parse: SpellResponse.new,
  );

  /// Returns media (icon) for a spell by [spellId].
  Future<MediaResponse> getSpellMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int spellId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/spell/$spellId',
    parse: MediaResponse.new,
  );

  /// Performs a search of spells.
  Future<SearchResponse> searchSpells({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    Map<String, String>? filters,
    String orderBy = 'id',
    int page = 1,
    int? pageSize,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/search/spell',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
