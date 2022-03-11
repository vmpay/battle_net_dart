import 'package:battle_net/src/battle_net.dart';
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/client_credentials_response.dart';
import 'package:battle_net/src/models/token_index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get token', () async {
    final BattleNet battleNet = BattleNet('', '');
    final ClientCredentialsResponse response = await battleNet.postClientCredentials(BattleNetRegion.eu);
    final TokenIndex token = await battleNet.getTokenIndex(
        response.accessToken, BattleNetRegion.eu, BattleNetLocale.en_US);
    print(response);
    print(token);
  });
}
