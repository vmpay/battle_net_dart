---
name: wow-retail-game-data-endpoint
description: Implements a new World of Warcraft Retail Game Data API endpoint (static/dynamic namespace), DTO models, search API patterns, and unit tests in package:battle_net. Use when adding or updating Achievement, Auction House, Item, Realm, Profession, Mythic Keystone Leaderboard, PvP Season, Quest, Creature, Mount, Pet, Spell, Journal, Talent, Title, Toy, or any other WoW retail game-data endpoint.
---

# Add WoW Retail Game Data Endpoint

## 1. Determine the namespace and path

Before writing any code, confirm:
- **Namespace**: Is this endpoint `static` (rarely changes — items, achievements, spells, classes) or `dynamic` (changes with game state — realms, auctions, leaderboards, PvP seasons)?
- **Path prefix**: All game-data endpoints use `/data/wow/`.
- **Search variant**: Does this API support a search endpoint (`/data/wow/search/{resource}`)? If yes, add both the resource endpoint and the search endpoint.
- **Media variant**: Does this API expose a media endpoint (`/data/wow/media/{resource}/{id}`)? If yes, add it alongside the main endpoint.

### Namespace quick-reference

| Resource type | Namespace enum |
|---|---|
| Items, achievements, spells, creatures, classes, races, specs, professions, mounts, pets, talents, titles, toys, heirlooms, journal | `BattleNetNamespace.static` |
| Realms, connected realms, auctions, mythic leaderboards, PvP seasons, PvP leaderboards | `BattleNetNamespace.dynamic` |

## 2. File layout

Create files under `lib/src/wow/game/{resource_name}/`:
```
lib/src/wow/game/{resource_name}/
  {resource_name}_client.dart          # API calls
  models/
    {resource_name}_index_response.dart
    {resource_name}_response.dart
    {resource_name}_media_response.dart  # only if media endpoint exists
    # Additional DTOs as needed
```

Mirror the test structure under:
```
test/unit/wow/game/{resource_name}/
  {resource_name}_client_unit_test.dart
  models/
    {resource_name}_response_unit_test.dart
    # etc.
```

## 3. Implement the client

Copy the shape of `MythicKeystoneAffixClient` as your template:
- Constructor takes `int connectionTimeout` and optional `http.Client? client`.
- Store `final String _gameDataApiBasePath = '/data/wow';`
- Each method calls `doGet(...)` from `package:battle_net/src/utils/http_utils.dart`.
- Always pass `locale` as a query parameter when the endpoint uses a localised namespace.
- For index endpoints, the path is typically `'$_gameDataApiBasePath/{resource}/index'`.
- For detail endpoints: `'$_gameDataApiBasePath/{resource}/$id'`.
- For media endpoints: `'$_gameDataApiBasePath/media/{resource}/$id'`.
- For search endpoints: `'$_gameDataApiBasePath/search/{resource}'` with additional query params.

### Search endpoint pattern

```dart
Future<XSearchResponse> searchX({
  required String accessToken,
  required BattleNetRegion region,
  required BattleNetNamespace namespace,
  required BattleNetLocale locale,
  String orderBy = 'id:asc',
  int page = 1,
  int pageSize = 100,
  // resource-specific filter params (nullable)
}) async {
  final queryParams = <String, String?>{
    'locale': locale.name,
    'orderby': orderBy,
    '_page': '$page',
    '_pageSize': '$pageSize',
    // filter params omitted when null
  };
  return doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    queryParameters: queryParams,
    path: '$_gameDataApiBasePath/search/x',
    parser: XSearchResponse.fromRawJson,
  );
}
```

## 4. Model conventions

- Use `@immutable` from `package:meta`.
- All fields that may be absent in search/partial responses should be nullable.
- Provide a `factory fromJson(Map<String, dynamic> json)` and `factory fromRawJson(String str)`.
- Prefer plain `int`, `String`, `double`, `bool` for primitives; use typed sub-models for nested objects.
- Do **not** use `json_serializable` or code generation — this package is hand-written.

## 5. Wire up into BattleNet facade

In `lib/src/battle_net.dart`:
1. Add `late final XClient _xClient;` field.
2. Instantiate it in the constructor alongside the other clients.
3. Add a forwarding method with full dartdoc (`///`) matching the pattern of existing methods.

Export new models from `lib/battle_net.dart`.

## 6. Write unit tests

Each test file must cover:
1. **Happy path (200 OK)** — parse fixture JSON, assert key fields.
2. **Resource not found** — mock 404, expect `Exception` (or typed error if applicable).
3. **Unauthorized** — mock 401, expect `Exception`.

Use `package:http`'s `MockClient` (from `package:test`) for mocking.
Fixture JSON goes inline in the test (no external fixture files).

Run `dart test` and confirm all tests pass before marking done.

## 7. Checklist before PR

- [ ] `dart format --output=none --set-exit-if-changed .` passes
- [ ] `dart analyze --fatal-infos` passes
- [ ] `dart test --coverage=coverage` ≥ 90% overall coverage
- [ ] New models and client methods exported from `lib/battle_net.dart`
- [ ] `BattleNet` facade method added with dartdoc
