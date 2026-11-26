import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import '../../credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
    clientId: clientId,
    clientSecret: clientSecret,
    logLevel: LogLevel.NONE,
    enableReleaseLogging: false,
  );

  group('Forever Ruleset Integration Tests', () {
    test('getForeverRulesetIndex and getForeverRuleset on EU', () async {
      final ClientCredentialsResponse creds = await battleNet
          .postClientCredentials();
      final ForeverRulesetIndexResponse index = await battleNet
          .getForeverRulesetIndex(
            accessToken: creds.accessToken,
            region: BattleNetRegion.eu,
            locale: BattleNetLocale.enGB,
          );
      expect(index.rulesets, isNotEmpty);

      final int firstId = index.rulesets.first.id;
      final ForeverRulesetResponse ruleset = await battleNet.getForeverRuleset(
        accessToken: creds.accessToken,
        region: BattleNetRegion.eu,
        locale: BattleNetLocale.enGB,
        rulesetId: firstId,
      );
      expect(ruleset.id, firstId);
    });
  });
}
