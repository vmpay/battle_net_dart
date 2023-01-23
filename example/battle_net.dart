import 'package:battle_net/battle_net.dart';

/// This example shows how to fetch [TokenResponse] data with additional information
Future<void> main() async {
  /// Provide client id and client secret
  final BattleNet battleNet = BattleNet('clientId', 'clientSecret');

  /// Fetch access token providing region of the data to retrieve.
  final ClientCredentialsResponse clientCredentialsResponse =
      await battleNet.postClientCredentials();

  /// Fetch Token index price for EU region Retail version
  final TokenIndex tokenIndex = await battleNet.getTokenIndex(
      clientCredentialsResponse.accessToken,
      BattleNetRegion.eu,
      BattleNetNamespace.dynamic,
      BattleNetLocale.enGB);
  print(tokenIndex);
}
