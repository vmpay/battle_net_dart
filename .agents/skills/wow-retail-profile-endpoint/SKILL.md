---
name: wow-retail-profile-endpoint
description: Implements a new World of Warcraft Retail Profile API endpoint (profile namespace, realm-slug + character-name routing), DTO models, auth scope notes, and unit tests in package:battle_net. Use when adding or updating character achievements, appearance, collections, encounters, equipment, hunter pets, media, mythic keystone profile, professions, PvP, quests, reputations, soulbinds, specializations, statistics, titles, account profile, or guild endpoints.
---

# Add WoW Retail Profile Endpoint

## 1. Identify the endpoint type

Profile endpoints split into three routing families:

| Family | URL pattern | Auth required |
|---|---|---|
| **Character** | `/profile/wow/character/{realmSlug}/{characterName}/{sub-resource}` | Client credentials (most); user token for some |
| **Account** | `/profile/user/wow` and sub-resources | ✅ User token (`wow.profile` scope, Authorization Code flow) |
| **Guild** | `/data/wow/guild/{realmSlug}/{guildSlug}/{sub-resource}` | Client credentials |

> [!IMPORTANT]
> Account Profile endpoints (`/profile/user/wow`) require a **user access token** (Authorization Code flow, `wow.profile` scope), not a client-credentials token. Character and Guild endpoints accept client credentials.

## 2. Namespace

All retail profile endpoints use **`BattleNetNamespace.profile`** → `profile-{region}`.

```dart
namespace: BattleNetNamespace.profile
```

## 3. File layout

Create files under `lib/src/wow/profile/{resource_name}/`:
```
lib/src/wow/profile/{resource_name}/
  {resource_name}_client.dart
  models/
    {resource_name}_response.dart
    # Additional DTOs as needed
```

Mirror under test:
```
test/unit/wow/profile/{resource_name}/
  {resource_name}_client_unit_test.dart
  models/
    {resource_name}_response_unit_test.dart
```

## 4. Character endpoint implementation pattern

```dart
Future<XResponse> getCharacterX({
  required String accessToken,
  required BattleNetRegion region,
  required BattleNetNamespace namespace,  // BattleNetNamespace.profile
  required BattleNetLocale locale,
  required String realmSlug,
  required String characterName,          // already lowercase per API convention
}) async {
  return doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: {'locale': locale.name},
    path: '/profile/wow/character/$realmSlug/${characterName.toLowerCase()}/x',
    parser: XResponse.fromRawJson,
  );
}
```

Key rules:
- `characterName` must be **lowercased** before embedding in the URL.
- Do **not** use `ForeverCharacterSlug` — retail characters are identified by `realmSlug` + `characterName`, not a first/surname slug.
- Some endpoints return a `profile-status` or `last-login-timestamp`; treat these as separate methods.

## 5. Account Profile endpoint pattern

```dart
// accessToken must be a USER token (wow.profile scope), not client credentials
Future<AccountProfileResponse> getAccountProfile({
  required String accessToken,
  required BattleNetRegion region,
  required BattleNetNamespace namespace,  // BattleNetNamespace.profile
  required BattleNetLocale locale,
}) async {
  return doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: {'locale': locale.name},
    path: '/profile/user/wow',
    parser: AccountProfileResponse.fromRawJson,
  );
}
```

## 6. Guild endpoint pattern

```dart
Future<GuildResponse> getGuild({
  required String accessToken,
  required BattleNetRegion region,
  required BattleNetNamespace namespace,  // BattleNetNamespace.profile
  required BattleNetLocale locale,
  required String realmSlug,
  required String guildSlug,
}) async {
  return doGet(
    ...
    path: '/data/wow/guild/$realmSlug/${guildSlug.toLowerCase()}',
    parser: GuildResponse.fromRawJson,
  );
}
```

## 7. Model conventions

Same as game-data endpoints:
- `@immutable` from `package:meta`.
- Nullable fields for data that may not be present (e.g., `activeTitle`, `gender`).
- `factory fromJson(Map<String, dynamic> json)` and `factory fromRawJson(String str)`.
- No code generation.

## 8. Wire up into BattleNet facade

In `lib/src/battle_net.dart`:
1. Add `late final XProfileClient _xProfileClient;` field.
2. Instantiate in constructor.
3. Add forwarding method with full dartdoc, documenting the `namespace` should be `BattleNetNamespace.profile` and noting if a user token is required.

Export new models from `lib/battle_net.dart`.

## 9. Write unit tests

Each test file must cover:
1. **Happy path (200 OK)** — parse fixture JSON, assert key fields.
2. **Character/resource not found (404)** — expect `Exception`.
3. **Unauthorized (401)** — expect `Exception`.
4. For account endpoints: add a note in the test that the token must have `wow.profile` scope.

Run `dart test` and confirm all tests pass.

## 10. Checklist before PR

- [ ] `dart format --output=none --set-exit-if-changed .` passes
- [ ] `dart analyze --fatal-infos` passes
- [ ] `dart test --coverage=coverage` ≥ 90% overall coverage
- [ ] New models exported from `lib/battle_net.dart`
- [ ] `BattleNet` facade method has dartdoc noting auth requirements
- [ ] Account-only endpoints clearly note `wow.profile` scope in docstring
