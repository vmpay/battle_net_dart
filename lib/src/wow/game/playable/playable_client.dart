import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/playable_models.dart';

/// Client for the Playable Class API (`battleNet.wow.playableClass`).
class PlayableClassClient extends ApiClient {
  /// Creates a [PlayableClassClient].
  PlayableClassClient({required super.connectionTimeout, super.client});

  /// Returns an index of playable classes.
  Future<PlayableClassesIndexResponse> getPlayableClassesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-class/index',
    parse: PlayableClassesIndexResponse.new,
  );

  /// Returns a playable class by [classId].
  Future<PlayableClassResponse> getPlayableClass({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int classId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-class/$classId',
    parse: PlayableClassResponse.new,
  );

  /// Returns media for a playable class by [classId].
  Future<MediaResponse> getPlayableClassMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int classId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/playable-class/$classId',
    parse: MediaResponse.new,
  );

  /// Returns PvP talent slots for a playable class by [classId].
  Future<PvpTalentSlotsResponse> getPvpTalentSlots({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int classId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-class/$classId/pvp-talent-slots',
    parse: PvpTalentSlotsResponse.new,
  );
}

/// Client for the Playable Race API (`battleNet.wow.playableRace`).
class PlayableRaceClient extends ApiClient {
  /// Creates a [PlayableRaceClient].
  PlayableRaceClient({required super.connectionTimeout, super.client});

  /// Returns an index of playable races.
  Future<PlayableRacesIndexResponse> getPlayableRacesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-race/index',
    parse: PlayableRacesIndexResponse.new,
  );

  /// Returns a playable race by [raceId].
  Future<PlayableRaceResponse> getPlayableRace({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int raceId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-race/$raceId',
    parse: PlayableRaceResponse.new,
  );
}

/// Client for the Playable Specialization API
/// (`battleNet.wow.playableSpecialization`).
class PlayableSpecializationClient extends ApiClient {
  /// Creates a [PlayableSpecializationClient].
  PlayableSpecializationClient({
    required super.connectionTimeout,
    super.client,
  });

  /// Returns an index of playable specializations.
  Future<PlayableSpecializationsIndexResponse> getPlayableSpecializationsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-specialization/index',
    parse: PlayableSpecializationsIndexResponse.new,
  );

  /// Returns a playable specialization by [specId].
  Future<PlayableSpecializationResponse> getPlayableSpecialization({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int specId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/playable-specialization/$specId',
    parse: PlayableSpecializationResponse.new,
  );

  /// Returns media for a playable specialization by [specId].
  Future<MediaResponse> getPlayableSpecializationMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int specId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/playable-specialization/$specId',
    parse: MediaResponse.new,
  );
}
