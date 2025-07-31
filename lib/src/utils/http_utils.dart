// In your http_utils.dart (or wherever doGet is defined)
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:http/http.dart' as http;

/// Returns the base URL for Battle.net API requests based on the provided [region].
///
/// [region] The Battle.net region (e.g., [BattleNetRegion.us], [BattleNetRegion.eu]).
///
/// Returns a [String] representing the base URL.
String getBattleNetBaseUrl(BattleNetRegion region) {
  return '${region.slug}.api.blizzard.com';
}

/// Performs a GET request to the Battle.net API.
///
/// [client] The HTTP client to use for the request.
/// [connectionTimeout] The timeout duration for the request in seconds.
/// [accessToken] The access token for authentication.
/// [region] The Battle.net region for the request.
/// [namespace] The Battle.net namespace for the request.
/// [path] The API endpoint path.
/// [queryParameters] Optional query parameters for the request.
/// [parser] A function to parse the JSON response body into the desired type [T].
///
/// Returns a [Future] that completes with the parsed response of type [T].
///
/// Throws an [Exception] if the HTTP request fails or returns a non-2xx status code.
Future<T> doGet<T>({
  required http.Client client,
  required int connectionTimeout,
  required String accessToken,
  required BattleNetRegion region,
  required BattleNetNamespace namespace,
  required String path,
  Map<String, String?>? queryParameters,
  required T Function(String) parser,
}) async {
  final String baseUrl = getBattleNetBaseUrl(region);

  // Start with a copy of the provided query parameters or an empty map
  final Map<String, String?> allQueryParams = Map<String, String?>.from(
    queryParameters ?? <String, String?>{},
  );

  // Add the mandatory namespace parameter
  // The format is typically 'namespace-region', e.g., 'static-us' or 'dynamic-eu'
  allQueryParams['namespace'] =
      '${namespace.name}-${region.slug.toLowerCase()}'; // Ensure region is lowercase if API expects e.g. 'us', 'eu'

  // The 'locale' should now be passed within the queryParameters map by the caller if needed.
  // Example: queryParameters: {'locale': BattleNetLocale.enUS.name, 'other_param': 'value'}

  // Remove any entries with null values before building the URI
  allQueryParams.removeWhere((String key, String? value) => value == null);

  // Ensure all values are strings for Uri.https
  final Map<String, String> finalQueryParams = allQueryParams
      .cast<String, String>();

  final Uri uri = Uri.https(
    baseUrl,
    path,
    finalQueryParams.isEmpty ? null : finalQueryParams,
  );

  try {
    final http.Response response = await client
        .get(
          uri,
          headers: <String, String>{
            'Authorization': 'Bearer $accessToken',
            // Add any other standard headers, e.g., 'Battlenet-Namespace' if needed separately,
            // though it's often part of query params for data APIs.
            // For WoW Game Data APIs, 'namespace' is usually a query parameter.
          },
        )
        .timeout(Duration(seconds: connectionTimeout));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parser(response.body);
    } else {
      // Handle errors appropriately
      throw Exception(
        'Failed to load data from $uri: ${response.statusCode} ${response.reasonPhrase}\nBody: ${response.body}',
      );
    }
  } catch (e) {
    // Handle network errors or timeouts
    throw Exception('Error during HTTP request to $uri: $e');
  }
}
