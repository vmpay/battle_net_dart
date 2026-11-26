import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/covenant/index`.
class CovenantsIndexResponse extends ApiModel {
  /// Creates a [CovenantsIndexResponse] from its JSON object.
  CovenantsIndexResponse(super.raw);

  /// All covenants.
  List<KeyedRef> get covenants => refsOf('covenants');
}

/// Response of `GET /data/wow/covenant/{covenantId}`.
class CovenantResponse extends ApiModel {
  /// Creates a [CovenantResponse] from its JSON object.
  CovenantResponse(super.raw);

  /// The covenant ID.
  int? get id => intOf('id');

  /// The localized covenant name.
  String? get name => stringOf('name');

  /// The localized covenant description.
  String? get description => stringOf('description');

  /// Soulbinds associated with this covenant.
  List<KeyedRef> get soulbinds => refsOf('soulbinds');

  /// The ID to use with `getCovenantMedia`.
  int? get mediaId => idOf('media');
}

/// Response of `GET /data/wow/covenant/soulbind/index`.
class SoulbindsIndexResponse extends ApiModel {
  /// Creates a [SoulbindsIndexResponse] from its JSON object.
  SoulbindsIndexResponse(super.raw);

  /// All soulbinds.
  List<KeyedRef> get soulbinds => refsOf('soulbinds');
}

/// Response of `GET /data/wow/covenant/soulbind/{soulbindId}`.
class SoulbindResponse extends ApiModel {
  /// Creates a [SoulbindResponse] from its JSON object.
  SoulbindResponse(super.raw);

  /// The soulbind ID.
  int? get id => intOf('id');

  /// The localized soulbind name.
  String? get name => stringOf('name');

  /// The covenant this soulbind belongs to.
  KeyedRef? get covenant => refOf('covenant');

  /// The creature associated with this soulbind.
  KeyedRef? get creature => refOf('creature');

  /// The follower associated with this soulbind.
  KeyedRef? get follower => refOf('follower');

  /// The talent tree for this soulbind.
  KeyedRef? get talentTree => refOf('talent_tree');
}

/// Response of `GET /data/wow/covenant/conduit/index`.
class ConduitsIndexResponse extends ApiModel {
  /// Creates a [ConduitsIndexResponse] from its JSON object.
  ConduitsIndexResponse(super.raw);

  /// All conduits.
  List<KeyedRef> get conduits => refsOf('conduits');
}

/// Response of `GET /data/wow/covenant/conduit/{conduitId}`.
class ConduitResponse extends ApiModel {
  /// Creates a [ConduitResponse] from its JSON object.
  ConduitResponse(super.raw);

  /// The conduit ID.
  int? get id => intOf('id');

  /// The localized conduit name.
  String? get name => stringOf('name');

  /// The item representing this conduit.
  KeyedRef? get item => refOf('item');

  /// The conduit socket type, for example `POTENCY`, `FINESSE`, or `ENDURANCE`.
  String? get socketType => typeOf('socket_type');
}
