import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
      clientId: clientId,
      clientSecret: clientSecret,
      logLevel: LogLevel.BODY,
      enableReleaseLogging: false);

  test('postTokenValidation success', () async {
    final CheckTokenResponse response = await battleNet
        .postClientCredentials()
        .then((ClientCredentialsResponse response) =>
            battleNet.postTokenValidation(token: response.accessToken));
    assert(response.authorities.contains('ROLE_CLIENT'));
  });

  test('postTokenValidation fail', () async {
    expect(() => battleNet.postTokenValidation(token: ''),
        throwsA((Object e) => e is Exception));
  });
}
