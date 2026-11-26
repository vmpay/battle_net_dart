---
name: battle-net-release-check
description: Verifies formatting, static analysis, unit tests, >=90% code coverage, and pub.dev release readiness for package:battle_net. Use before opening a PR or releasing version 0.4.0.
---

# battle_net Pre-PR & Release Check

Execute these checks in order and fix any failures before summarizing:

1. **Formatting**: Run `dart format --output=none --set-exit-if-changed .`
2. **Static analysis**: Run `dart analyze --fatal-infos`
3. **Tests & coverage**: Run `dart test --coverage=coverage` and verify overall line coverage is at least 90% (matching CI requirements).
4. **Public API & docs**:
   - Confirm all new Forever models, methods, and `BattleNetNotFoundException` are exported from `lib/battle_net.dart`.
   - Confirm `pubspec.yaml` version (`0.4.0`), `CHANGELOG.md`, and `README.md` usage examples reflect the new Forever endpoints.
5. **Dry-run publish**: Run `dart pub publish --dry-run` and report any pub points warnings.
6. **Pana scoring (optional)**: If running `pana` on a clean copy of the repo, remove the temporary copy directory immediately after capturing the score.