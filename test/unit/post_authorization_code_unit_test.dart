import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/models/oauth/authorization_code_response.dart';
import 'package:test/test.dart';

void main() {
  const AuthorizationCodeResponse expected = AuthorizationCodeResponse(
    accessToken: 'accessToken',
    tokenType: 'bearer',
    expiresIn: 86399,
    scope: <BattleNetScope>[
      BattleNetScope.wowProfile,
      BattleNetScope.openid,
      BattleNetScope.sc2Profile,
      BattleNetScope.d3Profile
    ],
    sub: '102517347',
    idToken: 'idToken',
  );
  group('post authorization code mapping', () {
    test('authorization code response', () {
      final AuthorizationCodeResponse actual =
          AuthorizationCodeResponse.fromRawJson(
              '{"access_token":"accessToken","token_type":"bearer","expires_in":86399,"scope":"wow.profile openid sc2.profile d3.profile","sub":"102517347","id_token":"idToken"}');
      expect(actual, expected);
    });
  });
}
