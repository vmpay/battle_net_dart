import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/talent-tree/index`.
class TalentTreesIndexResponse extends ApiModel {
  /// Creates a [TalentTreesIndexResponse] from its JSON object.
  TalentTreesIndexResponse(super.raw);

  /// Spec talent trees.
  List<KeyedRef> get specTalentTrees => refsOf('spec_talent_trees');

  /// Class talent trees.
  List<KeyedRef> get classTalentTrees => refsOf('class_talent_trees');

  /// Hero talent trees.
  List<KeyedRef> get heroTalentTrees => refsOf('hero_talent_trees');
}

/// Response of `GET /data/wow/talent-tree/{talentTreeId}/playable-specialization/{specId}`.
class TalentTreeResponse extends ApiModel {
  /// Creates a [TalentTreeResponse] from its JSON object.
  TalentTreeResponse(super.raw);

  /// The talent tree ID.
  int? get id => intOf('id');

  /// The localized talent tree name.
  String? get name => stringOf('name');

  /// The playable class.
  KeyedRef? get playableClass => refOf('playable_class');

  /// The playable specialization.
  KeyedRef? get playableSpecialization => refOf('playable_specialization');
}

/// Response of `GET /data/wow/talent-tree/{talentTreeId}`.
class TalentTreeNodesResponse extends ApiModel {
  /// Creates a [TalentTreeNodesResponse] from its JSON object.
  TalentTreeNodesResponse(super.raw);

  /// The talent tree ID.
  int? get id => intOf('id');
}

/// Response of `GET /data/wow/talent/index`.
class TalentsIndexResponse extends ApiModel {
  /// Creates a [TalentsIndexResponse] from its JSON object.
  TalentsIndexResponse(super.raw);

  /// All talents.
  List<KeyedRef> get talents => refsOf('talents');
}

/// Response of `GET /data/wow/talent/{talentId}`.
class TalentResponse extends ApiModel {
  /// Creates a [TalentResponse] from its JSON object.
  TalentResponse(super.raw);

  /// The talent ID.
  int? get id => intOf('id');

  /// The spell associated with this talent.
  KeyedRef? get spell => refOf('spell');

  /// The playable class.
  KeyedRef? get playableClass => refOf('playable_class');

  /// The playable specialization, if spec-specific.
  KeyedRef? get playableSpecialization => refOf('playable_specialization');
}

/// Response of `GET /data/wow/pvp-talent/index`.
class PvpTalentsIndexResponse extends ApiModel {
  /// Creates a [PvpTalentsIndexResponse] from its JSON object.
  PvpTalentsIndexResponse(super.raw);

  /// All PvP talents.
  List<KeyedRef> get pvpTalents => refsOf('pvp_talents');
}

/// Response of `GET /data/wow/pvp-talent/{pvpTalentId}`.
class PvpTalentResponse extends ApiModel {
  /// Creates a [PvpTalentResponse] from its JSON object.
  PvpTalentResponse(super.raw);

  /// The PvP talent ID.
  int? get id => intOf('id');

  /// The spell associated with this PvP talent.
  KeyedRef? get spell => refOf('spell');

  /// The playable specialization.
  KeyedRef? get playableSpecialization => refOf('playable_specialization');

  /// The localized PvP talent description.
  String? get description => stringOf('description');

  /// The character level at which this PvP talent unlocks.
  int? get unlockPlayerLevel => intOf('unlock_player_level');
}
