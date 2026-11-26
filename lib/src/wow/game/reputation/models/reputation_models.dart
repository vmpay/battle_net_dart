import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/reputation-faction/index`.
class ReputationFactionsIndexResponse extends ApiModel {
  /// Creates a [ReputationFactionsIndexResponse] from its JSON object.
  ReputationFactionsIndexResponse(super.raw);

  /// All reputation factions.
  List<KeyedRef> get factions => refsOf('factions');

  /// Root reputation factions.
  List<KeyedRef> get rootFactions => refsOf('root_factions');
}

/// Response of `GET /data/wow/reputation-faction/{reputationFactionId}`.
class ReputationFactionResponse extends ApiModel {
  /// Creates a [ReputationFactionResponse] from its JSON object.
  ReputationFactionResponse(super.raw);

  /// The faction ID.
  int? get id => intOf('id');

  /// The localized faction name.
  String? get name => stringOf('name');

  /// The localized faction description.
  String? get description => stringOf('description');

  /// The reputation tiers used by this faction.
  KeyedRef? get reputationTiers => refOf('reputation_tiers');
}

/// Response of `GET /data/wow/reputation-tiers/index`.
class ReputationTiersIndexResponse extends ApiModel {
  /// Creates a [ReputationTiersIndexResponse] from its JSON object.
  ReputationTiersIndexResponse(super.raw);

  /// All reputation tier sets.
  List<KeyedRef> get reputationTiers => refsOf('reputation_tiers');
}

/// Response of `GET /data/wow/reputation-tiers/{reputationTiersId}`.
class ReputationTiersResponse extends ApiModel {
  /// Creates a [ReputationTiersResponse] from its JSON object.
  ReputationTiersResponse(super.raw);

  /// The reputation tiers set ID.
  int? get id => intOf('id');

  /// The tiers in this set.
  List<ReputationTier> get tiers =>
      listOf<ReputationTier>('tiers', ReputationTier.new);
}

/// A single reputation standing tier.
class ReputationTier extends ApiModel {
  /// Creates a [ReputationTier] from its JSON object.
  ReputationTier(super.raw);

  /// The tier ID.
  int? get id => intOf('id');

  /// The localized tier name, for example `Exalted`.
  String? get name => stringOf('name');

  /// Minimum reputation value for this tier.
  int? get minValue => intOf('min_value');

  /// Maximum reputation value for this tier.
  int? get maxValue => intOf('max_value');
}
