import 'package:battle_net/battle_net.dart';

/// This example shows how to fetch [TokenResponse] data with additional information
Future<void> main() async {
  /// Provide client id and client secret
  final BattleNet battleNet =
      BattleNet(clientId: 'clientId', clientSecret: 'clientSecret');

  /// Fetch access token providing region of the data to retrieve.
  final ClientCredentialsResponse clientCredentialsResponse =
      await battleNet.postClientCredentials();

  /// Fetch Token index price for EU region Retail version
  final TokenIndexResponse tokenIndex = await battleNet.getTokenIndex(
      accessToken: clientCredentialsResponse.accessToken,
      region: BattleNetRegion.eu,
      namespace: BattleNetNamespace.dynamic,
      locale: BattleNetLocale.enGB);
  print(tokenIndex);

  /// Fetch connected 'Outland' realm details
  const int connectedRealmId = 1301;
  final ConnectedRealmSearchData connectedRealm =
      await battleNet.getConnectedRealm(
          accessToken: clientCredentialsResponse.accessToken,
          region: BattleNetRegion.eu,
          namespace: BattleNetNamespace.dynamic,
          id: connectedRealmId);
  print(connectedRealm);
}
