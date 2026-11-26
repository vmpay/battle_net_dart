# battle_net Dart Package Rules

## Architecture & Compatibility
- Keep `package:battle_net` **pure Dart** (`collection`, `http`, `meta`). Never add Flutter SDK or Firebase dependencies—this package is shared by both the Flutter app and Firebase Dart Functions.
- Keep scope strictly to the Battle.net API. Do **not** add Warcraft Logs GraphQL code here (that lives in the backend functions package).

## WoW: Forever Conventions
- Forever endpoints are **realmless**: identify characters with `ForeverCharacterSlug` (`{name}-{surname}` lowercase), never a `realmSlug`.
- Route Forever calls through `BattleNetNamespace`:
  - `profileForever`: `profile-forever-{region}`
  - `dynamicForever`: `dynamic-forever-{region}`
  - `staticForever`: `static-1.60.1_70399-forever-{region}` (and `static-forever-{region}` for item lookups)
- Handle EU rollout 404s (`HTTP 404` with `BLZWEBAPI00000404`) by throwing a typed `BattleNetNotFoundException` rather than an unhandled error. Return nullable wrappers where media or equipment may still be propagating.

## Quality Bar
- CI enforces a **minimum 90% test coverage**. Every new method, model, and error branch must ship with mocked `package:http` unit tests.
- Follow existing code style, `dart format`, and zero warnings from `dart analyze`.