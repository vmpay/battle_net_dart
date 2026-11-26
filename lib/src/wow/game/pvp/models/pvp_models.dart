import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/pvp-season/index`.
class PvpSeasonsIndexResponse extends ApiModel {
  /// Creates a [PvpSeasonsIndexResponse] from its JSON object.
  PvpSeasonsIndexResponse(super.raw);

  /// All PvP seasons.
  List<KeyedRef> get seasons => refsOf('seasons');

  /// The ID of the current PvP season.
  int? get currentSeasonId => idOf('current_season');
}

/// Response of `GET /data/wow/pvp-season/{pvpSeasonId}`.
class PvpSeasonResponse extends ApiModel {
  /// Creates a [PvpSeasonResponse] from its JSON object.
  PvpSeasonResponse(super.raw);

  /// The PvP season ID.
  int? get id => intOf('id');

  /// The localized season name, when available.
  String? get seasonName => stringOf('season_name');

  /// The season start, as a Unix timestamp in milliseconds.
  int? get seasonStartTimestamp => intOf('season_start_timestamp');

  /// The season end, as a Unix timestamp in milliseconds (`null` while active).
  int? get seasonEndTimestamp => intOf('season_end_timestamp');

  /// The URL of the leaderboards index for this season.
  String? get leaderboardsHref => hrefOf('leaderboards');

  /// The URL of the rewards index for this season.
  String? get rewardsHref => hrefOf('rewards');
}

/// Response of `GET /data/wow/pvp-season/{pvpSeasonId}/pvp-leaderboard/index`.
class PvpLeaderboardsIndexResponse extends ApiModel {
  /// Creates a [PvpLeaderboardsIndexResponse] from its JSON object.
  PvpLeaderboardsIndexResponse(super.raw);

  /// The leaderboards available for this season.
  List<KeyedRef> get leaderboards => refsOf('leaderboards');
}

/// Response of
/// `GET /data/wow/pvp-season/{pvpSeasonId}/pvp-leaderboard/{pvpBracket}`.
class PvpLeaderboardResponse extends ApiModel {
  /// Creates a [PvpLeaderboardResponse] from its JSON object.
  PvpLeaderboardResponse(super.raw);

  /// The bracket name, for example `3v3`.
  String? get name => stringOf('name');

  /// The bracket type, for example `ARENA_3v3`.
  String? get bracketType => typeOf('bracket');

  /// The season ID.
  int? get seasonId => idOf('season');

  /// The ranked entries.
  List<PvpLeaderboardEntry> get entries =>
      listOf<PvpLeaderboardEntry>('entries', PvpLeaderboardEntry.new);
}

/// A ranked entry on a PvP leaderboard.
class PvpLeaderboardEntry extends ApiModel {
  /// Creates a [PvpLeaderboardEntry] from its JSON object.
  PvpLeaderboardEntry(super.raw);

  /// The player's rank.
  int? get rank => intOf('rank');

  /// The player's rating.
  int? get rating => intOf('rating');

  /// The character name.
  String? get characterName => nameOf('character');

  /// The character ID.
  int? get characterId => idOf('character');

  /// The faction type (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');
}

/// Response of `GET /data/wow/pvp-season/{pvpSeasonId}/pvp-reward/index`.
class PvpRewardsIndexResponse extends ApiModel {
  /// Creates a [PvpRewardsIndexResponse] from its JSON object.
  PvpRewardsIndexResponse(super.raw);

  /// The rewards for this season, as raw JSON objects.
  List<Map<String, dynamic>> get rewards =>
      listOf<Map<String, dynamic>>('rewards', (Map<String, dynamic> r) => r);
}

/// Response of `GET /data/wow/pvp-tier/index`.
class PvpTiersIndexResponse extends ApiModel {
  /// Creates a [PvpTiersIndexResponse] from its JSON object.
  PvpTiersIndexResponse(super.raw);

  /// All PvP tiers.
  List<KeyedRef> get tiers => refsOf('tiers');
}

/// Response of `GET /data/wow/pvp-tier/{pvpTierId}`.
class PvpTierResponse extends ApiModel {
  /// Creates a [PvpTierResponse] from its JSON object.
  PvpTierResponse(super.raw);

  /// The PvP tier ID.
  int? get id => intOf('id');

  /// The localized tier name.
  String? get name => stringOf('name');

  /// The minimum rating for this tier.
  int? get minRating => intOf('min_rating');

  /// The maximum rating for this tier.
  int? get maxRating => intOf('max_rating');

  /// The bracket type.
  String? get bracket => typeOf('bracket');

  /// The rating type.
  String? get ratingType => stringOf('rating_type');

  /// The ID to use with `getPvpTierMedia`.
  int? get mediaId => idOf('media');
}
