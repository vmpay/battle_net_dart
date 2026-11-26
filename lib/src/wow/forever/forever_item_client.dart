import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/exceptions/battle_net_not_found_exception.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:battle_net/src/wow/forever/models/forever_item_models.dart';
import 'package:http/http.dart' as http;

/// Client for WoW: Forever item data endpoints.
///
/// Uses the `static-forever-{region}` namespace, which Blizzard resolves to
/// the current Forever game build.
class ForeverItemClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  static const String _gameDataBasePath = '/data/wow';

  ForeverItemClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns item data for the given [itemId].
  ///
  /// Throws [BattleNetNotFoundException] if the item does not exist.
  Future<ForeverItemResponse> getItemData({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemId,
  }) => doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.staticForever,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '$_gameDataBasePath/item/$itemId',
    parser: ForeverItemResponse.fromRawJson,
  );
}
