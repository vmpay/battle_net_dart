import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}`.
class CharacterProfileResponse extends ApiModel {
  /// Creates a [CharacterProfileResponse] from its JSON object.
  CharacterProfileResponse(super.raw);

  /// The character ID.
  int? get id => intOf('id');

  /// The character name.
  String? get name => stringOf('name');

  /// The character level.
  int? get level => intOf('level');

  /// Achievement points earned.
  int? get achievementPoints => intOf('achievement_points');

  /// Average equipped item level.
  int? get averageItemLevel => intOf('average_item_level');

  /// Maximum equipped item level.
  int? get equippedItemLevel => intOf('equipped_item_level');

  /// The character's gender (`MALE` or `FEMALE`).
  String? get gender => typeOf('gender');

  /// The character's faction (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');

  /// The character's race.
  KeyedRef? get race => refOf('race');

  /// The character's class.
  KeyedRef? get characterClass => refOf('character_class');

  /// The character's active specialization.
  KeyedRef? get activeSpec => refOf('active_spec');

  /// The character's realm.
  KeyedRef? get realm => refOf('realm');

  /// The character's guild, if any.
  KeyedRef? get guild => refOf('guild');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/status`.
class CharacterProfileStatusResponse extends ApiModel {
  /// Creates a [CharacterProfileStatusResponse] from its JSON object.
  CharacterProfileStatusResponse(super.raw);

  /// The character ID.
  int? get id => intOf('id');

  /// Whether the character profile is valid and active.
  bool? get isValid => boolOf('is_valid');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/achievements`.
class CharacterAchievementsResponse extends ApiModel {
  /// Creates a [CharacterAchievementsResponse] from its JSON object.
  CharacterAchievementsResponse(super.raw);

  /// Total number of completed achievements.
  int? get totalQuantity => intOf('total_quantity');

  /// Total achievement points.
  int? get totalPoints => intOf('total_points');

  /// Completed achievement entries, as raw JSON objects.
  List<Map<String, dynamic>> get achievements => listOf<Map<String, dynamic>>(
    'achievements',
    (Map<String, dynamic> a) => a,
  );
}

/// Response of
/// `GET /profile/wow/character/{realmSlug}/{characterName}/achievements/statistics`.
class CharacterAchievementStatisticsResponse extends ApiModel {
  /// Creates a [CharacterAchievementStatisticsResponse] from its JSON object.
  CharacterAchievementStatisticsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Statistic categories, as raw JSON objects.
  List<Map<String, dynamic>> get categories =>
      listOf<Map<String, dynamic>>('categories', (Map<String, dynamic> c) => c);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/appearance`.
class CharacterAppearanceResponse extends ApiModel {
  /// Creates a [CharacterAppearanceResponse] from its JSON object.
  CharacterAppearanceResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Equipped/transmogged items, as raw JSON objects.
  List<Map<String, dynamic>> get items =>
      listOf<Map<String, dynamic>>('items', (Map<String, dynamic> i) => i);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections`.
class CharacterCollectionsIndexResponse extends ApiModel {
  /// Creates a [CharacterCollectionsIndexResponse] from its JSON object.
  CharacterCollectionsIndexResponse(super.raw);

  /// URL of the character's pets collection.
  String? get petsHref => hrefOf('pets');

  /// URL of the character's mounts collection.
  String? get mountsHref => hrefOf('mounts');

  /// URL of the character's heirlooms collection.
  String? get heirloomsHref => hrefOf('heirlooms');

  /// URL of the character's toys collection.
  String? get toysHref => hrefOf('toys');

  /// URL of the character's transmogs collection.
  String? get transmogsHref => hrefOf('transmogs');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections/mounts`.
class CharacterMountsCollectionResponse extends ApiModel {
  /// Creates a [CharacterMountsCollectionResponse] from its JSON object.
  CharacterMountsCollectionResponse(super.raw);

  /// Collected mounts, as raw JSON objects.
  List<Map<String, dynamic>> get mounts =>
      listOf<Map<String, dynamic>>('mounts', (Map<String, dynamic> m) => m);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections/pets`.
class CharacterPetsCollectionResponse extends ApiModel {
  /// Creates a [CharacterPetsCollectionResponse] from its JSON object.
  CharacterPetsCollectionResponse(super.raw);

  /// Collected pets, as raw JSON objects.
  List<Map<String, dynamic>> get pets =>
      listOf<Map<String, dynamic>>('pets', (Map<String, dynamic> p) => p);

  /// Unlocked battle pet team slots.
  int? get unlockedBattlePetSlots => intOf('unlocked_battle_pet_slots');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections/toys`.
class CharacterToysCollectionResponse extends ApiModel {
  /// Creates a [CharacterToysCollectionResponse] from its JSON object.
  CharacterToysCollectionResponse(super.raw);

  /// Collected toys, as raw JSON objects.
  List<Map<String, dynamic>> get toys =>
      listOf<Map<String, dynamic>>('toys', (Map<String, dynamic> t) => t);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections/heirlooms`.
class CharacterHeirloomsCollectionResponse extends ApiModel {
  /// Creates a [CharacterHeirloomsCollectionResponse] from its JSON object.
  CharacterHeirloomsCollectionResponse(super.raw);

  /// Collected heirlooms, as raw JSON objects.
  List<Map<String, dynamic>> get heirlooms =>
      listOf<Map<String, dynamic>>('heirlooms', (Map<String, dynamic> h) => h);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/collections/transmogs`.
class CharacterTransmogsCollectionResponse extends ApiModel {
  /// Creates a [CharacterTransmogsCollectionResponse] from its JSON object.
  CharacterTransmogsCollectionResponse(super.raw);

  /// Collected appearance sets.
  List<KeyedRef> get appearanceSets => refsOf('appearance_sets');

  /// Collected transmog slots, as raw JSON objects.
  List<Map<String, dynamic>> get slots =>
      listOf<Map<String, dynamic>>('slots', (Map<String, dynamic> s) => s);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/encounters`.
class CharacterEncountersSummaryResponse extends ApiModel {
  /// Creates a [CharacterEncountersSummaryResponse] from its JSON object.
  CharacterEncountersSummaryResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// URL of dungeon encounters.
  String? get dungeonsHref => hrefOf('dungeons');

  /// URL of raid encounters.
  String? get raidsHref => hrefOf('raids');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/encounters/dungeons`.
class CharacterDungeonsResponse extends ApiModel {
  /// Creates a [CharacterDungeonsResponse] from its JSON object.
  CharacterDungeonsResponse(super.raw);

  /// Expansions with dungeon completion progress, as raw JSON objects.
  List<Map<String, dynamic>> get expansions =>
      listOf<Map<String, dynamic>>('expansions', (Map<String, dynamic> e) => e);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/encounters/raids`.
class CharacterRaidsResponse extends ApiModel {
  /// Creates a [CharacterRaidsResponse] from its JSON object.
  CharacterRaidsResponse(super.raw);

  /// Expansions with raid completion progress, as raw JSON objects.
  List<Map<String, dynamic>> get expansions =>
      listOf<Map<String, dynamic>>('expansions', (Map<String, dynamic> e) => e);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/equipment`.
class CharacterEquipmentResponse extends ApiModel {
  /// Creates a [CharacterEquipmentResponse] from its JSON object.
  CharacterEquipmentResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Equipped items, as raw JSON objects.
  List<Map<String, dynamic>> get equippedItems => listOf<Map<String, dynamic>>(
    'equipped_items',
    (Map<String, dynamic> i) => i,
  );
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/hunter-pets`.
class CharacterHunterPetsResponse extends ApiModel {
  /// Creates a [CharacterHunterPetsResponse] from its JSON object.
  CharacterHunterPetsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Tamed hunter pets, as raw JSON objects.
  List<Map<String, dynamic>> get hunterPets => listOf<Map<String, dynamic>>(
    'hunter_pets',
    (Map<String, dynamic> p) => p,
  );
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/character-media`.
class CharacterMediaResponse extends ApiModel {
  /// Creates a [CharacterMediaResponse] from its JSON object.
  CharacterMediaResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Character render assets (avatar, inset, main-raw).
  List<MediaAsset> get assets => listOf<MediaAsset>('assets', MediaAsset.new);
}

/// Response of
/// `GET /profile/wow/character/{realmSlug}/{characterName}/mythic-keystone-profile`.
class CharacterMythicKeystoneProfileResponse extends ApiModel {
  /// Creates a [CharacterMythicKeystoneProfileResponse] from its JSON object.
  CharacterMythicKeystoneProfileResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Current period info, as a raw JSON object.
  Map<String, dynamic>? get currentPeriod => mapOf('current_period');

  /// Mythic+ seasons participated in.
  List<KeyedRef> get seasons => refsOf('seasons');
}

/// Response of
/// `GET /profile/wow/character/{realmSlug}/{characterName}/mythic-keystone-profile/season/{seasonId}`.
class CharacterMythicKeystoneSeasonResponse extends ApiModel {
  /// Creates a [CharacterMythicKeystoneSeasonResponse] from its JSON object.
  CharacterMythicKeystoneSeasonResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// The Mythic+ season reference.
  KeyedRef? get season => refOf('season');

  /// Best runs of the season, as raw JSON objects.
  List<Map<String, dynamic>> get bestRuns =>
      listOf<Map<String, dynamic>>('best_runs', (Map<String, dynamic> r) => r);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/professions`.
class CharacterProfessionsResponse extends ApiModel {
  /// Creates a [CharacterProfessionsResponse] from its JSON object.
  CharacterProfessionsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Primary professions, as raw JSON objects.
  List<Map<String, dynamic>> get primaries =>
      listOf<Map<String, dynamic>>('primaries', (Map<String, dynamic> p) => p);

  /// Secondary professions, as raw JSON objects.
  List<Map<String, dynamic>> get secondaries => listOf<Map<String, dynamic>>(
    'secondaries',
    (Map<String, dynamic> s) => s,
  );
}

/// Response of
/// `GET /profile/wow/character/{realmSlug}/{characterName}/pvp-bracket/{pvpBracket}`.
class CharacterPvpBracketResponse extends ApiModel {
  /// Creates a [CharacterPvpBracketResponse] from its JSON object.
  CharacterPvpBracketResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// The PvP bracket type, for example `ARENA_2v2`.
  String? get bracket => typeOf('bracket');

  /// Current rating in this bracket.
  int? get rating => intOf('rating');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/pvp-summary`.
class CharacterPvpSummaryResponse extends ApiModel {
  /// Creates a [CharacterPvpSummaryResponse] from its JSON object.
  CharacterPvpSummaryResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Honor level.
  int? get honorLevel => intOf('honor_level');

  /// Total honorable kills.
  int? get honorableKills => intOf('honorable_kills');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/quests`.
class CharacterQuestsResponse extends ApiModel {
  /// Creates a [CharacterQuestsResponse] from its JSON object.
  CharacterQuestsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Quests currently in progress.
  List<KeyedRef> get inProgress => refsOf('in_progress');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/quests/completed`.
class CharacterCompletedQuestsResponse extends ApiModel {
  /// Creates a [CharacterCompletedQuestsResponse] from its JSON object.
  CharacterCompletedQuestsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Completed quests.
  List<KeyedRef> get quests => refsOf('quests');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/reputations`.
class CharacterReputationsResponse extends ApiModel {
  /// Creates a [CharacterReputationsResponse] from its JSON object.
  CharacterReputationsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Character reputations, as raw JSON objects.
  List<Map<String, dynamic>> get reputations => listOf<Map<String, dynamic>>(
    'reputations',
    (Map<String, dynamic> r) => r,
  );
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/soulbinds`.
class CharacterSoulbindsResponse extends ApiModel {
  /// Creates a [CharacterSoulbindsResponse] from its JSON object.
  CharacterSoulbindsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Chosen covenant.
  KeyedRef? get chosenCovenant => refOf('chosen_covenant');

  /// Covenant renown level.
  int? get renownLevel => intOf('renown_level');

  /// Soulbinds, as raw JSON objects.
  List<Map<String, dynamic>> get soulbinds =>
      listOf<Map<String, dynamic>>('soulbinds', (Map<String, dynamic> s) => s);
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/specializations`.
class CharacterSpecializationsResponse extends ApiModel {
  /// Creates a [CharacterSpecializationsResponse] from its JSON object.
  CharacterSpecializationsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Active specialization.
  KeyedRef? get activeSpecialization => refOf('active_specialization');

  /// Specializations and talent loadouts, as raw JSON objects.
  List<Map<String, dynamic>> get specializations =>
      listOf<Map<String, dynamic>>(
        'specializations',
        (Map<String, dynamic> s) => s,
      );
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/statistics`.
class CharacterStatisticsResponse extends ApiModel {
  /// Creates a [CharacterStatisticsResponse] from its JSON object.
  CharacterStatisticsResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Character health.
  int? get health => intOf('health');

  /// Character primary resource amount.
  int? get power => intOf('power');

  /// Character primary resource type.
  KeyedRef? get powerType => refOf('power_type');
}

/// Response of `GET /profile/wow/character/{realmSlug}/{characterName}/titles`.
class CharacterTitlesResponse extends ApiModel {
  /// Creates a [CharacterTitlesResponse] from its JSON object.
  CharacterTitlesResponse(super.raw);

  /// The character reference.
  KeyedRef? get character => refOf('character');

  /// Currently active title, if any.
  KeyedRef? get activeTitle => refOf('active_title');

  /// Unlocked titles.
  List<KeyedRef> get titles => refsOf('titles');
}
