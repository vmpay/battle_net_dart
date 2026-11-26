import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/spell/{spellId}`.
class SpellResponse extends ApiModel {
  /// Creates a [SpellResponse] from its JSON object.
  SpellResponse(super.raw);

  /// The spell ID.
  int? get id => intOf('id');

  /// The localized spell name.
  String? get name => stringOf('name');

  /// The localized spell description.
  String? get description => stringOf('description');

  /// The ID to use with `getSpellMedia`.
  int? get mediaId => idOf('media');
}
