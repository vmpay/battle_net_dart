import 'package:battle_net/src/oauth/models/user_info_response.dart';
import 'package:test/test.dart';

void main() {
  const UserInfoResponse expected = UserInfoResponse(
    sub: '123456789',
    id: 123456789,
    battleTag: 'Andrew#1234',
  );
  group('UserInfoResponse', () {
    test('should create an instance from a JSON string', () {
      final UserInfoResponse actual = UserInfoResponse.fromRawJson(
        '{"sub":"123456789","id":123456789,"battletag":"Andrew#1234"}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals('{"sub":"123456789","id":123456789,"battletag":"Andrew#1234"}'),
      );
    });

    test('should return a copy with updated values', () {
      final UserInfoResponse copied = expected.copyWith(sub: 'newSub');
      expect(copied.sub, equals('newSub'));
      expect(copied.id, equals(expected.id));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'UserInfoResponse{sub: 123456789, id: 123456789, battleTag: Andrew#1234}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const UserInfoResponse other = UserInfoResponse(
        sub: '123456789',
        id: 123456789,
        battleTag: 'Andrew#1234',
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
