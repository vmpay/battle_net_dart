import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/character_models.dart';

/// Client for the Character Profile API (`battleNet.wow.character`).
///
/// [namespace] defaults to [BattleNetNamespace.profile] (Retail).
/// Character names are lowercased automatically before building request paths.
class CharacterProfileClient extends ApiClient {
  /// Creates a [CharacterProfileClient].
  CharacterProfileClient({required super.connectionTimeout, super.client});

  String _basePath(String realmSlug, String characterName) =>
      '/profile/wow/character/$realmSlug/${characterName.toLowerCase()}';

  /// Returns a profile summary for a character.
  Future<CharacterProfileResponse> getCharacterProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: _basePath(realmSlug, characterName),
    parse: CharacterProfileResponse.new,
  );

  /// Returns the profile status (validity) for a character.
  Future<CharacterProfileStatusResponse> getCharacterProfileStatus({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/status',
    parse: CharacterProfileStatusResponse.new,
  );

  /// Returns a character's achievements summary.
  Future<CharacterAchievementsResponse> getCharacterAchievements({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/achievements',
    parse: CharacterAchievementsResponse.new,
  );

  /// Returns a character's achievement statistics.
  Future<CharacterAchievementStatisticsResponse>
  getCharacterAchievementStatistics({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/achievements/statistics',
    parse: CharacterAchievementStatisticsResponse.new,
  );

  /// Returns a character's appearance settings.
  Future<CharacterAppearanceResponse> getCharacterAppearance({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/appearance',
    parse: CharacterAppearanceResponse.new,
  );

  /// Returns an index of a character's collections.
  Future<CharacterCollectionsIndexResponse> getCharacterCollectionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections',
    parse: CharacterCollectionsIndexResponse.new,
  );

  /// Returns a character's mounts collection.
  Future<CharacterMountsCollectionResponse> getCharacterMountsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections/mounts',
    parse: CharacterMountsCollectionResponse.new,
  );

  /// Returns a character's battle pets collection.
  Future<CharacterPetsCollectionResponse> getCharacterPetsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections/pets',
    parse: CharacterPetsCollectionResponse.new,
  );

  /// Returns a character's toys collection.
  Future<CharacterToysCollectionResponse> getCharacterToysCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections/toys',
    parse: CharacterToysCollectionResponse.new,
  );

  /// Returns a character's heirlooms collection.
  Future<CharacterHeirloomsCollectionResponse> getCharacterHeirloomsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections/heirlooms',
    parse: CharacterHeirloomsCollectionResponse.new,
  );

  /// Returns a character's transmogs collection.
  Future<CharacterTransmogsCollectionResponse> getCharacterTransmogsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/collections/transmogs',
    parse: CharacterTransmogsCollectionResponse.new,
  );

  /// Returns a summary of a character's encounters.
  Future<CharacterEncountersSummaryResponse> getCharacterEncountersSummary({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/encounters',
    parse: CharacterEncountersSummaryResponse.new,
  );

  /// Returns a character's completed dungeon encounters.
  Future<CharacterDungeonsResponse> getCharacterDungeons({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/encounters/dungeons',
    parse: CharacterDungeonsResponse.new,
  );

  /// Returns a character's completed raid encounters.
  Future<CharacterRaidsResponse> getCharacterRaids({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/encounters/raids',
    parse: CharacterRaidsResponse.new,
  );

  /// Returns a character's equipped items.
  Future<CharacterEquipmentResponse> getCharacterEquipment({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/equipment',
    parse: CharacterEquipmentResponse.new,
  );

  /// Returns a hunter character's tamed pets.
  Future<CharacterHunterPetsResponse> getCharacterHunterPets({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/hunter-pets',
    parse: CharacterHunterPetsResponse.new,
  );

  /// Returns render media URLs for a character.
  Future<CharacterMediaResponse> getCharacterMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/character-media',
    parse: CharacterMediaResponse.new,
  );

  /// Returns a character's Mythic Keystone profile index.
  Future<CharacterMythicKeystoneProfileResponse>
  getCharacterMythicKeystoneProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/mythic-keystone-profile',
    parse: CharacterMythicKeystoneProfileResponse.new,
  );

  /// Returns a character's Mythic Keystone season details by [seasonId].
  Future<CharacterMythicKeystoneSeasonResponse>
  getCharacterMythicKeystoneSeasonDetails({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    required int seasonId,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path:
        '${_basePath(realmSlug, characterName)}/mythic-keystone-profile/season/$seasonId',
    parse: CharacterMythicKeystoneSeasonResponse.new,
  );

  /// Returns a character's professions.
  Future<CharacterProfessionsResponse> getCharacterProfessions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/professions',
    parse: CharacterProfessionsResponse.new,
  );

  /// Returns a character's PvP bracket statistics (e.g. `2v2`, `3v3`, `rbg`).
  Future<CharacterPvpBracketResponse> getCharacterPvpBracketStatistics({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    required String pvpBracket,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/pvp-bracket/$pvpBracket',
    parse: CharacterPvpBracketResponse.new,
  );

  /// Returns a character's PvP summary.
  Future<CharacterPvpSummaryResponse> getCharacterPvpSummary({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/pvp-summary',
    parse: CharacterPvpSummaryResponse.new,
  );

  /// Returns a character's active quests.
  Future<CharacterQuestsResponse> getCharacterQuests({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/quests',
    parse: CharacterQuestsResponse.new,
  );

  /// Returns a character's completed quests.
  Future<CharacterCompletedQuestsResponse> getCharacterCompletedQuests({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/quests/completed',
    parse: CharacterCompletedQuestsResponse.new,
  );

  /// Returns a character's reputations.
  Future<CharacterReputationsResponse> getCharacterReputations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/reputations',
    parse: CharacterReputationsResponse.new,
  );

  /// Returns a character's Shadowlands soulbinds.
  Future<CharacterSoulbindsResponse> getCharacterSoulbinds({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/soulbinds',
    parse: CharacterSoulbindsResponse.new,
  );

  /// Returns a character's specializations and talent loadouts.
  Future<CharacterSpecializationsResponse> getCharacterSpecializations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/specializations',
    parse: CharacterSpecializationsResponse.new,
  );

  /// Returns a character's combat statistics.
  Future<CharacterStatisticsResponse> getCharacterStatistics({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/statistics',
    parse: CharacterStatisticsResponse.new,
  );

  /// Returns a character's unlocked titles.
  Future<CharacterTitlesResponse> getCharacterTitles({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required String realmSlug,
    required String characterName,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '${_basePath(realmSlug, characterName)}/titles',
    parse: CharacterTitlesResponse.new,
  );
}
