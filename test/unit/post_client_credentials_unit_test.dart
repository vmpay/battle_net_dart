import 'package:battle_net/src/models/oauth/client_credentials_response.dart';
import 'package:test/test.dart';

void main() {
  const ClientCredentialsResponse expected = ClientCredentialsResponse(
      accessToken: 'EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi',
      tokenType: 'bearer',
      expiresIn: 86399,
      sub: 'c310425efb0c482eadb727c715411fc4');
  group('post client credentials mapping', () {
    test('client credentials response', () {
      final ClientCredentialsResponse actual =
          ClientCredentialsResponse.fromRawJson(
              '{"access_token": "EULcAUncMAQQWA3vsadpJNO8IYFGRMr3LXi","token_type": "bearer","expires_in": 86399,"sub": "c310425efb0c482eadb727c715411fc4"}');
      expect(actual, expected);
    });
  });
}
