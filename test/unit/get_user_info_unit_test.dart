import 'package:battle_net/src/models/oauth/user_info_response.dart';
import 'package:test/test.dart';

void main() {
  const UserInfoResponse expected = UserInfoResponse(
    sub: '123456789',
    id: 123456789,
    battleTag: 'Andrew#1234',
  );
  group('user info mapping', () {
    test('user info response', () {
      final UserInfoResponse actual = UserInfoResponse.fromRawJson(
          '{"sub":"123456789","id":123456789,"battletag":"Andrew#1234"}');
      expect(actual, expected);
    });
  });
}
