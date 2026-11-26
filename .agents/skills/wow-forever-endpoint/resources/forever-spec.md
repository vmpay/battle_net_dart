# package:battle_net 0.4.0 — WoW: Forever Specification

## 1. Value Objects & Errors
- `ForeverCharacterSlug(String name, String surname)` -> `${name.toLowerCase()}-${surname.toLowerCase()}`
- `BattleNetNotFoundException` for HTTP 404 (`BLZWEBAPI00000404`)

> **Note:** Characters only appear in the API from level 10+ and only after the character has fully logged out of the game client. Any endpoint below may return a 404 for newly created or online characters — throw `BattleNetNotFoundException` for all such cases.

## 2. Namespaces (`BattleNetNamespace`)
- `profileForever` -> `profile-forever-{region}`
- `dynamicForever` -> `dynamic-forever-{region}`
- `staticForever` -> `static-{version}-forever-{region}` where `version` defaults to `1.60.1_70399` (configurable per `BattleNet` constructor or per-call parameter)
- `staticForeverItem` -> `static-forever-{region}` (unversioned; for item lookups only)

## 3. Required Methods

### Profile — Character (namespace: `profileForever`)
All character endpoints use `ForeverCharacterSlug` to build the path `{name}-{surname}`.

| Method | Path |
|---|---|
| `getForeverCharacterProfile` | `/profile/wow/character/{slug}` |
| `getForeverCharacterEquipment` | `/profile/wow/character/{slug}/equipment` |
| `getForeverCharacterMedia` | `/profile/wow/character/{slug}/character-media` |
| `getForeverCharacterStatistics` | `/profile/wow/character/{slug}/achievements/statistics` |
| `getForeverCharacterAchievements` | `/profile/wow/character/{slug}/achievements` *(added)* |
| `getForeverCharacterDungeonEncounters` | `/profile/wow/character/{slug}/encounters/dungeons` |
| `getForeverCharacterPvpSummary` | `/profile/wow/character/{slug}/pvp-summary` |
| `getForeverCharacterCompletedQuests` | `/profile/wow/character/{slug}/quests/completed` |
| `getForeverCharacterReputations` | `/profile/wow/character/{slug}/reputations` |
| `getForeverCharacterProfessions` | `/profile/wow/character/{slug}/professions` |
| `getForeverCharacterSpecializations` | `/profile/wow/character/{slug}/specializations` *(added)* |
| `getForeverCharacterTitles` | `/profile/wow/character/{slug}/titles` *(added)* |
| `getForeverCharacterCollections` | `/profile/wow/character/{slug}/collections` *(added — mounts & pets summary)* |

**Nullable caution:** `getForeverCharacterMedia` and `getForeverCharacterEquipment` may return `404` during EU propagation delays even for valid characters — keep response wrappers nullable and throw `BattleNetNotFoundException` on `BLZWEBAPI00000404`.

### Profile — Account (namespace: `profileForever`, requires user token with `wow.profile` scope)

| Method | Notes |
|---|---|
| `getForeverAccountProfile` | `GET /profile/user/wow` |
| `refreshAccessToken(String refreshToken)` | On `OauthClient`; exchanges refresh token for new access token |

### Game Data — Items (namespace: `staticForeverItem`)

| Method | Path |
|---|---|
| `getItemData(int itemId)` | `/data/wow/item/{itemId}` |

### Game Data — Rulesets (namespace: `dynamicForever`)
*New — WoW: Forever replaces connected realms with rulesets.*

| Method | Path | Notes |
|---|---|---|
| `getForeverRulesetIndex` | `/data/wow/ruleset/index` | Index of all active Forever rulesets |
| `getForeverRuleset(int rulesetId)` | `/data/wow/ruleset/{rulesetId}` | Ruleset details (server population, name) |
| `getForeverRulesetAuctions(int rulesetId)` | `/data/wow/ruleset/{rulesetId}/auctions/index` | Auction house data; replaces connected-realm auctions |

## 4. Nullable & EU-rollout fields

Fields that may legitimately be missing before EU data propagation and must be declared nullable:
- `ForeverCharacterEquipmentResponse.equippedItems`
- `ForeverCharacterMediaResponse.assets`
- `ForeverCharacterCollectionsResponse.mounts`
- `ForeverCharacterCollectionsResponse.pets`