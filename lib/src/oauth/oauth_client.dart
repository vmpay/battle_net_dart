import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:http/http.dart' as http;

import 'models/authorization_code_response.dart';
import 'models/check_token_response.dart';
import 'models/client_credentials_response.dart';
import 'models/user_info_response.dart';

/// A client for interacting with the Battle.net OAuth API.
///
/// This class provides methods for handling OAuth authentication flows,
/// including client credentials, authorization code, token validation, and user info retrieval.
class OauthClient {
  final String _auth;
  final String _clientId;
  final int _connectionTimeout;
  final http.Client _httpClient;

  /// Creates an instance of [OauthClient].
  ///
  /// [auth] is the base64 encoded client ID and client secret.
  /// [clientId] is the Battle.net API client ID.
  /// [connectionTimeout] is the timeout duration for HTTP requests in milliseconds.
  /// [httpClient] an optional HTTP client for making requests. Defaults to a new [http.Client].
  OauthClient({
    required String auth,
    required String clientId,
    required int connectionTimeout,
    http.Client? httpClient,
  }) : _connectionTimeout = connectionTimeout,
       _auth = auth,
       _clientId = clientId,
       _httpClient = httpClient ?? http.Client();

  /// This is the only request necessary for the client credential flow,
  /// OAuth's authentication flow intended for application servers.
  ///
  /// Returns a [ClientCredentialsResponse] containing the access token.
  Future<ClientCredentialsResponse> postClientCredentials() async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $_auth',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('https://oauth.battle.net/oauth/token'),
    );
    request.bodyFields = <String, String>{'grant_type': 'client_credentials'};
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response = await _httpClient
        .send(request)
        .timeout(Duration(milliseconds: _connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final ClientCredentialsResponse clientCredentialsResponse =
          ClientCredentialsResponse.fromRawJson(body);
      return clientCredentialsResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Builds Authorization Request [Uri] with the provided parameters.
  ///
  /// [redirectUri] is the URI to which the user will be redirected after authorization.
  /// [scope] is a list of [BattleNetScope] values defining the requested permissions.
  ///
  /// Returns a [Uri] for the authorization request.
  Uri buildAuthorizationUri({
    required Uri redirectUri,
    required List<BattleNetScope> scope,
  }) {
    return Uri.parse(
      'https://oauth.battle.net/authorize'
      '?response_type=code'
      '&client_id=$_clientId'
      '&redirect_uri=$redirectUri'
      '&scope=${scope.fold('', (String previousValue, BattleNetScope element) => '$previousValue${element.name} ')}',
    );
  }

  /// The access token request is the second part of the authorization code flow.
  /// When the first part completes, the user's browser is redirected to
  /// an application's redirect_uri. This redirect URI also includes
  /// an access code and (optionally) a state parameter. This request allows
  /// the application to exchange the access code for an access token to can
  /// use in subsequent API requests.
  ///
  /// [redirectUri] is the URI to which the user was redirected after authorization.
  /// [code] is the authorization code received from the authorization server.
  ///
  /// Returns an [AuthorizationCodeResponse] containing the access token and other details.
  Future<AuthorizationCodeResponse> postAuthorizationCode({
    required Uri redirectUri,
    required String code,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Basic $_auth',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('https://oauth.battle.net/oauth/token'),
    );
    request.bodyFields = <String, String>{
      'grant_type': 'authorization_code',
      'redirect_uri': '$redirectUri',
      'code': code,
    };
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response = await _httpClient
        .send(request)
        .timeout(Duration(milliseconds: _connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final AuthorizationCodeResponse authorizationCodeResponse =
          AuthorizationCodeResponse.fromRawJson(body);
      return authorizationCodeResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Verifies that a given bearer token is valid and retrieves metadata
  /// about the token, including the client_id used to create the token,
  /// expiration timestamp, and scopes granted to the token.
  ///
  /// [token] is the bearer token to validate.
  ///
  /// Returns a [CheckTokenResponse] containing token metadata.
  Future<CheckTokenResponse> postTokenValidation({
    required String token,
  }) async {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final http.Request request = http.Request(
      'POST',
      Uri.parse('https://oauth.battle.net/oauth/check_token'),
    );
    request.bodyFields = <String, String>{'token': token};
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response = await _httpClient
        .send(request)
        .timeout(Duration(milliseconds: _connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final CheckTokenResponse checkTokenResponse =
          CheckTokenResponse.fromRawJson(body);
      return checkTokenResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }

  /// Returns basic information about the user associated with the current bearer token.
  ///
  /// [accessToken] is the access token for the user.
  ///
  /// Returns a [UserInfoResponse] containing user information.
  Future<UserInfoResponse> getUserInfo({required String accessToken}) async {
    final Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $accessToken',
    };
    final http.Request request = http.Request(
      'GET',
      Uri.parse('https://eu.battle.net/oauth/userinfo'),
    );
    request.headers.addAll(headers);

    Logger.logRequest(request: request);

    final http.StreamedResponse response = await _httpClient
        .send(request)
        .timeout(Duration(milliseconds: _connectionTimeout));

    if (response.statusCode == 200) {
      final String body = await response.stream.bytesToString();
      Logger.logResponse(response: response, body: body);
      final UserInfoResponse userInfoResponse = UserInfoResponse.fromRawJson(
        body,
      );
      return userInfoResponse;
    } else {
      Logger.logResponse(response: response);
      throw Exception(response.reasonPhrase);
    }
  }
}
