import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/exceptions/battle_net_not_found_exception.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:battle_net/src/wow/forever/forever_character_slug.dart';
import 'package:battle_net/src/wow/forever/models/forever_character_models.dart';
import 'package:http/http.dart' as http;

/// Client for WoW: Forever character profile endpoints.
///
/// All endpoints use the `profile-forever-{region}` namespace.
/// Characters are identified by a [ForeverCharacterSlug] (`name-surname`).
///
/// **Note:** Characters only appear in the API from level 10+ and only after
/// a full logout. Any call may throw [BattleNetNotFoundException] if the
/// character is below level 10 or still online.
class ForeverCharacterClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  static const String _profileBasePath = '/profile/wow/character';

  ForeverCharacterClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  // -------------------------------------------------------------------------
  // Internal helper — calls doGet and translates 404+BLZWEBAPI00000404 into
  // BattleNetNotFoundException.
  // -------------------------------------------------------------------------
  Future<T> _get<T>({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required String path,
    required T Function(String) parser,
  }) async {
    try {
      return await doGet(
        client: _httpClient,
        connectionTimeout: _connectionTimeout,
        accessToken: accessToken,
        region: region,
        namespace: namespace,
        queryParameters: <String, String?>{'locale': locale.name},
        path: path,
        parser: parser,
      );
    } on Exception catch (e) {
      final String msg = e.toString();
      if (msg.contains('404') && msg.contains('BLZWEBAPI00000404')) {
        throw BattleNetNotFoundException(url: path, body: msg);
      }
      rethrow;
    }
  }

  String _charPath(ForeverCharacterSlug slug) =>
      '$_profileBasePath/${slug.value}';

  // -------------------------------------------------------------------------
  // Profile
  // -------------------------------------------------------------------------

  /// Returns the base character profile for a WoW: Forever character.
  Future<ForeverCharacterProfileResponse> getForeverCharacterProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: _charPath(slug),
    parser: ForeverCharacterProfileResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Equipment
  // -------------------------------------------------------------------------

  /// Returns a Forever character's equipped items.
  ///
  /// [equippedItems] in the response may be `null` during EU propagation.
  Future<ForeverCharacterEquipmentResponse> getForeverCharacterEquipment({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/equipment',
    parser: ForeverCharacterEquipmentResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Media
  // -------------------------------------------------------------------------

  /// Returns render asset URLs for a Forever character.
  ///
  /// [assets] in the response may be `null` during EU propagation.
  Future<ForeverCharacterMediaResponse> getForeverCharacterMedia({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/character-media',
    parser: ForeverCharacterMediaResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Achievements
  // -------------------------------------------------------------------------

  /// Returns a Forever character's completed achievements.
  Future<ForeverCharacterAchievementsResponse> getForeverCharacterAchievements({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/achievements',
    parser: ForeverCharacterAchievementsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Statistics
  // -------------------------------------------------------------------------

  /// Returns achievement statistics for a Forever character.
  Future<ForeverCharacterStatisticsResponse> getForeverCharacterStatistics({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/achievements/statistics',
    parser: ForeverCharacterStatisticsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Encounters
  // -------------------------------------------------------------------------

  /// Returns dungeon encounter completion data for a Forever character.
  Future<ForeverCharacterEncountersResponse>
  getForeverCharacterDungeonEncounters({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/encounters/dungeons',
    parser: ForeverCharacterEncountersResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // PvP
  // -------------------------------------------------------------------------

  /// Returns the PvP summary for a Forever character.
  Future<ForeverCharacterPvpSummaryResponse> getForeverCharacterPvpSummary({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/pvp-summary',
    parser: ForeverCharacterPvpSummaryResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Quests
  // -------------------------------------------------------------------------

  /// Returns completed quests for a Forever character.
  Future<ForeverCharacterQuestsResponse> getForeverCharacterCompletedQuests({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/quests/completed',
    parser: ForeverCharacterQuestsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Reputations
  // -------------------------------------------------------------------------

  /// Returns reputations for a Forever character.
  Future<ForeverCharacterReputationsResponse> getForeverCharacterReputations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/reputations',
    parser: ForeverCharacterReputationsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Professions
  // -------------------------------------------------------------------------

  /// Returns profession skill levels for a Forever character.
  Future<ForeverCharacterProfessionsResponse> getForeverCharacterProfessions({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/professions',
    parser: ForeverCharacterProfessionsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Specializations
  // -------------------------------------------------------------------------

  /// Returns specialization data for a Forever character.
  Future<ForeverCharacterSpecializationsResponse>
  getForeverCharacterSpecializations({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/specializations',
    parser: ForeverCharacterSpecializationsResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Titles
  // -------------------------------------------------------------------------

  /// Returns unlocked titles for a Forever character.
  Future<ForeverCharacterTitlesResponse> getForeverCharacterTitles({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/titles',
    parser: ForeverCharacterTitlesResponse.fromRawJson,
  );

  // -------------------------------------------------------------------------
  // Collections
  // -------------------------------------------------------------------------

  /// Returns the mount and pet collection summary for a Forever character.
  ///
  /// [mounts] and [pets] in the response may be `null` during EU propagation.
  Future<ForeverCharacterCollectionsResponse> getForeverCharacterCollections({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required ForeverCharacterSlug slug,
  }) => _get(
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    locale: locale,
    path: '${_charPath(slug)}/collections',
    parser: ForeverCharacterCollectionsResponse.fromRawJson,
  );
}
