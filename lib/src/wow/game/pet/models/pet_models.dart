import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/pet/index`.
class PetsIndexResponse extends ApiModel {
  /// Creates a [PetsIndexResponse] from its JSON object.
  PetsIndexResponse(super.raw);

  /// All battle pets.
  List<KeyedRef> get pets => refsOf('pets');
}

/// Response of `GET /data/wow/pet/{petId}`.
class PetResponse extends ApiModel {
  /// Creates a [PetResponse] from its JSON object.
  PetResponse(super.raw);

  /// The pet ID.
  int? get id => intOf('id');

  /// The localized pet name.
  String? get name => stringOf('name');

  /// The localized pet description.
  String? get description => stringOf('description');

  /// The battle pet type, for example `HUMANOID` or `BEAST`.
  String? get battlePetType => typeOf('battle_pet_type');

  /// Whether the pet is capturable in the wild.
  bool? get isCapturable => boolOf('is_capturable');

  /// Whether the pet is tradable.
  bool? get isTradable => boolOf('is_tradable');

  /// Whether the pet can participate in pet battles.
  bool? get isBattlepet => boolOf('is_battlepet');

  /// Whether the pet is Alliance-only.
  bool? get isAllianceOnly => boolOf('is_alliance_only');

  /// Whether the pet is Horde-only.
  bool? get isHordeOnly => boolOf('is_horde_only');

  /// The ID to use with `getPetMedia`.
  int? get mediaId => idOf('media');
}

/// Response of `GET /data/wow/pet-ability/index`.
class PetAbilitiesIndexResponse extends ApiModel {
  /// Creates a [PetAbilitiesIndexResponse] from its JSON object.
  PetAbilitiesIndexResponse(super.raw);

  /// All pet abilities.
  List<KeyedRef> get abilities => refsOf('abilities');
}

/// Response of `GET /data/wow/pet-ability/{petAbilityId}`.
class PetAbilityResponse extends ApiModel {
  /// Creates a [PetAbilityResponse] from its JSON object.
  PetAbilityResponse(super.raw);

  /// The pet ability ID.
  int? get id => intOf('id');

  /// The localized ability name.
  String? get name => stringOf('name');

  /// The battle pet type.
  String? get battlePetType => typeOf('battle_pet_type');

  /// Number of rounds the ability lasts.
  int? get rounds => intOf('rounds');

  /// The ID to use with `getPetAbilityMedia`.
  int? get mediaId => idOf('media');
}
