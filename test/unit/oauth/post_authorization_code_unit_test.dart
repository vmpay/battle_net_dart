import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/oauth/models/authorization_code_response.dart';
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
      BattleNetScope.d3Profile,
    ],
    sub: '102517347',
    idToken: 'idToken',
  );
  group('AuthorizationCodeResponse', () {
    test('should create an instance from a JSON string', () {
      final AuthorizationCodeResponse
      actual = AuthorizationCodeResponse.fromRawJson(
        '{"access_token":"accessToken","token_type":"bearer","expires_in":86399,"scope":"wow.profile openid sc2.profile d3.profile","sub":"102517347","id_token":"idToken"}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"access_token":"accessToken","token_type":"bearer","expires_in":86399,"scope":"wow.profile openid sc2.profile d3.profile","sub":"102517347","id_token":"idToken"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final AuthorizationCodeResponse copied = expected.copyWith(
        accessToken: 'newAccessToken',
      );
      expect(copied.accessToken, equals('newAccessToken'));
      expect(copied.tokenType, equals(expected.tokenType));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'AuthorizationCodeResponse{accessToken: accessToken, tokenType: bearer, expiresIn: 86399, scope: [BattleNetScope.wowProfile, BattleNetScope.openid, BattleNetScope.sc2Profile, BattleNetScope.d3Profile], sub: 102517347, idToken: idToken}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const AuthorizationCodeResponse other = AuthorizationCodeResponse(
        accessToken: 'accessToken',
        tokenType: 'bearer',
        expiresIn: 86399,
        scope: <BattleNetScope>[
          BattleNetScope.wowProfile,
          BattleNetScope.openid,
          BattleNetScope.sc2Profile,
          BattleNetScope.d3Profile,
        ],
        sub: '102517347',
        idToken: 'idToken',
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
