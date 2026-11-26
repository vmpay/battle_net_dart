import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/creature-family/index`.
class CreatureFamiliesIndexResponse extends ApiModel {
  /// Creates a [CreatureFamiliesIndexResponse] from its JSON object.
  CreatureFamiliesIndexResponse(super.raw);

  /// All creature families.
  List<KeyedRef> get creatureFamilies => refsOf('creature_families');
}

/// Response of `GET /data/wow/creature-family/{creatureFamilyId}`.
class CreatureFamilyResponse extends ApiModel {
  /// Creates a [CreatureFamilyResponse] from its JSON object.
  CreatureFamilyResponse(super.raw);

  /// The creature family ID.
  int? get id => intOf('id');

  /// The localized creature family name.
  String? get name => stringOf('name');

  /// The hunter pet specialization for this family, if any.
  KeyedRef? get specialization => refOf('specialization');

  /// The ID to use with `getCreatureFamilyMedia`.
  int? get mediaId => idOf('media');
}

/// Response of `GET /data/wow/creature-type/index`.
class CreatureTypesIndexResponse extends ApiModel {
  /// Creates a [CreatureTypesIndexResponse] from its JSON object.
  CreatureTypesIndexResponse(super.raw);

  /// All creature types.
  List<KeyedRef> get creatureTypes => refsOf('creature_types');
}

/// Response of `GET /data/wow/creature-type/{creatureTypeId}`.
class CreatureTypeResponse extends ApiModel {
  /// Creates a [CreatureTypeResponse] from its JSON object.
  CreatureTypeResponse(super.raw);

  /// The creature type ID.
  int? get id => intOf('id');

  /// The localized creature type name.
  String? get name => stringOf('name');
}

/// Response of `GET /data/wow/creature/{creatureId}`.
class CreatureResponse extends ApiModel {
  /// Creates a [CreatureResponse] from its JSON object.
  CreatureResponse(super.raw);

  /// The creature ID.
  int? get id => intOf('id');

  /// The localized creature name.
  String? get name => stringOf('name');

  /// The creature type.
  KeyedRef? get type => refOf('type');

  /// The creature family.
  KeyedRef? get family => refOf('family');

  /// Whether the creature is tameable by hunters.
  bool? get isTameable => boolOf('is_tameable');

  /// The creature display references (use `id` with `getCreatureDisplayMedia`).
  List<KeyedRef> get creatureDisplays => refsOf('creature_displays');
}
