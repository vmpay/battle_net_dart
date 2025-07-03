// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import 'log_level.dart';

/// A utility class for logging Battle.net API communication.
///
/// This class provides static methods to initialize logging parameters and to
/// log messages, HTTP requests, and HTTP responses based on the configured
/// [LogLevel] and whether release logging is enabled.
class Logger {
  static late LogLevel _logLevel;
  static late bool _enableReleaseLogging;

  /// Initializes the [Logger] with the specified [logLevel] and [enableReleaseLogging] parameters.
  ///
  /// This method should be called at least once before any logging operations are performed.
  ///
  /// [logLevel] determines the verbosity of the logs.
  /// [enableReleaseLogging] controls whether logs are displayed in release mode.
  static void init({
    required LogLevel logLevel,
    required bool enableReleaseLogging,
  }) {
    _logLevel = logLevel;
    _enableReleaseLogging = enableReleaseLogging;
  }

  /// Logs a custom message based on the global [_logLevel] and [_enableReleaseLogging] settings.
  ///
  /// If [_enableReleaseLogging] is `false`, logs are displayed only in debug mode using `developer.log()`.
  /// If [_enableReleaseLogging] is `true`, logs are displayed even in release mode using `print()`.
  /// The [level] parameter specifies the log level for the current message, which is compared
  /// against the configured [_logLevel] to determine if the message should be displayed.
  static void logMessage(String message, {LogLevel level = LogLevel.NONE}) {
    if (_logLevel == LogLevel.NONE) {
      return;
    }
    if (_enableReleaseLogging) {
      if (level.index <= _logLevel.index) {
        print('[${level.name.toUpperCase()}] battle.net: $message');
      }
    } else {
      if (level.index <= _logLevel.index) {
        developer.log('[${level.name.toUpperCase()}] battle.net: $message');
      }
    }
  }

  /// Logs an HTTP request based on the global [_logLevel] and [_enableReleaseLogging] settings.
  ///
  /// If [_enableReleaseLogging] is `false`, logs are displayed only in debug mode using `developer.log()`.
  /// If [_enableReleaseLogging] is `true`, logs are displayed even in release mode using `print()`.
  /// The verbosity of the request log (e.g., including headers or body) depends on the configured [_logLevel].
  ///
  /// [request] The HTTP request to be logged.
  static void logRequest({required http.Request request}) {
    if (_logLevel == LogLevel.NONE) {
      return;
    }
    if (_enableReleaseLogging) {
      print('battle.net: --> ${request.method} ${request.url}');
      if (_logLevel.index > LogLevel.BASIC.index) {
        request.headers.forEach((String key, String value) {
          print('battle.net: $key: $value');
        });
      }
      if (request.method == 'POST' && _logLevel == LogLevel.BODY) {
        print('battle.net: BODY: ${request.body}');
      }
      print(
        'battle.net: <-- END ${request.method} (${request.contentLength} bytes)',
      );
    } else {
      developer.log(
        '--> ${request.method} ${request.url}',
        name: 'battle.net',
        level: 800,
      );
      if (_logLevel.index > LogLevel.BASIC.index) {
        request.headers.forEach((String key, String value) {
          developer.log('$key $value', name: 'battle.net', level: 800);
        });
      }
      if (request.method == 'POST' && _logLevel == LogLevel.BODY) {
        developer.log('BODY: ${request.body}', name: 'battle.net', level: 800);
      }
      developer.log(
        '--> END ${request.method} (${request.contentLength} bytes)',
        name: 'battle.net',
        level: 800,
      );
    }
  }

  /// Logs an HTTP response based on the global [_logLevel] and [_enableReleaseLogging] settings.
  ///
  /// If [_enableReleaseLogging] is `false`, logs are displayed only in debug mode using `developer.log()`.
  /// If [_enableReleaseLogging] is `true`, logs are displayed even in release mode using `print()`.
  /// The verbosity of the response log (e.g., including headers or body) depends on the configured [_logLevel].
  /// Error responses are specifically highlighted.
  ///
  /// [response] The HTTP streamed response to be logged.
  /// [body] Optional. The body of the HTTP response, if available.
  static void logResponse({
    required http.StreamedResponse response,
    String? body,
  }) {
    if (_logLevel == LogLevel.NONE) {
      return;
    }
    if (_enableReleaseLogging) {
      print('battle.net: <-- ${response.statusCode} ${response.request?.url}');
      if (_logLevel.index > LogLevel.BASIC.index) {
        response.headers.forEach((String key, String value) {
          print('battle.net: $key: $value');
        });
      }
      if (response.statusCode == 200) {
        if (body != null && _logLevel == LogLevel.BODY) {
          print('battle.net: BODY: $body');
        }
      } else {
        print('battle.net: ERROR: ${response.reasonPhrase}');
      }
      print('battle.net: <-- END (${body?.length ?? 0} symbols)');
    } else {
      developer.log(
        '--> ${response.statusCode} ${response.request?.url}',
        name: 'battle.net',
        level: 800,
      );
      if (_logLevel.index > LogLevel.BASIC.index) {
        response.headers.forEach((String key, String value) {
          developer.log('$key $value', name: 'battle.net', level: 800);
        });
      }
      if (response.statusCode == 200) {
        if (body != null && _logLevel == LogLevel.BODY) {
          developer.log('BODY: $body', name: 'battle.net', level: 800);
        }
      } else {
        developer.log(
          'ERROR: ${response.reasonPhrase}',
          name: 'battle.net',
          level: 1000,
        );
      }
      developer.log(
        '--> END (${body?.length ?? 0} symbols)',
        name: 'battle.net',
        level: 800,
      );
    }
  }
}
