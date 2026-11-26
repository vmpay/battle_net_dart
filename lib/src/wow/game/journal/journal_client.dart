import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/journal_models.dart';

/// Client for the Journal API (`battleNet.wow.journal`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class JournalClient extends ApiClient {
  /// Creates a [JournalClient].
  JournalClient({required super.connectionTimeout, super.client});

  /// Returns an index of journal expansions.
  Future<JournalExpansionsIndexResponse> getJournalExpansionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-expansion/index',
    parse: JournalExpansionsIndexResponse.new,
  );

  /// Returns a journal expansion by [journalExpansionId].
  Future<JournalExpansionResponse> getJournalExpansion({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int journalExpansionId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-expansion/$journalExpansionId',
    parse: JournalExpansionResponse.new,
  );

  /// Returns an index of journal encounters.
  Future<JournalEncountersIndexResponse> getJournalEncountersIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-encounter/index',
    parse: JournalEncountersIndexResponse.new,
  );

  /// Returns a journal encounter by [journalEncounterId].
  Future<JournalEncounterResponse> getJournalEncounter({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int journalEncounterId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-encounter/$journalEncounterId',
    parse: JournalEncounterResponse.new,
  );

  /// Performs a search of journal encounters.
  Future<SearchResponse> searchJournalEncounters({
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
    path: '/data/wow/search/journal-encounter',
    query: searchQuery(
      orderBy: orderBy,
      page: page,
      pageSize: pageSize,
      filters: filters,
    ),
    parse: SearchResponse.new,
  );

  /// Returns an index of journal instances.
  Future<JournalInstancesIndexResponse> getJournalInstancesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-instance/index',
    parse: JournalInstancesIndexResponse.new,
  );

  /// Returns a journal instance by [journalInstanceId].
  Future<JournalInstanceResponse> getJournalInstance({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int journalInstanceId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/journal-instance/$journalInstanceId',
    parse: JournalInstanceResponse.new,
  );

  /// Returns media for a journal instance by [journalInstanceId].
  Future<MediaResponse> getJournalInstanceMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int journalInstanceId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/journal-instance/$journalInstanceId',
    parse: MediaResponse.new,
  );
}
