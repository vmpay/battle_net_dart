import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import 'credentials.dart';

void main() {
  test('postClientCredentials success', () async {
    final BattleNet battleNet = BattleNet(
        clientId: clientId,
        clientSecret: clientSecret,
        logLevel: LogLevel.BODY,
        enableReleaseLogging: false);
    final ClientCredentialsResponse response =
        await battleNet.postClientCredentials();
    assert(response.accessToken.isNotEmpty);
  });

  test('postClientCredentials fail', () async {
    final BattleNet battleNet = BattleNet(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
        logLevel: LogLevel.BODY,
        enableReleaseLogging: false);
    expect(() => battleNet.postClientCredentials(),
        throwsA((Object e) => e is Exception));
  });
}
