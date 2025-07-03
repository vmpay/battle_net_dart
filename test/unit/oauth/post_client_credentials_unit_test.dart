import 'package:battle_net/src/oauth/models/client_credentials_response.dart';
import 'package:test/test.dart';

void main() {
  const ClientCredentialsResponse expected = ClientCredentialsResponse(
    accessToken: 'EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi',
    tokenType: 'bearer',
    expiresIn: 86399,
    sub: 'c310425efb0c482eadb727c715411fc4',
  );
  group('ClientCredentialsResponse', () {
    test('should create an instance from a JSON string', () {
      final ClientCredentialsResponse
      actual = ClientCredentialsResponse.fromRawJson(
        '{"access_token": "EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi","token_type": "bearer","expires_in": 86399,"sub": "c310425efb0c482eadb727c715411fc4"}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"access_token":"EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi","token_type":"bearer","expires_in":86399,"sub":"c310425efb0c482eadb727c715411fc4"}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final ClientCredentialsResponse copied = expected.copyWith(
        accessToken: 'newAccessToken',
      );
      expect(copied.accessToken, equals('newAccessToken'));
      expect(copied.tokenType, equals(expected.tokenType));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'ClientCredentialsResponse{accessToken: EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi, tokenType: bearer, expiresIn: 86399, sub: c310425efb0c482eadb727c715411fc4}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const ClientCredentialsResponse other = ClientCredentialsResponse(
        accessToken: 'EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi',
        tokenType: 'bearer',
        expiresIn: 86399,
        sub: 'c310425efb0c482eadb727c715411fc4',
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
