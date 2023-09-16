import 'package:battle_net/battle_net.dart';
import 'package:battle_net/src/models/realm/population_type_localised.dart';
import 'package:battle_net/src/models/realm/realm_localised.dart';
import 'package:battle_net/src/models/realm/server_status_localised.dart';

/// This example shows how to fetch [TokenResponse] data with additional information
Future<void> main() async {
  /// Provide client id and client secret
  final BattleNet battleNet =
      BattleNet(clientId: 'clientId', clientSecret: 'clientSecret');

  /// Fetch access token providing region of the data to retrieve
  final ClientCredentialsResponse clientCredentialsResponse =
      await battleNet.postClientCredentials();

  /// Verifies that a given bearer token is valid and retrieves metadata
  /// about the token
  final CheckTokenResponse checkTokenResponse = await battleNet
      .postTokenValidation(token: clientCredentialsResponse.accessToken);
  print(checkTokenResponse);

  /// Fetch Token index price for EU region Retail version
  final TokenIndexResponse tokenIndex = await battleNet.getTokenIndex(
      accessToken: clientCredentialsResponse.accessToken,
      region: BattleNetRegion.eu,
      namespace: BattleNetNamespace.dynamic,
      locale: BattleNetLocale.enGB);
  print(tokenIndex);

  /// Fetch Token index price for EU region Classic version
  final TokenIndexResponse tokenIndexClassic = await battleNet
      .postClientCredentials()
      .then((ClientCredentialsResponse response) => battleNet.getTokenIndex(
          accessToken: response.accessToken,
          region: BattleNetRegion.eu,
          namespace: BattleNetNamespace.dynamicClassic,
          locale: BattleNetLocale.enGB));
  print(tokenIndexClassic);

  /// Performs a search of connected realms
  final ConnectedRealmSearchResponse connectedRealmSearchResponse =
      await battleNet.postClientCredentials().then(
          (ClientCredentialsResponse value) =>
              battleNet.getConnectedRealmSearch(
                accessToken: value.accessToken,
                region: BattleNetRegion.eu,
                namespace: BattleNetNamespace.dynamicClassic,
                statusType: ServerStatus.UP,
                realmsTimezone: RealmTimezone.EUROPE_PARIS,
                hasQueue: false,
                populationType: PopulationType.FULL,
                realmsIsTournament: false,
              ));
  print(connectedRealmSearchResponse);

  /// Fetch connected 'Outland' realm details
  const int connectedRealmId = 1301;
  final ConnectedRealmSearchData connectedRealm =
      await battleNet.getConnectedRealm(
          accessToken: clientCredentialsResponse.accessToken,
          region: BattleNetRegion.eu,
          namespace: BattleNetNamespace.dynamic,
          id: connectedRealmId);
  print(connectedRealm);

  /// Authorization Code Flow
  /// Builds Authorization Request [Uri] with the provided parameters
  final Uri redirectUri = Uri.parse('https://localhost');
  final List<BattleNetScope> scope = <BattleNetScope>[
    BattleNetScope.openid,
    BattleNetScope.wowProfile,
  ];
  final Uri authorizationUri = battleNet.buildAuthorizationUri(
    redirectUri: redirectUri,
    scope: scope,
  );
  print(authorizationUri);

  /// Redirect user to authorizationUri and get the authorization code received
  /// from the authorization server
  const String code = 'auth_code';

  /// The access token request is the second part of the authorization code flow
  final AuthorizationCodeResponse authorizationCodeResponse = await battleNet
      .postAuthorizationCode(redirectUri: redirectUri, code: code);

  /// Returns basic information about the user associated with the current bearer token
  final UserInfoResponse userInfo = await battleNet.getUserInfo(
      accessToken: authorizationCodeResponse.accessToken);
  print(userInfo);
}
