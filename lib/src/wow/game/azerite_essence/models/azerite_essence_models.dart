import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/azerite-essence/index`.
class AzeriteEssencesIndexResponse extends ApiModel {
  /// Creates an [AzeriteEssencesIndexResponse] from its JSON object.
  AzeriteEssencesIndexResponse(super.raw);

  /// All Azerite essences.
  List<KeyedRef> get azeriteEssences => refsOf('azerite_essences');
}

/// Response of `GET /data/wow/azerite-essence/{azeriteEssenceId}`.
class AzeriteEssenceResponse extends ApiModel {
  /// Creates an [AzeriteEssenceResponse] from its JSON object.
  AzeriteEssenceResponse(super.raw);

  /// The Azerite essence ID.
  int? get id => intOf('id');

  /// The localized Azerite essence name.
  String? get name => stringOf('name');

  /// Allowed specializations for this essence.
  List<KeyedRef> get allowedSpecializations =>
      refsOf('allowed_specializations');

  /// The ID to use with `getAzeriteEssenceMedia`.
  int? get mediaId => idOf('media');
}
