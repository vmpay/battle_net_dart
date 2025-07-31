import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/oauth/models/check_token_response.dart';
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
      '0FF5DB46-4098-A06C-BEA7D5A54707',
    ],
    clientId: 'clientId',
  );
  group('CheckTokenResponse', () {
    test('should create an instance from a JSON string', () {
      final CheckTokenResponse actual = CheckTokenResponse.fromRawJson(
        '{"user_name":"10247","scope":["wow.profile","openid","sc2.profile","d3.profile"],"account_authorities":[],"exp":1693607763,"client_authorities":[],"authorities":["IS_AUTHENTICATED_FULLY","ROLE_USER","0FF5DB46-4098-A06C-BEA7D5A54707"],"client_id":"clientId"}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"user_name":"10247","scope":["wow.profile","openid","sc2.profile","d3.profile"],"account_authorities":[],"exp":1693607763,"client_authorities":[],"authorities":["IS_AUTHENTICATED_FULLY","ROLE_USER","0FF5DB46-4098-A06C-BEA7D5A54707"],"client_id":"clientId"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final CheckTokenResponse copied = expected.copyWith(
        userName: 'newUserName',
      );
      expect(copied.userName, equals('newUserName'));
      expect(copied.clientId, equals(expected.clientId));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'CheckTokenResponse{userName: 10247, scope: [BattleNetScope.wowProfile, BattleNetScope.openid, BattleNetScope.sc2Profile, BattleNetScope.d3Profile], accountAuthorities: [], exp: 1693607763, clientAuthorities: [], authorities: [IS_AUTHENTICATED_FULLY, ROLE_USER, 0FF5DB46-4098-A06C-BEA7D5A54707], clientId: clientId}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const CheckTokenResponse other = CheckTokenResponse(
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
          '0FF5DB46-4098-A06C-BEA7D5A54707',
        ],
        clientId: 'clientId',
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
