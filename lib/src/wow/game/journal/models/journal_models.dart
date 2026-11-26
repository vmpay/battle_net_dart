import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/journal-expansion/index`.
class JournalExpansionsIndexResponse extends ApiModel {
  /// Creates a [JournalExpansionsIndexResponse] from its JSON object.
  JournalExpansionsIndexResponse(super.raw);

  /// All journal expansions (tiers).
  List<KeyedRef> get tiers => refsOf('tiers');
}

/// Response of `GET /data/wow/journal-expansion/{journalExpansionId}`.
class JournalExpansionResponse extends ApiModel {
  /// Creates a [JournalExpansionResponse] from its JSON object.
  JournalExpansionResponse(super.raw);

  /// The expansion ID.
  int? get id => intOf('id');

  /// The localized expansion name.
  String? get name => stringOf('name');

  /// Dungeons in this expansion.
  List<KeyedRef> get dungeons => refsOf('dungeons');

  /// Raids in this expansion.
  List<KeyedRef> get raids => refsOf('raids');
}

/// Response of `GET /data/wow/journal-encounter/index`.
class JournalEncountersIndexResponse extends ApiModel {
  /// Creates a [JournalEncountersIndexResponse] from its JSON object.
  JournalEncountersIndexResponse(super.raw);

  /// All journal encounters.
  List<KeyedRef> get encounters => refsOf('encounters');
}

/// Response of `GET /data/wow/journal-encounter/{journalEncounterId}`.
class JournalEncounterResponse extends ApiModel {
  /// Creates a [JournalEncounterResponse] from its JSON object.
  JournalEncounterResponse(super.raw);

  /// The encounter ID.
  int? get id => intOf('id');

  /// The localized encounter name.
  String? get name => stringOf('name');

  /// The localized encounter description.
  String? get description => stringOf('description');

  /// The instance this encounter belongs to.
  KeyedRef? get instance => refOf('instance');

  /// The encounter category type, for example `BOSS`.
  String? get category => typeOf('category');
}

/// Response of `GET /data/wow/journal-instance/index`.
class JournalInstancesIndexResponse extends ApiModel {
  /// Creates a [JournalInstancesIndexResponse] from its JSON object.
  JournalInstancesIndexResponse(super.raw);

  /// All journal instances.
  List<KeyedRef> get instances => refsOf('instances');
}

/// Response of `GET /data/wow/journal-instance/{journalInstanceId}`.
class JournalInstanceResponse extends ApiModel {
  /// Creates a [JournalInstanceResponse] from its JSON object.
  JournalInstanceResponse(super.raw);

  /// The instance ID.
  int? get id => intOf('id');

  /// The localized instance name.
  String? get name => stringOf('name');

  /// The localized instance description.
  String? get description => stringOf('description');

  /// The minimum character level required.
  int? get minimumLevel => intOf('minimum_level');

  /// The expansion this instance belongs to.
  KeyedRef? get expansion => refOf('expansion');

  /// Encounters in this instance.
  List<KeyedRef> get encounters => refsOf('encounters');

  /// The instance category type, for example `DUNGEON` or `RAID`.
  String? get category => typeOf('category');
}
