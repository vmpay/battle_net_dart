/// Defines the logging levels for the Battle.net API client.
///
/// These levels control the verbosity of the logs, from displaying nothing
/// to showing full request and response bodies.
enum LogLevel {
  /// No logging is displayed.
  NONE,

  /// Displays only URIs.
  BASIC,

  /// Displays URIs and headers.
  HEADERS,

  /// Displays URIs, headers, and request/response bodies.
  BODY,
}
