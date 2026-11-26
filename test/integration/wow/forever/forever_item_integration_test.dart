import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import '../../credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
    clientId: clientId,
    clientSecret: clientSecret,
    logLevel: LogLevel.NONE,
    enableReleaseLogging: false,
  );

  group('Forever Item Integration Tests', () {
    test('getItemData - Thunderfury (19019) on EU', () async {
      final ClientCredentialsResponse creds = await battleNet
          .postClientCredentials();
      final ForeverItemResponse item = await battleNet.getItemData(
        accessToken: creds.accessToken,
        region: BattleNetRegion.eu,
        locale: BattleNetLocale.enGB,
        itemId: 19019,
      );
      expect(item.id, 19019);
      expect(item.name, isNotEmpty);
    });
  });
}
