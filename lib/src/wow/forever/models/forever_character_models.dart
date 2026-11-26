import 'dart:convert';

import 'package:meta/meta.dart';

// ---------------------------------------------------------------------------
// ForeverCharacterProfileResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterProfile`.
@immutable
class ForeverCharacterProfileResponse {
  /// The character's unique slug (`name-surname`).
  final String slug;

  /// The character's display name.
  final String name;

  /// The character's surname.
  final String? surname;

  /// The character's level.
  final int level;

  /// The character's achievement points.
  final int? achievementPoints;

  /// The character's gender ID (`0` = male, `1` = female).
  final int? gender;

  /// The character's race ID.
  final int? raceId;

  /// The character's class ID.
  final int? classId;

  const ForeverCharacterProfileResponse({
    required this.slug,
    required this.name,
    this.surname,
    required this.level,
    this.achievementPoints,
    this.gender,
    this.raceId,
    this.classId,
  });

  factory ForeverCharacterProfileResponse.fromRawJson(String str) =>
      ForeverCharacterProfileResponse.fromJson(json.decode(str));

  factory ForeverCharacterProfileResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterProfileResponse(
        slug: j['slug'] as String? ?? '',
        name: j['name'] as String? ?? '',
        surname: j['surname'] as String?,
        level: (j['level'] as num?)?.toInt() ?? 0,
        achievementPoints: (j['achievement_points'] as num?)?.toInt(),
        gender: (j['gender']?['type'] != null)
            ? (j['gender']['type'] == 'MALE' ? 0 : 1)
            : null,
        raceId: (j['race']?['id'] as num?)?.toInt(),
        classId: (j['character_class']?['id'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverCharacterProfileResponse{slug: $slug, name: $name, level: $level}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterProfileResponse &&
          runtimeType == other.runtimeType &&
          slug == other.slug &&
          level == other.level;

  @override
  int get hashCode => Object.hash(slug, level);
}

// ---------------------------------------------------------------------------
// ForeverCharacterEquipmentResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterEquipment`.
@immutable
class ForeverCharacterEquipmentResponse {
  /// The character slug.
  final String? characterSlug;

  /// The list of equipped items. Nullable — may be absent during EU propagation.
  final List<ForeverEquippedItem>? equippedItems;

  const ForeverCharacterEquipmentResponse({
    this.characterSlug,
    this.equippedItems,
  });

  factory ForeverCharacterEquipmentResponse.fromRawJson(String str) =>
      ForeverCharacterEquipmentResponse.fromJson(json.decode(str));

  factory ForeverCharacterEquipmentResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterEquipmentResponse(
        characterSlug: j['character']?['slug'] as String?,
        equippedItems: (j['equipped_items'] as List<dynamic>?)
            ?.map(
              (dynamic e) =>
                  ForeverEquippedItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverCharacterEquipmentResponse{items: ${equippedItems?.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterEquipmentResponse &&
          runtimeType == other.runtimeType &&
          characterSlug == other.characterSlug;

  @override
  int get hashCode => characterSlug.hashCode;
}

/// A single item equipped by a Forever character.
@immutable
class ForeverEquippedItem {
  final int itemId;
  final String? slot;
  final String? name;
  final int? itemLevel;

  const ForeverEquippedItem({
    required this.itemId,
    this.slot,
    this.name,
    this.itemLevel,
  });

  factory ForeverEquippedItem.fromJson(Map<String, dynamic> j) =>
      ForeverEquippedItem(
        itemId: (j['item']?['id'] as num?)?.toInt() ?? 0,
        slot: j['slot']?['type'] as String?,
        name: j['name'] as String?,
        itemLevel: (j['level']?['value'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverEquippedItem{itemId: $itemId, slot: $slot, itemLevel: $itemLevel}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverEquippedItem &&
          runtimeType == other.runtimeType &&
          itemId == other.itemId &&
          slot == other.slot;

  @override
  int get hashCode => Object.hash(itemId, slot);
}

// ---------------------------------------------------------------------------
// ForeverCharacterMediaResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterMedia`.
@immutable
class ForeverCharacterMediaResponse {
  /// The character slug.
  final String? characterSlug;

  /// Asset URLs. Nullable — may be absent during EU propagation.
  final List<ForeverMediaAsset>? assets;

  const ForeverCharacterMediaResponse({this.characterSlug, this.assets});

  factory ForeverCharacterMediaResponse.fromRawJson(String str) =>
      ForeverCharacterMediaResponse.fromJson(json.decode(str));

  factory ForeverCharacterMediaResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterMediaResponse(
        characterSlug: j['character']?['slug'] as String?,
        assets: (j['assets'] as List<dynamic>?)
            ?.map(
              (dynamic e) =>
                  ForeverMediaAsset.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverCharacterMediaResponse{assets: ${assets?.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterMediaResponse &&
          runtimeType == other.runtimeType &&
          characterSlug == other.characterSlug;

  @override
  int get hashCode => characterSlug.hashCode;
}

/// A single media asset (e.g. avatar, inset, main-raw render URLs).
@immutable
class ForeverMediaAsset {
  final String key;
  final String value;
  final int? fileDataId;

  const ForeverMediaAsset({
    required this.key,
    required this.value,
    this.fileDataId,
  });

  factory ForeverMediaAsset.fromJson(Map<String, dynamic> j) =>
      ForeverMediaAsset(
        key: j['key'] as String? ?? '',
        value: j['value'] as String? ?? '',
        fileDataId: (j['file_data_id'] as num?)?.toInt(),
      );

  @override
  String toString() => 'ForeverMediaAsset{key: $key, value: $value}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverMediaAsset &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;

  @override
  int get hashCode => Object.hash(key, value);
}

// ---------------------------------------------------------------------------
// ForeverCharacterAchievementsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterAchievements`.
@immutable
class ForeverCharacterAchievementsResponse {
  final int? totalPoints;
  final List<ForeverAchievementEntry> achievements;

  const ForeverCharacterAchievementsResponse({
    this.totalPoints,
    required this.achievements,
  });

  factory ForeverCharacterAchievementsResponse.fromRawJson(String str) =>
      ForeverCharacterAchievementsResponse.fromJson(json.decode(str));

  factory ForeverCharacterAchievementsResponse.fromJson(
    Map<String, dynamic> j,
  ) => ForeverCharacterAchievementsResponse(
    totalPoints: (j['total_points'] as num?)?.toInt(),
    achievements: (j['achievements'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic e) =>
              ForeverAchievementEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );

  @override
  String toString() =>
      'ForeverCharacterAchievementsResponse{totalPoints: $totalPoints, count: ${achievements.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterAchievementsResponse &&
          runtimeType == other.runtimeType &&
          totalPoints == other.totalPoints;

  @override
  int get hashCode => totalPoints.hashCode;
}

/// A single achievement entry.
@immutable
class ForeverAchievementEntry {
  final int id;
  final int? timestamp;

  const ForeverAchievementEntry({required this.id, this.timestamp});

  factory ForeverAchievementEntry.fromJson(Map<String, dynamic> j) =>
      ForeverAchievementEntry(
        id: (j['id'] as num?)?.toInt() ?? 0,
        timestamp: (j['completed_timestamp'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverAchievementEntry{id: $id, timestamp: $timestamp}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverAchievementEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterStatisticsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterStatistics`.
@immutable
class ForeverCharacterStatisticsResponse {
  final int? totalQuantity;
  final List<ForeverStatistic> statistics;

  const ForeverCharacterStatisticsResponse({
    this.totalQuantity,
    required this.statistics,
  });

  factory ForeverCharacterStatisticsResponse.fromRawJson(String str) =>
      ForeverCharacterStatisticsResponse.fromJson(json.decode(str));

  factory ForeverCharacterStatisticsResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterStatisticsResponse(
        totalQuantity: (j['total_quantity'] as num?)?.toInt(),
        statistics: (j['statistics'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverStatistic.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverCharacterStatisticsResponse{count: ${statistics.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterStatisticsResponse &&
          runtimeType == other.runtimeType &&
          totalQuantity == other.totalQuantity;

  @override
  int get hashCode => totalQuantity.hashCode;
}

/// A single statistic entry.
@immutable
class ForeverStatistic {
  final int id;
  final String? name;
  final String? quantity;
  final int? lastUpdatedTimestamp;

  const ForeverStatistic({
    required this.id,
    this.name,
    this.quantity,
    this.lastUpdatedTimestamp,
  });

  factory ForeverStatistic.fromJson(Map<String, dynamic> j) => ForeverStatistic(
    id: (j['id'] as num?)?.toInt() ?? 0,
    name: j['name'] as String?,
    quantity: j['quantity']?.toString(),
    lastUpdatedTimestamp: (j['last_updated_timestamp'] as num?)?.toInt(),
  );

  @override
  String toString() => 'ForeverStatistic{id: $id, name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverStatistic &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterEncountersResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterDungeonEncounters`.
@immutable
class ForeverCharacterEncountersResponse {
  final List<ForeverEncounterMode> expansions;

  const ForeverCharacterEncountersResponse({required this.expansions});

  factory ForeverCharacterEncountersResponse.fromRawJson(String str) =>
      ForeverCharacterEncountersResponse.fromJson(json.decode(str));

  factory ForeverCharacterEncountersResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterEncountersResponse(
        expansions: (j['expansions'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverEncounterMode.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverCharacterEncountersResponse{expansions: ${expansions.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterEncountersResponse &&
          runtimeType == other.runtimeType &&
          expansions.length == other.expansions.length;

  @override
  int get hashCode => expansions.length.hashCode;
}

/// An expansion's encounter modes.
@immutable
class ForeverEncounterMode {
  final int? expansionId;
  final String? expansionName;
  final List<ForeverDungeonEncounter> instances;

  const ForeverEncounterMode({
    this.expansionId,
    this.expansionName,
    required this.instances,
  });

  factory ForeverEncounterMode.fromJson(Map<String, dynamic> j) =>
      ForeverEncounterMode(
        expansionId: (j['expansion']?['id'] as num?)?.toInt(),
        expansionName: j['expansion']?['name'] as String?,
        instances: (j['instances'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverDungeonEncounter.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverEncounterMode{expansion: $expansionName, instances: ${instances.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverEncounterMode &&
          runtimeType == other.runtimeType &&
          expansionId == other.expansionId;

  @override
  int get hashCode => expansionId.hashCode;
}

/// A dungeon with encounter completion info.
@immutable
class ForeverDungeonEncounter {
  final int? instanceId;
  final String? instanceName;
  final List<ForeverEncounterEntry> encounters;

  const ForeverDungeonEncounter({
    this.instanceId,
    this.instanceName,
    required this.encounters,
  });

  factory ForeverDungeonEncounter.fromJson(Map<String, dynamic> j) =>
      ForeverDungeonEncounter(
        instanceId: (j['instance']?['id'] as num?)?.toInt(),
        instanceName: j['instance']?['name'] as String?,
        encounters: (j['modes'] as List<dynamic>? ?? <dynamic>[]).expand((
          dynamic m,
        ) {
          final List<dynamic> progressList =
              m['progress']?['encounters'] as List<dynamic>? ?? <dynamic>[];
          return progressList.map(
            (dynamic e) =>
                ForeverEncounterEntry.fromJson(e as Map<String, dynamic>),
          );
        }).toList(),
      );

  @override
  String toString() =>
      'ForeverDungeonEncounter{instance: $instanceName, encounters: ${encounters.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverDungeonEncounter &&
          runtimeType == other.runtimeType &&
          instanceId == other.instanceId;

  @override
  int get hashCode => instanceId.hashCode;
}

/// A single encounter completion entry.
@immutable
class ForeverEncounterEntry {
  final int? encounterId;
  final String? encounterName;
  final int? completedCount;
  final int? lastKillTimestamp;

  const ForeverEncounterEntry({
    this.encounterId,
    this.encounterName,
    this.completedCount,
    this.lastKillTimestamp,
  });

  factory ForeverEncounterEntry.fromJson(Map<String, dynamic> j) =>
      ForeverEncounterEntry(
        encounterId: (j['encounter']?['id'] as num?)?.toInt(),
        encounterName: j['encounter']?['name'] as String?,
        completedCount: (j['completed_count'] as num?)?.toInt(),
        lastKillTimestamp: (j['last_kill_timestamp'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverEncounterEntry{encounter: $encounterName, completed: $completedCount}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverEncounterEntry &&
          runtimeType == other.runtimeType &&
          encounterId == other.encounterId;

  @override
  int get hashCode => encounterId.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterPvpSummaryResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterPvpSummary`.
@immutable
class ForeverCharacterPvpSummaryResponse {
  final int? honorLevel;
  final int? honorableKills;

  const ForeverCharacterPvpSummaryResponse({
    this.honorLevel,
    this.honorableKills,
  });

  factory ForeverCharacterPvpSummaryResponse.fromRawJson(String str) =>
      ForeverCharacterPvpSummaryResponse.fromJson(json.decode(str));

  factory ForeverCharacterPvpSummaryResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterPvpSummaryResponse(
        honorLevel: (j['honor_level'] as num?)?.toInt(),
        honorableKills: (j['honorable_kills'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverCharacterPvpSummaryResponse{honorLevel: $honorLevel, kills: $honorableKills}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterPvpSummaryResponse &&
          runtimeType == other.runtimeType &&
          honorLevel == other.honorLevel &&
          honorableKills == other.honorableKills;

  @override
  int get hashCode => Object.hash(honorLevel, honorableKills);
}

// ---------------------------------------------------------------------------
// ForeverCharacterQuestsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterCompletedQuests`.
@immutable
class ForeverCharacterQuestsResponse {
  final List<ForeverQuestEntry> quests;

  const ForeverCharacterQuestsResponse({required this.quests});

  factory ForeverCharacterQuestsResponse.fromRawJson(String str) =>
      ForeverCharacterQuestsResponse.fromJson(json.decode(str));

  factory ForeverCharacterQuestsResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterQuestsResponse(
        quests: (j['quests'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverQuestEntry.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverCharacterQuestsResponse{quests: ${quests.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterQuestsResponse &&
          runtimeType == other.runtimeType &&
          quests.length == other.quests.length;

  @override
  int get hashCode => quests.length.hashCode;
}

/// A single quest entry.
@immutable
class ForeverQuestEntry {
  final int id;
  final String? title;

  const ForeverQuestEntry({required this.id, this.title});

  factory ForeverQuestEntry.fromJson(Map<String, dynamic> j) =>
      ForeverQuestEntry(
        id: (j['id'] as num?)?.toInt() ?? 0,
        title: j['title'] as String?,
      );

  @override
  String toString() => 'ForeverQuestEntry{id: $id, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverQuestEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterReputationsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterReputations`.
@immutable
class ForeverCharacterReputationsResponse {
  final List<ForeverReputationEntry> reputations;

  const ForeverCharacterReputationsResponse({required this.reputations});

  factory ForeverCharacterReputationsResponse.fromRawJson(String str) =>
      ForeverCharacterReputationsResponse.fromJson(json.decode(str));

  factory ForeverCharacterReputationsResponse.fromJson(
    Map<String, dynamic> j,
  ) => ForeverCharacterReputationsResponse(
    reputations: (j['reputations'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic e) =>
              ForeverReputationEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );

  @override
  String toString() =>
      'ForeverCharacterReputationsResponse{count: ${reputations.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterReputationsResponse &&
          runtimeType == other.runtimeType &&
          reputations.length == other.reputations.length;

  @override
  int get hashCode => reputations.length.hashCode;
}

/// A single reputation entry.
@immutable
class ForeverReputationEntry {
  final int factionId;
  final String? factionName;
  final int standing;

  const ForeverReputationEntry({
    required this.factionId,
    this.factionName,
    required this.standing,
  });

  factory ForeverReputationEntry.fromJson(Map<String, dynamic> j) =>
      ForeverReputationEntry(
        factionId: (j['faction']?['id'] as num?)?.toInt() ?? 0,
        factionName: j['faction']?['name'] as String?,
        standing: (j['standing']?['value'] as num?)?.toInt() ?? 0,
      );

  @override
  String toString() =>
      'ForeverReputationEntry{faction: $factionName, standing: $standing}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverReputationEntry &&
          runtimeType == other.runtimeType &&
          factionId == other.factionId;

  @override
  int get hashCode => factionId.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterProfessionsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterProfessions`.
@immutable
class ForeverCharacterProfessionsResponse {
  final List<ForeverProfessionEntry> primaries;
  final List<ForeverProfessionEntry> secondaries;

  const ForeverCharacterProfessionsResponse({
    required this.primaries,
    required this.secondaries,
  });

  factory ForeverCharacterProfessionsResponse.fromRawJson(String str) =>
      ForeverCharacterProfessionsResponse.fromJson(json.decode(str));

  factory ForeverCharacterProfessionsResponse.fromJson(
    Map<String, dynamic> j,
  ) => ForeverCharacterProfessionsResponse(
    primaries: (j['primaries'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic e) =>
              ForeverProfessionEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
    secondaries: (j['secondaries'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic e) =>
              ForeverProfessionEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );

  @override
  String toString() =>
      'ForeverCharacterProfessionsResponse{primaries: ${primaries.length}, secondaries: ${secondaries.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterProfessionsResponse &&
          runtimeType == other.runtimeType &&
          primaries.length == other.primaries.length &&
          secondaries.length == other.secondaries.length;

  @override
  int get hashCode => Object.hash(primaries.length, secondaries.length);
}

/// A single profession entry.
@immutable
class ForeverProfessionEntry {
  final int professionId;
  final String? professionName;
  final int skillPoints;
  final int maxSkillPoints;

  const ForeverProfessionEntry({
    required this.professionId,
    this.professionName,
    required this.skillPoints,
    required this.maxSkillPoints,
  });

  factory ForeverProfessionEntry.fromJson(Map<String, dynamic> j) {
    final Map<String, dynamic>? profJson =
        j['profession'] as Map<String, dynamic>?;
    final Map<String, dynamic>? tierJson =
        (j['tiers'] as List<dynamic>?)?.lastOrNull as Map<String, dynamic>?;
    return ForeverProfessionEntry(
      professionId: (profJson?['id'] as num?)?.toInt() ?? 0,
      professionName: profJson?['name'] as String?,
      skillPoints: (tierJson?['skill_points'] as num?)?.toInt() ?? 0,
      maxSkillPoints: (tierJson?['max_skill_points'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  String toString() =>
      'ForeverProfessionEntry{profession: $professionName, skill: $skillPoints/$maxSkillPoints}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverProfessionEntry &&
          runtimeType == other.runtimeType &&
          professionId == other.professionId;

  @override
  int get hashCode => professionId.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterSpecializationsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterSpecializations`.
@immutable
class ForeverCharacterSpecializationsResponse {
  final int? activeSpecId;
  final String? activeSpecName;
  final List<ForeverSpecEntry> specializations;

  const ForeverCharacterSpecializationsResponse({
    this.activeSpecId,
    this.activeSpecName,
    required this.specializations,
  });

  factory ForeverCharacterSpecializationsResponse.fromRawJson(String str) =>
      ForeverCharacterSpecializationsResponse.fromJson(json.decode(str));

  factory ForeverCharacterSpecializationsResponse.fromJson(
    Map<String, dynamic> j,
  ) => ForeverCharacterSpecializationsResponse(
    activeSpecId: (j['active_specialization']?['id'] as num?)?.toInt(),
    activeSpecName: j['active_specialization']?['name'] as String?,
    specializations: (j['specializations'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (dynamic e) => ForeverSpecEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );

  @override
  String toString() =>
      'ForeverCharacterSpecializationsResponse{activeSpec: $activeSpecName}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterSpecializationsResponse &&
          runtimeType == other.runtimeType &&
          activeSpecId == other.activeSpecId;

  @override
  int get hashCode => activeSpecId.hashCode;
}

/// A single specialization entry.
@immutable
class ForeverSpecEntry {
  final int specId;
  final String? specName;

  const ForeverSpecEntry({required this.specId, this.specName});

  factory ForeverSpecEntry.fromJson(Map<String, dynamic> j) => ForeverSpecEntry(
    specId: (j['specialization']?['id'] as num?)?.toInt() ?? 0,
    specName: j['specialization']?['name'] as String?,
  );

  @override
  String toString() => 'ForeverSpecEntry{specId: $specId, specName: $specName}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverSpecEntry &&
          runtimeType == other.runtimeType &&
          specId == other.specId;

  @override
  int get hashCode => specId.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterTitlesResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterTitles`.
@immutable
class ForeverCharacterTitlesResponse {
  final List<ForeverTitleEntry> titles;
  final int? activeTitleId;

  const ForeverCharacterTitlesResponse({
    required this.titles,
    this.activeTitleId,
  });

  factory ForeverCharacterTitlesResponse.fromRawJson(String str) =>
      ForeverCharacterTitlesResponse.fromJson(json.decode(str));

  factory ForeverCharacterTitlesResponse.fromJson(Map<String, dynamic> j) =>
      ForeverCharacterTitlesResponse(
        titles: (j['titles'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverTitleEntry.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        activeTitleId: (j['active_title']?['id'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverCharacterTitlesResponse{titles: ${titles.length}, activeTitle: $activeTitleId}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterTitlesResponse &&
          runtimeType == other.runtimeType &&
          titles.length == other.titles.length &&
          activeTitleId == other.activeTitleId;

  @override
  int get hashCode => Object.hash(titles.length, activeTitleId);
}

/// A single title entry.
@immutable
class ForeverTitleEntry {
  final int id;
  final String? name;

  const ForeverTitleEntry({required this.id, this.name});

  factory ForeverTitleEntry.fromJson(Map<String, dynamic> j) =>
      ForeverTitleEntry(
        id: (j['id'] as num?)?.toInt() ?? 0,
        name: j['name'] as String?,
      );

  @override
  String toString() => 'ForeverTitleEntry{id: $id, name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverTitleEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ---------------------------------------------------------------------------
// ForeverCharacterCollectionsResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverCharacterCollections`.
@immutable
class ForeverCharacterCollectionsResponse {
  /// Nullable — may be absent during EU propagation.
  final List<ForeverCollectionEntry>? mounts;

  /// Nullable — may be absent during EU propagation.
  final List<ForeverCollectionEntry>? pets;

  const ForeverCharacterCollectionsResponse({this.mounts, this.pets});

  factory ForeverCharacterCollectionsResponse.fromRawJson(String str) =>
      ForeverCharacterCollectionsResponse.fromJson(json.decode(str));

  factory ForeverCharacterCollectionsResponse.fromJson(
    Map<String, dynamic> j,
  ) => ForeverCharacterCollectionsResponse(
    mounts: (j['mounts'] as List<dynamic>?)
        ?.map(
          (dynamic e) =>
              ForeverCollectionEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
    pets: (j['pets'] as List<dynamic>?)
        ?.map(
          (dynamic e) =>
              ForeverCollectionEntry.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );

  @override
  String toString() =>
      'ForeverCharacterCollectionsResponse{mounts: ${mounts?.length}, pets: ${pets?.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCharacterCollectionsResponse &&
          runtimeType == other.runtimeType &&
          mounts?.length == other.mounts?.length &&
          pets?.length == other.pets?.length;

  @override
  int get hashCode => Object.hash(mounts?.length, pets?.length);
}

/// A single collection entry (mount or pet).
@immutable
class ForeverCollectionEntry {
  final int id;
  final String? name;

  const ForeverCollectionEntry({required this.id, this.name});

  factory ForeverCollectionEntry.fromJson(Map<String, dynamic> j) =>
      ForeverCollectionEntry(
        id:
            (j['id'] as num?)?.toInt() ??
            (j['mount']?['id'] as num?)?.toInt() ??
            (j['species']?['id'] as num?)?.toInt() ??
            0,
        name:
            j['name'] as String? ??
            j['mount']?['name'] as String? ??
            j['species']?['name'] as String?,
      );

  @override
  String toString() => 'ForeverCollectionEntry{id: $id, name: $name}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverCollectionEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
