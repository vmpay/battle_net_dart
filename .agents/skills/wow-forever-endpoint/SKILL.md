---
name: wow-forever-endpoint
description: Implements a new World of Warcraft Forever Battle.net API endpoint, DTO models, EU 404 exception handling, and unit tests in package:battle_net. Use when adding or updating Forever character, account, or static item endpoints.
---

# Add WoW: Forever Endpoint

Read `resources/forever-spec.md` first to verify the exact method signature, namespace, and path.

## Steps
1. **Check shared primitives**: Ensure `BattleNetNamespace` (`profileForever`, `dynamicForever`, `staticForever`), `ForeverCharacterSlug`, and `BattleNetNotFoundException` exist before adding endpoint methods.
2. **Model the response**: Add strongly typed, immutable DTOs matching existing serialization conventions in `lib/src/`. Make fields nullable where EU propagation delays occur (such as `character-media` or `equipment`).
3. **Implement the client method**:
   - Accept `ForeverCharacterSlug` (or `String slug`) and `BattleNetRegion`.
   - Build the URI using the matching `BattleNetNamespace` and `locale`.
   - Intercept HTTP 404 responses containing `BLZWEBAPI00000404` and throw `BattleNetNotFoundException`.
4. **Export public API**: Re-export new models, exceptions, and value objects from `lib/battle_net.dart`.
5. **Write unit tests**:
   - Add mocked HTTP client tests covering: `200 OK` parsing, `404 BLZWEBAPI00000404` throwing `BattleNetNotFoundException`, and generic `401`/`500` error handling.
   - Run `dart test` and confirm all tests pass.