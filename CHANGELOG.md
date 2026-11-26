## 0.4.4

- Added World of Warcraft Profile & Guild APIs under `battleNet.wow`:
  - `account` (`getAccountProfile`, `getProtectedCharacterProfile`, `getAccountCollectionsIndex`, `getAccountMountsCollection`, `getAccountPetsCollection`, `getAccountToysCollection`, `getAccountHeirloomsCollection`, `getAccountTransmogsCollection` — requires user token with `wow.profile` scope)
  - `character` (29 endpoints: profile, status, achievements, statistics, appearance, collections, encounters, equipment, hunter pets, media, mythic keystone profile/season, professions, PvP summary/bracket, quests, reputations, soulbinds, specializations, titles)
  - `guild` (`getGuild`, `getGuildActivity`, `getGuildAchievements`, `getGuildRoster`)

## 0.4.3

- Added Batch C World of Warcraft Game Data sub-clients under `battleNet.wow`:
  - `azeriteEssence` (`getAzeriteEssencesIndex`, `getAzeriteEssence`, `getAzeriteEssenceMedia`, `searchAzeriteEssences`)
  - `covenant` (`getCovenantsIndex`, `getCovenant`, `getCovenantMedia`, `getSoulbindsIndex`, `getSoulbind`, `getConduitsIndex`, `getConduit`)
  - `guildCrest` (`getGuildCrestComponentsIndex`, `getGuildCrestBorderMedia`, `getGuildCrestEmblemMedia`)
  - `heirloom` (`getHeirloomsIndex`, `getHeirloom`)
  - `media` (`searchMedia`)
  - `modifiedCrafting` (`getModifiedCraftingIndex`, `getModifiedCraftingCategoriesIndex`, `getModifiedCraftingCategory`, `getModifiedCraftingReagentSlotTypesIndex`, `getModifiedCraftingReagentSlotType`)
  - `powerType` (`getPowerTypesIndex`, `getPowerType`)
  - `reputation` (`getReputationFactionsIndex`, `getReputationFaction`, `getReputationTiersIndex`, `getReputationTiers`)
  - `techTalent` (`getTechTalentTreesIndex`, `getTechTalentTree`, `getTechTalentsIndex`, `getTechTalent`, `getTechTalentMedia`)
  - `title` (`getTitlesIndex`, `getTitle`)
  - `toy` (`getToysIndex`, `getToy`)

## 0.4.2

- Added Batch B World of Warcraft Game Data sub-clients under `battleNet.wow`:
  - `achievement` (`getAchievementCategoriesIndex`, `getAchievementCategory`, `getAchievementsIndex`, `getAchievement`, `getAchievementMedia`)
  - `creature` (`getCreatureFamiliesIndex`, `getCreatureFamily`, `getCreatureFamilyMedia`, `getCreatureTypesIndex`, `getCreatureType`, `getCreature`, `getCreatureDisplayMedia`, `searchCreatures`)
  - `journal` (`getJournalExpansionsIndex`, `getJournalExpansion`, `getJournalEncountersIndex`, `getJournalEncounter`, `searchJournalEncounters`, `getJournalInstancesIndex`, `getJournalInstance`, `getJournalInstanceMedia`)
  - `mount` (`getMountsIndex`, `getMount`, `searchMounts`)
  - `pet` (`getPetsIndex`, `getPet`, `getPetMedia`, `getPetAbilitiesIndex`, `getPetAbility`, `getPetAbilityMedia`)
  - `playableClass` (`getPlayableClassesIndex`, `getPlayableClass`, `getPlayableClassMedia`, `getPvpTalentSlots`)
  - `playableRace` (`getPlayableRacesIndex`, `getPlayableRace`)
  - `playableSpecialization` (`getPlayableSpecializationsIndex`, `getPlayableSpecialization`, `getPlayableSpecializationMedia`)
  - `pvpSeason` (`getPvpSeasonsIndex`, `getPvpSeason`, `getPvpLeaderboardsIndex`, `getPvpLeaderboard`, `getPvpRewardsIndex`)
  - `pvpTier` (`getPvpTiersIndex`, `getPvpTier`, `getPvpTierMedia`)
  - `quest` (`getQuestsIndex`, `getQuest`, `getQuestCategoriesIndex`, `getQuestCategory`, `getQuestAreasIndex`, `getQuestArea`, `getQuestTypesIndex`, `getQuestType`)
  - `spell` (`getSpell`, `getSpellMedia`, `searchSpells`)
  - `talent` (`getTalentTreesIndex`, `getTalentTree`, `getTalentTreeNodes`, `getTalentsIndex`, `getTalent`, `getPvpTalentsIndex`, `getPvpTalent`)

## 0.4.1

- Added grouped World of Warcraft API sub-clients via `battleNet.wow.<group>`:
  - `realm` (`getRealmsIndex`, `getRealm`, `searchRealms`)
  - `region` (`getRegionsIndex`, `getRegion`)
  - `connectedRealm` (added `getConnectedRealmsIndex`)
  - `auctionHouse` (`getAuctions`, `getCommodities`)
  - `item` (`getItemClassesIndex`, `getItemClass`, `getItemSubclass`, `getItemSetsIndex`, `getItemSet`, `getItem`, `getItemMedia`, `searchItems`)
  - `profession` (`getProfessionsIndex`, `getProfession`, `getProfessionMedia`, `getProfessionSkillTier`, `getRecipe`, `getRecipeMedia`)
  - `mythicKeystoneDungeon` (added `getMythicKeystoneIndex`, `getMythicKeystoneDungeonsIndex`, `getMythicKeystoneDungeon`, `getMythicKeystoneSeasonsIndex`, `getMythicKeystoneSeason`)
  - `mythicKeystoneLeaderboard` (`getMythicKeystoneLeaderboardsIndex`, `getMythicKeystoneLeaderboard`)
  - `mythicRaidLeaderboard` (`getMythicRaidLeaderboard`)
- Added `ApiModel` base class (typed core fields + `raw` JSON map), `KeyedRef`, `MediaAsset`, `MediaResponse`, `SearchResponse`, `SearchResult`, and `BattleNetFaction`.
- Centralized `404` + `BLZWEBAPI00000404` → `BattleNetNotFoundException` handling in `doGet` and added optional `httpClient` injection to all clients.
- Deprecated `foreverStaticVersion` and `BattleNetNamespace.staticForeverItem` (to be removed in `0.5.0`).

## 0.4.0

- Added WoW: Forever API support:
  - `ForeverCharacterSlug` value object and `BattleNetNotFoundException` (`HTTP 404` / `BLZWEBAPI00000404`).
  - `BattleNetNamespace` additions: `profileForever`, `dynamicForever`, `staticForever`, `staticForeverItem`.
  - `ForeverCharacterClient` (13 character profile endpoints).
  - `ForeverAccountClient` (`getForeverAccountProfile`).
  - `ForeverItemClient` (`getItemData`).
  - `ForeverRulesetClient` (`getForeverRulesetIndex`, `getForeverRuleset`, `getForeverRulesetAuctions` with client-side pagination).
- Added `refreshAccessToken` to `OauthClient` and `BattleNet` facade.

## 0.3.0

* Increased unit and integration test coverage for OAuth, connected realm models, logger, and WoW game data models.
* Added CI/CD pipeline check for 90% code coverage, failing the build if coverage drops below this threshold.
* Integrated Codecov for continuous code coverage reporting and added Codecov badge to README.md.
* Dependencies upgraded.
* Implemented Mythic Keystone Periods Index API.
* Implemented Mythic Keystone Period API.
* Implemented Mythic Keystone Affixes Index API.
* Implemented Mythic Keystone Affix API.
* Implemented Mythic Keystone Affix Media API.

## 0.2.0

* Remove CN region (breaking change)
* Update documentation

## 0.1.3+2

* Connection timeout parameter

## 0.1.3+1

* battle_net_scope.dart exported

## 0.1.3

* build authorization uri
* post authorization code
* post token validation
* get user info

## 0.1.2

* Test coverage increased
* Documentation examples extended
* README.md update
* Dependencies update

## 0.1.1

* Models unified
* Logger implementation 
* Classic realms tests added
* Get connected realm search feature implementation 
* Get connected realm feature implementation
* Tests folder fix
* PostClientCredentials authorization refactor
* README.md update

## 0.1.0

* Post Client Credentials implementation
* Get Token Index implementation
* Initial project setup
