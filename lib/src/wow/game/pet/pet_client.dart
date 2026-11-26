import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/pet_models.dart';

/// Client for the Pet API (`battleNet.wow.pet`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class PetClient extends ApiClient {
  /// Creates a [PetClient].
  PetClient({required super.connectionTimeout, super.client});

  /// Returns an index of battle pets.
  Future<PetsIndexResponse> getPetsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pet/index',
    parse: PetsIndexResponse.new,
  );

  /// Returns a battle pet by [petId].
  Future<PetResponse> getPet({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int petId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pet/$petId',
    parse: PetResponse.new,
  );

  /// Returns media for a battle pet by [petId].
  Future<MediaResponse> getPetMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int petId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/pet/$petId',
    parse: MediaResponse.new,
  );

  /// Returns an index of pet abilities.
  Future<PetAbilitiesIndexResponse> getPetAbilitiesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pet-ability/index',
    parse: PetAbilitiesIndexResponse.new,
  );

  /// Returns a pet ability by [petAbilityId].
  Future<PetAbilityResponse> getPetAbility({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int petAbilityId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/pet-ability/$petAbilityId',
    parse: PetAbilityResponse.new,
  );

  /// Returns media for a pet ability by [petAbilityId].
  Future<MediaResponse> getPetAbilityMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int petAbilityId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/media/pet-ability/$petAbilityId',
    parse: MediaResponse.new,
  );
}
