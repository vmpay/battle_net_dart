import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/models/oauth/check_token_response.dart';
import 'package:test/test.dart';

void main() {
  const CheckTokenResponse expected = CheckTokenResponse(
    userName: '10247',
    scope: <BattleNetScope>[
      BattleNetScope.wowProfile,
      BattleNetScope.openid,
      BattleNetScope.sc2Profile,
      BattleNetScope.d3Profile,
    ],
    accountAuthorities: <String>[],
    exp: 1693607763,
    clientAuthorities: <String>[],
    authorities: <String>[
      'IS_AUTHENTICATED_FULLY',
      'ROLE_USER',
      '0FF5DB46-4098-A06C-BEA7D5A54707'
    ],
    clientId: 'clientId',
  );
  group('post check token mapping', () {
    test('check token response', () {
      final CheckTokenResponse actual = CheckTokenResponse.fromRawJson(
          '{"user_name":"10247","scope":["wow.profile","openid","sc2.profile","d3.profile"],"account_authorities":[],"exp":1693607763,"client_authorities":[],"authorities":["IS_AUTHENTICATED_FULLY","ROLE_USER","0FF5DB46-4098-A06C-BEA7D5A54707"],"client_id":"clientId"}');
      expect(actual, expected);
    });
  });
}
