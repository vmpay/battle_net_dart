import 'package:battle_net/src/wow/forever/forever_account_client.dart';
import 'package:battle_net/src/wow/forever/forever_character_client.dart';
import 'package:battle_net/src/wow/forever/forever_item_client.dart';
import 'package:battle_net/src/wow/forever/forever_ruleset_client.dart';
import 'package:battle_net/src/wow/game/achievement/achievement_client.dart';
import 'package:battle_net/src/wow/game/auction_house/auction_house_client.dart';
import 'package:battle_net/src/wow/game/azerite_essence/azerite_essence_client.dart';
import 'package:battle_net/src/wow/game/connected_realm/connected_realm_client.dart';
import 'package:battle_net/src/wow/game/covenant/covenant_client.dart';
import 'package:battle_net/src/wow/game/creature/creature_client.dart';
import 'package:battle_net/src/wow/game/guild_crest/guild_crest_client.dart';
import 'package:battle_net/src/wow/game/heirloom/heirloom_client.dart';
import 'package:battle_net/src/wow/game/item/item_client.dart';
import 'package:battle_net/src/wow/game/journal/journal_client.dart';
import 'package:battle_net/src/wow/game/media/media_client.dart';
import 'package:battle_net/src/wow/game/modified_crafting/modified_crafting_client.dart';
import 'package:battle_net/src/wow/game/mount/mount_client.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_affix/mythic_keystone_affix_client.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/mythic_keystone_dungeon_client.dart';
import 'package:battle_net/src/wow/game/mythic_leaderboard/mythic_leaderboard_client.dart';
import 'package:battle_net/src/wow/game/pet/pet_client.dart';
import 'package:battle_net/src/wow/game/playable/playable_client.dart';
import 'package:battle_net/src/wow/game/power_type/power_type_client.dart';
import 'package:battle_net/src/wow/game/profession/profession_client.dart';
import 'package:battle_net/src/wow/game/pvp/pvp_client.dart';
import 'package:battle_net/src/wow/game/quest/quest_client.dart';
import 'package:battle_net/src/wow/game/realm/realm_client.dart';
import 'package:battle_net/src/wow/game/reputation/reputation_client.dart';
import 'package:battle_net/src/wow/game/spell/spell_client.dart';
import 'package:battle_net/src/wow/game/talent/talent_client.dart';
import 'package:battle_net/src/wow/game/tech_talent/tech_talent_client.dart';
import 'package:battle_net/src/wow/game/title/title_client.dart';
import 'package:battle_net/src/wow/game/token/token_client.dart';
import 'package:battle_net/src/wow/game/toy/toy_client.dart';
import 'package:http/http.dart' as http;

/// Grouped World of Warcraft API sub-clients exposed via `battleNet.wow`.
class WowApi {
  /// Creates a [WowApi] instance sharing the provided [connectionTimeout]
  /// and optional [httpClient].
  WowApi({
    required int connectionTimeout,
    http.Client? httpClient,
    required TokenClient token,
    required ConnectedRealmClient connectedRealm,
    required MythicKeystoneDungeonClient mythicKeystoneDungeon,
    required MythicKeystoneAffixClient mythicKeystoneAffix,
    required ForeverCharacterClient foreverCharacter,
    required ForeverAccountClient foreverAccount,
    required ForeverItemClient foreverItem,
    required ForeverRulesetClient foreverRuleset,
  }) : _token = token,
       _connectedRealm = connectedRealm,
       _mythicKeystoneDungeon = mythicKeystoneDungeon,
       _mythicKeystoneAffix = mythicKeystoneAffix,
       _foreverCharacter = foreverCharacter,
       _foreverAccount = foreverAccount,
       _foreverItem = foreverItem,
       _foreverRuleset = foreverRuleset,
       realm = RealmClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       region = RegionClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       auctionHouse = AuctionHouseClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       item = ItemClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       profession = ProfessionClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       mythicKeystoneLeaderboard = MythicKeystoneLeaderboardClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       mythicRaidLeaderboard = MythicRaidLeaderboardClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       achievement = AchievementClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       creature = CreatureClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       journal = JournalClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       mount = MountClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       pet = PetClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       playableClass = PlayableClassClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       playableRace = PlayableRaceClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       playableSpecialization = PlayableSpecializationClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       pvpSeason = PvpSeasonClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       pvpTier = PvpTierClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       quest = QuestClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       spell = SpellClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       talent = TalentClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       azeriteEssence = AzeriteEssenceClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       covenant = CovenantClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       guildCrest = GuildCrestClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       heirloom = HeirloomClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       media = MediaClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       modifiedCrafting = ModifiedCraftingClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       powerType = PowerTypeClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       reputation = ReputationClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       techTalent = TechTalentClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       title = TitleClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       ),
       toy = ToyClient(
         connectionTimeout: connectionTimeout,
         client: httpClient,
       );

  final TokenClient _token;
  final ConnectedRealmClient _connectedRealm;
  final MythicKeystoneDungeonClient _mythicKeystoneDungeon;
  final MythicKeystoneAffixClient _mythicKeystoneAffix;
  final ForeverCharacterClient _foreverCharacter;
  final ForeverAccountClient _foreverAccount;
  final ForeverItemClient _foreverItem;
  final ForeverRulesetClient _foreverRuleset;

  /// WoW Token API.
  TokenClient get token => _token;

  /// Connected Realm API.
  ConnectedRealmClient get connectedRealm => _connectedRealm;

  /// Mythic Keystone Dungeon API.
  MythicKeystoneDungeonClient get mythicKeystoneDungeon =>
      _mythicKeystoneDungeon;

  /// Mythic Keystone Affix API.
  MythicKeystoneAffixClient get mythicKeystoneAffix => _mythicKeystoneAffix;

  /// WoW: Forever Character Profile API.
  ForeverCharacterClient get foreverCharacter => _foreverCharacter;

  /// WoW: Forever Account Profile API.
  ForeverAccountClient get foreverAccount => _foreverAccount;

  /// WoW: Forever Item API.
  ForeverItemClient get foreverItem => _foreverItem;

  /// WoW: Forever Ruleset & Auction House API.
  ForeverRulesetClient get foreverRuleset => _foreverRuleset;

  /// Realm API.
  final RealmClient realm;

  /// Region API.
  final RegionClient region;

  /// Auction House API.
  final AuctionHouseClient auctionHouse;

  /// Item API.
  final ItemClient item;

  /// Profession API.
  final ProfessionClient profession;

  /// Mythic Keystone Leaderboard API.
  final MythicKeystoneLeaderboardClient mythicKeystoneLeaderboard;

  /// Mythic Raid Leaderboard API.
  final MythicRaidLeaderboardClient mythicRaidLeaderboard;

  /// Achievement API.
  final AchievementClient achievement;

  /// Creature API.
  final CreatureClient creature;

  /// Journal API.
  final JournalClient journal;

  /// Mount API.
  final MountClient mount;

  /// Pet API.
  final PetClient pet;

  /// Playable Class API.
  final PlayableClassClient playableClass;

  /// Playable Race API.
  final PlayableRaceClient playableRace;

  /// Playable Specialization API.
  final PlayableSpecializationClient playableSpecialization;

  /// PvP Season API.
  final PvpSeasonClient pvpSeason;

  /// PvP Tier API.
  final PvpTierClient pvpTier;

  /// Quest API.
  final QuestClient quest;

  /// Spell API.
  final SpellClient spell;

  /// Talent API.
  final TalentClient talent;

  /// Azerite Essence API.
  final AzeriteEssenceClient azeriteEssence;

  /// Covenant API.
  final CovenantClient covenant;

  /// Guild Crest API.
  final GuildCrestClient guildCrest;

  /// Heirloom API.
  final HeirloomClient heirloom;

  /// Media Search API.
  final MediaClient media;

  /// Modified Crafting API.
  final ModifiedCraftingClient modifiedCrafting;

  /// Power Type API.
  final PowerTypeClient powerType;

  /// Reputation API.
  final ReputationClient reputation;

  /// Tech Talent API.
  final TechTalentClient techTalent;

  /// Title API.
  final TitleClient title;

  /// Toy API.
  final ToyClient toy;
}
