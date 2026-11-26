import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/creature_models.dart';

/// Client for the Creature API (`battleNet.wow.creature`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class CreatureClient extends ApiClient {
  /// Creates a [CreatureClient].
  CreatureClient({required super.connectionTimeout, super.client});

  /// Returns an index of creature families.
  Future<CreatureFamiliesIndexResponse> getCreatureFamiliesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/creature-family/index',
    parse: CreatureFamiliesIndexResponse.new,
  );

  /// Returns a creature family by [creatureFamilyId].
  Future<CreatureFamilyResponse> getCreatureFamily({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int creatureFamilyId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/creature-family/$creatureFamilyId',
    parse: CreatureFamilyResponse.new,
  );

  /// Returns media for a creature family by [creatureFamilyId].
  Future<MediaResponse> getCreatureFamilyMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int creatureFamilyId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/creature-family/$creatureFamilyId',
    parse: MediaResponse.new,
  );

  /// Returns an index of creature types.
  Future<CreatureTypesIndexResponse> getCreatureTypesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/creature-type/index',
    parse: CreatureTypesIndexResponse.new,
  );

  /// Returns a creature type by [creatureTypeId].
  Future<CreatureTypeResponse> getCreatureType({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int creatureTypeId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/creature-type/$creatureTypeId',
    parse: CreatureTypeResponse.new,
  );

  /// Returns a creature by [creatureId].
  Future<CreatureResponse> getCreature({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int creatureId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/creature/$creatureId',
    parse: CreatureResponse.new,
  );

  /// Returns media for a creature display by [creatureDisplayId].
  Future<MediaResponse> getCreatureDisplayMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int creatureDisplayId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/creature-display/$creatureDisplayId',
    parse: MediaResponse.new,
  );

  /// Performs a search of creatures.
  Future<SearchResponse> searchCreatures({
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
    path: '/data/wow/search/creature',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );
}
