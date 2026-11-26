import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/models/common/api_model.dart';
import 'package:battle_net/src/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Base class for the grouped API clients exposed through `BattleNet.wow`.
abstract class ApiClient {
  /// Creates an [ApiClient].
  ///
  /// [connectionTimeout] is passed to every request. [client] is an optional
  /// HTTP client (useful for testing); defaults to a new [http.Client].
  ApiClient({required int connectionTimeout, http.Client? client})
    : _connectionTimeout = connectionTimeout,
      _httpClient = client ?? http.Client();

  final int _connectionTimeout;
  final http.Client _httpClient;

  /// Performs a GET request and converts the decoded JSON object with [parse].
  ///
  /// Throws `BattleNetNotFoundException` for `404` responses with the
  /// `BLZWEBAPI00000404` code, and an [Exception] for any other failure.
  @protected
  Future<T> get<T>({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetNamespace namespace,
    required BattleNetLocale locale,
    required String path,
    required T Function(Map<String, dynamic> json) parse,
    Map<String, String?>? query,
  }) => doGet<T>(
    client: _httpClient,
    connectionTimeout: _connectionTimeout,
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    path: path,
    queryParameters: <String, String?>{'locale': locale.name, ...?query},
    parser: (String body) => parse(ApiModel.decode(body)),
  );

  /// Builds the query parameters shared by all `/data/wow/search/*` endpoints.
  ///
  /// [filters] are passed as-is, for example `{'name.en_US': 'Thunderfury'}`
  /// or `{'id': '[1,100]'}`.
  @protected
  Map<String, String?> searchQuery({
    required String orderBy,
    required int page,
    int? pageSize,
    Map<String, String>? filters,
  }) => <String, String?>{
    ...?filters,
    'orderby': orderBy,
    '_page': '$page',
    if (pageSize != null) '_pageSize': '$pageSize',
  };
}
