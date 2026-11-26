import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/guild/{realmSlug}/{nameSlug}`.
class GuildResponse extends ApiModel {
  /// Creates a [GuildResponse] from its JSON object.
  GuildResponse(super.raw);

  /// The guild ID.
  int? get id => intOf('id');

  /// The guild name.
  String? get name => stringOf('name');

  /// The guild faction (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');

  /// Total achievement points.
  int? get achievementPoints => intOf('achievement_points');

  /// Number of members in the guild.
  int? get memberCount => intOf('member_count');

  /// The guild's realm.
  KeyedRef? get realm => refOf('realm');

  /// URL of the guild roster.
  String? get rosterHref => hrefOf('roster');

  /// URL of the guild achievements.
  String? get achievementsHref => hrefOf('achievements');

  /// URL of the guild activity log.
  String? get activityHref => hrefOf('activity');
}

/// Response of `GET /data/wow/guild/{realmSlug}/{nameSlug}/activity`.
class GuildActivityResponse extends ApiModel {
  /// Creates a [GuildActivityResponse] from its JSON object.
  GuildActivityResponse(super.raw);

  /// The guild reference.
  KeyedRef? get guild => refOf('guild');

  /// Recent guild activities, as raw JSON objects.
  List<Map<String, dynamic>> get activities =>
      listOf<Map<String, dynamic>>('activities', (Map<String, dynamic> a) => a);
}

/// Response of `GET /data/wow/guild/{realmSlug}/{nameSlug}/achievements`.
class GuildAchievementsResponse extends ApiModel {
  /// Creates a [GuildAchievementsResponse] from its JSON object.
  GuildAchievementsResponse(super.raw);

  /// The guild reference.
  KeyedRef? get guild => refOf('guild');

  /// Total number of completed guild achievements.
  int? get totalQuantity => intOf('total_quantity');

  /// Total guild achievement points.
  int? get totalPoints => intOf('total_points');

  /// Completed guild achievements, as raw JSON objects.
  List<Map<String, dynamic>> get achievements => listOf<Map<String, dynamic>>(
    'achievements',
    (Map<String, dynamic> a) => a,
  );
}

/// Response of `GET /data/wow/guild/{realmSlug}/{nameSlug}/roster`.
class GuildRosterResponse extends ApiModel {
  /// Creates a [GuildRosterResponse] from its JSON object.
  GuildRosterResponse(super.raw);

  /// The guild reference.
  KeyedRef? get guild => refOf('guild');

  /// Guild members.
  List<GuildMember> get members =>
      listOf<GuildMember>('members', GuildMember.new);
}

/// A member entry in [GuildRosterResponse].
class GuildMember extends ApiModel {
  /// Creates a [GuildMember] from its JSON object.
  GuildMember(super.raw);

  /// The guild rank index (0 = Guild Master).
  int? get rank => intOf('rank');

  /// The character ID.
  int? get characterId => idOf('character');

  /// The character name.
  String? get characterName => nameOf('character');
}
