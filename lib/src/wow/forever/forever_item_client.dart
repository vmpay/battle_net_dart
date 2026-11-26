import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/exceptions/battle_net_not_found_exception.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:battle_net/src/wow/forever/models/forever_item_models.dart';
import 'package:http/http.dart' as http;

/// Client for WoW: Forever item data endpoints.
///
/// Uses the unversioned `static-forever-{region}` namespace for general item
/// lookups. For versioned static data, the caller may construct a custom
/// namespace string via [BattleNetNamespace.staticForever].
class ForeverItemClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  static const String _gameDataBasePath = '/data/wow';

  ForeverItemClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns item data for the given [itemId].
  ///
  /// Uses the unversioned `static-forever-{region}` namespace.
  /// Throws [BattleNetNotFoundException] if the item does not exist.
  Future<ForeverItemResponse> getItemData({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int itemId,
  }) async {
    try {
      return await doGet(
        client: _httpClient,
        connectionTimeout: _connectionTimeout,
        accessToken: accessToken,
        region: region,
        namespace: BattleNetNamespace.staticForeverItem,
        queryParameters: <String, String?>{'locale': locale.name},
        path: '$_gameDataBasePath/item/$itemId',
        parser: ForeverItemResponse.fromRawJson,
      );
    } on Exception catch (e) {
      final String msg = e.toString();
      if (msg.contains('404') && msg.contains('BLZWEBAPI00000404')) {
        throw BattleNetNotFoundException(
          url: '$_gameDataBasePath/item/$itemId',
          body: msg,
        );
      }
      rethrow;
    }
  }
}
