import 'package:battle_net/battle_net.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/oauth/oauth_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('OauthClient.refreshAccessToken Unit Tests', () {
    setUp(() {
      Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
    });

    test('refreshAccessToken - 200 OK', () async {
      final OauthClient client = OauthClient(
        auth: 'dGVzdDpzZWNyZXQ=',
        clientId: 'test',
        connectionTimeout: 5000,
        httpClient: MockClient((http.Request req) async {
          expect(req.method, 'POST');
          expect(req.url.toString(), 'https://oauth.battle.net/oauth/token');
          expect(req.bodyFields['grant_type'], 'refresh_token');
          expect(req.bodyFields['refresh_token'], 'my_refresh_token');
          return http.Response(
            '{"access_token":"new_token","token_type":"bearer","expires_in":86399,"scope":"wow.profile","sub":"123456","id_token":"dummy"}',
            200,
          );
        }),
      );

      final AuthorizationCodeResponse res = await client.refreshAccessToken(
        refreshToken: 'my_refresh_token',
      );
      expect(res.accessToken, 'new_token');
      expect(res.scope, <BattleNetScope>[BattleNetScope.wowProfile]);
    });

    test('refreshAccessToken - 400 throws Exception', () async {
      final OauthClient client = OauthClient(
        auth: 'dGVzdDpzZWNyZXQ=',
        clientId: 'test',
        connectionTimeout: 5000,
        httpClient: MockClient((_) async => http.Response('Bad Request', 400)),
      );

      expect(
        () => client.refreshAccessToken(refreshToken: 'invalid'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
