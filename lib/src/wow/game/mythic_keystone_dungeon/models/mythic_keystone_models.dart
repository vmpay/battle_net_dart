import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/mythic-keystone/index`.
class MythicKeystoneIndexResponse extends ApiModel {
  /// Creates a [MythicKeystoneIndexResponse] from its JSON object.
  MythicKeystoneIndexResponse(super.raw);

  /// The URL of the Mythic Keystone seasons index.
  String? get seasonsHref => hrefOf('seasons');

  /// The URL of the Mythic Keystone dungeons index.
  String? get dungeonsHref => hrefOf('dungeons');
}

/// Response of `GET /data/wow/mythic-keystone/dungeon/index`.
class MythicKeystoneDungeonsIndexResponse extends ApiModel {
  /// Creates a [MythicKeystoneDungeonsIndexResponse] from its JSON object.
  MythicKeystoneDungeonsIndexResponse(super.raw);

  /// All Mythic Keystone dungeons.
  List<KeyedRef> get dungeons => refsOf('dungeons');
}

/// Response of `GET /data/wow/mythic-keystone/dungeon/{dungeonId}`.
class MythicKeystoneDungeonResponse extends ApiModel {
  /// Creates a [MythicKeystoneDungeonResponse] from its JSON object.
  MythicKeystoneDungeonResponse(super.raw);

  /// The Mythic Keystone dungeon ID.
  int? get id => intOf('id');

  /// The localized dungeon name.
  String? get name => stringOf('name');

  /// The ID of the dungeon map.
  int? get mapId => idOf('map');

  /// The journal instance of the dungeon.
  KeyedRef? get dungeon => refOf('dungeon');

  /// Whether the dungeon is part of the current Mythic+ rotation.
  bool? get isTracked => boolOf('is_tracked');

  /// The timers needed for +1, +2 and +3 keystone upgrades.
  List<KeystoneUpgrade> get keystoneUpgrades =>
      listOf<KeystoneUpgrade>('keystone_upgrades', KeystoneUpgrade.new);
}

/// A keystone upgrade timer.
class KeystoneUpgrade extends ApiModel {
  /// Creates a [KeystoneUpgrade] from its JSON object.
  KeystoneUpgrade(super.raw);

  /// The number of levels the keystone is upgraded by.
  int? get upgradeLevel => intOf('upgrade_level');

  /// The maximum run duration in milliseconds for this upgrade.
  int? get qualifyingDuration => intOf('qualifying_duration');
}

/// Response of `GET /data/wow/mythic-keystone/season/index`.
class MythicKeystoneSeasonsIndexResponse extends ApiModel {
  /// Creates a [MythicKeystoneSeasonsIndexResponse] from its JSON object.
  MythicKeystoneSeasonsIndexResponse(super.raw);

  /// All Mythic Keystone seasons.
  List<KeyedRef> get seasons => refsOf('seasons');

  /// The ID of the current season.
  int? get currentSeasonId => idOf('current_season');
}

/// Response of `GET /data/wow/mythic-keystone/season/{seasonId}`.
class MythicKeystoneSeasonResponse extends ApiModel {
  /// Creates a [MythicKeystoneSeasonResponse] from its JSON object.
  MythicKeystoneSeasonResponse(super.raw);

  /// The season ID.
  int? get id => intOf('id');

  /// The localized season name, when available.
  String? get seasonName => stringOf('season_name');

  /// The season start, as a Unix timestamp in milliseconds.
  int? get startTimestamp => intOf('start_timestamp');

  /// The season end, as a Unix timestamp in milliseconds (`null` while the
  /// season is running).
  int? get endTimestamp => intOf('end_timestamp');

  /// The weekly periods of the season.
  List<KeyedRef> get periods => refsOf('periods');
}

/// Response of `GET /data/wow/connected-realm/{id}/mythic-leaderboard/index`.
class MythicKeystoneLeaderboardsIndexResponse extends ApiModel {
  /// Creates a [MythicKeystoneLeaderboardsIndexResponse] from its JSON object.
  MythicKeystoneLeaderboardsIndexResponse(super.raw);

  /// The current leaderboards, one per dungeon.
  List<KeyedRef> get currentLeaderboards => refsOf('current_leaderboards');
}

/// Response of
/// `GET /data/wow/connected-realm/{id}/mythic-leaderboard/{dungeonId}/period/{period}`.
class MythicKeystoneLeaderboardResponse extends ApiModel {
  /// Creates a [MythicKeystoneLeaderboardResponse] from its JSON object.
  MythicKeystoneLeaderboardResponse(super.raw);

  /// The localized dungeon name.
  String? get dungeonName => nameOf('map');

  /// The ID of the dungeon map.
  int? get mapId => idOf('map');

  /// The weekly period of the leaderboard.
  int? get period => intOf('period');

  /// The period start, as a Unix timestamp in milliseconds.
  int? get periodStartTimestamp => intOf('period_start_timestamp');

  /// The period end, as a Unix timestamp in milliseconds.
  int? get periodEndTimestamp => intOf('period_end_timestamp');

  /// The URL of the connected realm.
  String? get connectedRealmHref => hrefOf('connected_realm');

  /// The ranked groups.
  List<MythicKeystoneLeadingGroup> get leadingGroups =>
      listOf<MythicKeystoneLeadingGroup>(
        'leading_groups',
        MythicKeystoneLeadingGroup.new,
      );
}

/// A ranked group on a Mythic Keystone leaderboard.
class MythicKeystoneLeadingGroup extends ApiModel {
  /// Creates a [MythicKeystoneLeadingGroup] from its JSON object.
  MythicKeystoneLeadingGroup(super.raw);

  /// The rank of the group.
  int? get ranking => intOf('ranking');

  /// The run duration in milliseconds.
  int? get duration => intOf('duration');

  /// When the run was completed, as a Unix timestamp in milliseconds.
  int? get completedTimestamp => intOf('completed_timestamp');

  /// The keystone level.
  int? get keystoneLevel => intOf('keystone_level');

  /// The group members, as raw JSON objects.
  List<Map<String, dynamic>> get members =>
      listOf<Map<String, dynamic>>('members', (Map<String, dynamic> m) => m);
}

/// Response of `GET /data/wow/leaderboard/hall-of-fame/{raid}/{faction}`.
class MythicRaidLeaderboardResponse extends ApiModel {
  /// Creates a [MythicRaidLeaderboardResponse] from its JSON object.
  MythicRaidLeaderboardResponse(super.raw);

  /// The raid slug, for example `uldir`.
  String? get slug => stringOf('slug');

  /// The leaderboard criteria, for example `hall-of-fame`.
  String? get criteriaType => stringOf('criteria_type');

  /// The ranked guilds.
  List<MythicRaidLeaderboardEntry> get entries =>
      listOf<MythicRaidLeaderboardEntry>(
        'entries',
        MythicRaidLeaderboardEntry.new,
      );
}

/// A ranked guild on a Mythic Raid leaderboard.
class MythicRaidLeaderboardEntry extends ApiModel {
  /// Creates a [MythicRaidLeaderboardEntry] from its JSON object.
  MythicRaidLeaderboardEntry(super.raw);

  /// The rank of the guild.
  int? get rank => intOf('rank');

  /// When the guild completed the raid, as a Unix timestamp in milliseconds.
  int? get timestamp => intOf('timestamp');

  /// The guild name.
  String? get guildName => nameOf('guild');

  /// The guild ID.
  int? get guildId => idOf('guild');

  /// The slug of the guild's realm.
  String? get realmSlug {
    final Object? realm = mapOf('guild')?['realm'];
    return realm is Map<String, dynamic> ? realm['slug'] as String? : null;
  }

  /// The guild faction, for example `ALLIANCE`.
  String? get faction => typeOf('faction');
}
