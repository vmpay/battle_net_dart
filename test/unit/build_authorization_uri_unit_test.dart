import 'package:battle_net/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:test/test.dart';

import '../integration/credentials.dart';

void main() {
  group('build authorization uri', () {
    test('build authorization uri', () {
      final Uri redirectUri = Uri.parse('https://localhost');
      final List<BattleNetScope> scope = <BattleNetScope>[
        BattleNetScope.openid,
        BattleNetScope.wowProfile,
      ];
      final Uri expected = Uri.parse(
        'https://oauth.battle.net/authorize'
        '?response_type=code'
        '&client_id=$clientId'
        '&redirect_uri=$redirectUri'
        '&scope=${BattleNetScope.openid.name} ${BattleNetScope.wowProfile.name} ',
      );
      final BattleNet battleNet = BattleNet(
        clientId: clientId,
        clientSecret: clientSecret,
        logLevel: LogLevel.BODY,
        enableReleaseLogging: false,
      );
      final Uri actual = battleNet.buildAuthorizationUri(
        redirectUri: redirectUri,
        scope: scope,
      );
      expect(actual, expected);
    });
  });
}
