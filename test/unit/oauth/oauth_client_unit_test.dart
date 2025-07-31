import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/oauth/models/authorization_code_response.dart';
import 'package:battle_net/src/oauth/models/check_token_response.dart';
import 'package:battle_net/src/oauth/models/client_credentials_response.dart';
import 'package:battle_net/src/oauth/models/user_info_response.dart';
import 'package:battle_net/src/oauth/oauth_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('OauthClient', () {
    late OauthClient oauthClient;
    late MockClient mockClient;

    const String auth = 'test_auth';
    const String clientId = 'test_client_id';
    const int connectionTimeout = 5000;

    setUp(() {
      Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
    });

    test('postClientCredentials - success', () async {
      mockClient = MockClient((http.Request request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), 'https://oauth.battle.net/oauth/token');
        expect(request.headers['Authorization'], 'Basic $auth');
        expect(
          request.headers['Content-Type'],
          'application/x-www-form-urlencoded',
        );
        expect(request.bodyFields['grant_type'], 'client_credentials');

        return http.Response(
          '{"access_token":"test_access_token","token_type":"bearer","expires_in":3600,"sub":"test_sub"}',
          200,
        );
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      final ClientCredentialsResponse response = await oauthClient
          .postClientCredentials();

      expect(response.accessToken, 'test_access_token');
      expect(response.tokenType, 'bearer');
      expect(response.expiresIn, 3600);
      expect(response.sub, 'test_sub');
    });

    test('postClientCredentials - error', () async {
      mockClient = MockClient((http.Request request) async {
        return http.Response('Error', 400);
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      expect(
        () => oauthClient.postClientCredentials(),
        throwsA(isA<Exception>()),
      );
    });

    test('buildAuthorizationUri', () {
      final Uri redirectUri = Uri.parse('http://localhost/callback');
      final List<BattleNetScope> scope = <BattleNetScope>[
        BattleNetScope.wowProfile,
        BattleNetScope.openid,
      ];

      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
      );

      final Uri uri = oauthClient.buildAuthorizationUri(
        redirectUri: redirectUri,
        scope: scope,
      );

      expect(uri.scheme, 'https');
      expect(uri.host, 'oauth.battle.net');
      expect(uri.path, '/authorize');
      expect(uri.queryParameters['response_type'], 'code');
      expect(uri.queryParameters['client_id'], clientId);
      expect(uri.queryParameters['redirect_uri'], redirectUri.toString());
      expect(uri.queryParameters['scope'], 'wow.profile openid ');
    });

    test('postAuthorizationCode - success', () async {
      mockClient = MockClient((http.Request request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), 'https://oauth.battle.net/oauth/token');
        expect(request.headers['Authorization'], 'Basic $auth');
        expect(
          request.headers['Content-Type'],
          'application/x-www-form-urlencoded',
        );
        expect(request.bodyFields['grant_type'], 'authorization_code');
        expect(request.bodyFields['redirect_uri'], 'http://localhost/callback');
        expect(request.bodyFields['code'], 'test_code');

        return http.Response(
          '{"access_token":"auth_access_token","token_type":"bearer","expires_in":3600,"scope":"wow.profile openid","sub":"test_sub","id_token":"test_id_token"}',
          200,
        );
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      final AuthorizationCodeResponse response = await oauthClient
          .postAuthorizationCode(
            redirectUri: Uri.parse('http://localhost/callback'),
            code: 'test_code',
          );

      expect(response.accessToken, 'auth_access_token');
      expect(response.tokenType, 'bearer');
      expect(response.expiresIn, 3600);
      expect(response.scope, <BattleNetScope>[
        BattleNetScope.wowProfile,
        BattleNetScope.openid,
      ]);
      expect(response.sub, 'test_sub');
      expect(response.idToken, 'test_id_token');
    });

    test('postAuthorizationCode - error', () async {
      mockClient = MockClient((http.Request request) async {
        return http.Response('Error', 400);
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      expect(
        () => oauthClient.postAuthorizationCode(
          redirectUri: Uri.parse('http://localhost/callback'),
          code: 'test_code',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('postTokenValidation - success', () async {
      mockClient = MockClient((http.Request request) async {
        expect(request.method, 'POST');
        expect(
          request.url.toString(),
          'https://oauth.battle.net/oauth/check_token',
        );
        expect(
          request.headers['Content-Type'],
          'application/x-www-form-urlencoded',
        );
        expect(request.bodyFields['token'], 'test_token');

        return http.Response(
          '{"user_name":"test_user","scope":["wow.profile","openid"],"account_authorities":[],"exp":1234567890,"client_authorities":[],"authorities":[],"client_id":"test_client_id"}',
          200,
        );
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      final CheckTokenResponse response = await oauthClient.postTokenValidation(
        token: 'test_token',
      );

      expect(response.userName, 'test_user');
      expect(response.scope, <BattleNetScope>[
        BattleNetScope.wowProfile,
        BattleNetScope.openid,
      ]);
      expect(response.exp, 1234567890);
      expect(response.clientId, 'test_client_id');
    });

    test('postTokenValidation - error', () async {
      mockClient = MockClient((http.Request request) async {
        return http.Response('Error', 400);
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      expect(
        () => oauthClient.postTokenValidation(token: 'test_token'),
        throwsA(isA<Exception>()),
      );
    });

    test('getUserInfo - success', () async {
      mockClient = MockClient((http.Request request) async {
        expect(request.method, 'GET');
        expect(request.url.toString(), 'https://eu.battle.net/oauth/userinfo');
        expect(request.headers['Authorization'], 'Bearer test_access_token');

        return http.Response(
          '{"sub":"test_sub","id":123,"battletag":"test_battletag"}',
          200,
        );
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      final UserInfoResponse response = await oauthClient.getUserInfo(
        accessToken: 'test_access_token',
      );

      expect(response.sub, 'test_sub');
      expect(response.id, 123);
      expect(response.battleTag, 'test_battletag');
    });

    test('getUserInfo - error', () async {
      mockClient = MockClient((http.Request request) async {
        return http.Response('Error', 400);
      });
      oauthClient = OauthClient(
        auth: auth,
        clientId: clientId,
        connectionTimeout: connectionTimeout,
        httpClient: mockClient,
      );

      expect(
        () => oauthClient.getUserInfo(accessToken: 'test_access_token'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
