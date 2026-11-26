import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:battle_net/src/wow/forever/models/forever_account_models.dart';
import 'package:http/http.dart' as http;

/// Client for WoW: Forever account profile endpoints.
///
/// All methods require a **user access token** with `wow.profile` scope
/// (obtained via the Authorization Code OAuth flow). They will return a
/// `401 Unauthorized` if called with a client-credentials token.
class ForeverAccountClient {
  final int _connectionTimeout;
  final http.Client _httpClient;

  ForeverAccountClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  /// Returns the WoW: Forever account profile summary.
  ///
  /// [accessToken] must be a **user token** with `wow.profile` scope.
  Future<ForeverAccountProfileResponse> getForeverAccountProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
  }) => doGet(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: BattleNetNamespace.profileForever,
    queryParameters: <String, String?>{'locale': locale.name},
    path: '/profile/user/wow',
    parser: ForeverAccountProfileResponse.fromRawJson,
  );
}
