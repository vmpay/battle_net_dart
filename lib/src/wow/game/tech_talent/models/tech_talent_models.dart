import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/tech-talent-tree/index`.
class TechTalentTreesIndexResponse extends ApiModel {
  /// Creates a [TechTalentTreesIndexResponse] from its JSON object.
  TechTalentTreesIndexResponse(super.raw);

  /// All tech talent trees.
  List<KeyedRef> get talentTrees => refsOf('talent_trees');
}

/// Response of `GET /data/wow/tech-talent-tree/{techTalentTreeId}`.
class TechTalentTreeResponse extends ApiModel {
  /// Creates a [TechTalentTreeResponse] from its JSON object.
  TechTalentTreeResponse(super.raw);

  /// The tech talent tree ID.
  int? get id => intOf('id');

  /// Maximum number of tiers in this tree.
  int? get maxTiers => intOf('max_tiers');

  /// Tech talents in this tree.
  List<KeyedRef> get talents => refsOf('talents');
}

/// Response of `GET /data/wow/tech-talent/index`.
class TechTalentsIndexResponse extends ApiModel {
  /// Creates a [TechTalentsIndexResponse] from its JSON object.
  TechTalentsIndexResponse(super.raw);

  /// All tech talents.
  List<KeyedRef> get talents => refsOf('talents');
}

/// Response of `GET /data/wow/tech-talent/{techTalentId}`.
class TechTalentResponse extends ApiModel {
  /// Creates a [TechTalentResponse] from its JSON object.
  TechTalentResponse(super.raw);

  /// The tech talent ID.
  int? get id => intOf('id');

  /// The localized tech talent name.
  String? get name => stringOf('name');

  /// The tech talent tree this talent belongs to.
  KeyedRef? get talentTree => refOf('talent_tree');

  /// The tier of this talent.
  int? get tier => intOf('tier');

  /// The display order within its tier.
  int? get displayOrder => intOf('display_order');

  /// The ID to use with `getTechTalentMedia`.
  int? get mediaId => idOf('media');
}
