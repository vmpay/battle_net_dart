/// Exception thrown when the Battle.net API returns a 404 response containing
/// the `BLZWEBAPI00000404` error code.
///
/// This is distinct from a generic HTTP 404 (which throws a plain [Exception]).
/// [BattleNetNotFoundException] is thrown specifically when the API body
/// contains `BLZWEBAPI00000404`, indicating a known "resource not found"
/// condition (e.g., a WoW: Forever character below level 10 or still online).
class BattleNetNotFoundException implements Exception {
  /// The URL that returned the 404.
  final String url;

  /// The raw response body from the API, if available.
  final String? body;

  /// Creates a [BattleNetNotFoundException].
  const BattleNetNotFoundException({required this.url, this.body});

  @override
  String toString() =>
      'BattleNetNotFoundException: Resource not found at $url'
      '${body != null ? ' — $body' : ''}';
}
