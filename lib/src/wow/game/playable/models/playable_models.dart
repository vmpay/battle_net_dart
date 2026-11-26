import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/playable-class/index`.
class PlayableClassesIndexResponse extends ApiModel {
  /// Creates a [PlayableClassesIndexResponse] from its JSON object.
  PlayableClassesIndexResponse(super.raw);

  /// All playable classes.
  List<KeyedRef> get classes => refsOf('classes');
}

/// Response of `GET /data/wow/playable-class/{classId}`.
class PlayableClassResponse extends ApiModel {
  /// Creates a [PlayableClassResponse] from its JSON object.
  PlayableClassResponse(super.raw);

  /// The class ID.
  int? get id => intOf('id');

  /// The localized class name.
  String? get name => stringOf('name');

  /// The power type used by this class.
  KeyedRef? get powerType => refOf('power_type');

  /// The specializations of this class.
  List<KeyedRef> get specializations => refsOf('specializations');

  /// The playable races that can be this class.
  List<KeyedRef> get playableRaces => refsOf('playable_races');

  /// The ID to use with `getPlayableClassMedia`.
  int? get mediaId => idOf('media');
}

/// Response of `GET /data/wow/playable-class/{classId}/pvp-talent-slots`.
class PvpTalentSlotsResponse extends ApiModel {
  /// Creates a [PvpTalentSlotsResponse] from its JSON object.
  PvpTalentSlotsResponse(super.raw);

  /// The PvP talent slots.
  List<PvpTalentSlot> get talentSlots =>
      listOf<PvpTalentSlot>('talent_slots', PvpTalentSlot.new);
}

/// A PvP talent slot entry.
class PvpTalentSlot extends ApiModel {
  /// Creates a [PvpTalentSlot] from its JSON object.
  PvpTalentSlot(super.raw);

  /// The slot number.
  int? get slotNumber => intOf('slot_number');

  /// The character level at which this slot unlocks.
  int? get unlockPlayerLevel => intOf('unlock_player_level');
}

/// Response of `GET /data/wow/playable-race/index`.
class PlayableRacesIndexResponse extends ApiModel {
  /// Creates a [PlayableRacesIndexResponse] from its JSON object.
  PlayableRacesIndexResponse(super.raw);

  /// All playable races.
  List<KeyedRef> get races => refsOf('races');
}

/// Response of `GET /data/wow/playable-race/{raceId}`.
class PlayableRaceResponse extends ApiModel {
  /// Creates a [PlayableRaceResponse] from its JSON object.
  PlayableRaceResponse(super.raw);

  /// The race ID.
  int? get id => intOf('id');

  /// The localized race name.
  String? get name => stringOf('name');

  /// The race faction (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');

  /// Whether the race is selectable during character creation.
  bool? get isSelectable => boolOf('is_selectable');

  /// Whether the race is an allied race.
  bool? get isAlliedRace => boolOf('is_allied_race');

  /// The classes available to this race.
  List<KeyedRef> get playableClasses => refsOf('playable_classes');
}

/// Response of `GET /data/wow/playable-specialization/index`.
class PlayableSpecializationsIndexResponse extends ApiModel {
  /// Creates a [PlayableSpecializationsIndexResponse] from its JSON object.
  PlayableSpecializationsIndexResponse(super.raw);

  /// Character specializations.
  List<KeyedRef> get characterSpecializations =>
      refsOf('character_specializations');

  /// Hunter pet specializations.
  List<KeyedRef> get petSpecializations => refsOf('pet_specializations');
}

/// Response of `GET /data/wow/playable-specialization/{specId}`.
class PlayableSpecializationResponse extends ApiModel {
  /// Creates a [PlayableSpecializationResponse] from its JSON object.
  PlayableSpecializationResponse(super.raw);

  /// The specialization ID.
  int? get id => intOf('id');

  /// The localized specialization name.
  String? get name => stringOf('name');

  /// The playable class this specialization belongs to.
  KeyedRef? get playableClass => refOf('playable_class');

  /// The specialization role, for example `DAMAGE`, `HEALER`, or `TANK`.
  String? get role => typeOf('role');

  /// The primary power type used by this specialization.
  KeyedRef? get powerType => refOf('power_type');

  /// The spec talent tree reference.
  KeyedRef? get specTalentTree => refOf('spec_talent_tree');

  /// The ID to use with `getPlayableSpecializationMedia`.
  int? get mediaId => idOf('media');
}
