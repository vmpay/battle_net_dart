// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import 'log_level.dart';

/// Logger allows to display communication API  logs
class Logger {
  static late LogLevel _logLevel;
  static late bool _enableReleaseLogging;

  /// Initialize [logLevel] and [enableReleaseLogging] parameters.
  /// Should be called at least once
  static void init(
      {required LogLevel logLevel, required bool enableReleaseLogging}) {
    _logLevel = logLevel;
    _enableReleaseLogging = enableReleaseLogging;
  }

  /// Logs request using global parameters [_logLevel] and [_enableReleaseLogging].
  /// if [_enableReleaseLogging] is false displays logs only in debug mode using
  /// developer.log()
  /// if [_enableReleaseLogging] is true displays logs even in release mode using
  /// print() statement
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
          'battle.net: <-- END ${request.method} (${request.contentLength} bytes)');
    } else {
      developer.log('--> ${request.method} ${request.url}',
          name: 'battle.net', level: 800);
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
          level: 800);
    }
  }

  /// Logs response using global parameters [_logLevel] and [_enableReleaseLogging].
  /// if [_enableReleaseLogging] is false displays logs only in debug mode using
  /// developer.log()
  /// if [_enableReleaseLogging] is true displays logs even in release mode using
  /// print() statement
  static void logResponse(
      {required http.StreamedResponse response, String? body}) {
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
      developer.log('--> ${response.statusCode} ${response.request?.url}',
          name: 'battle.net', level: 800);
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
        developer.log('ERROR: ${response.reasonPhrase}',
            name: 'battle.net', level: 1000);
      }
      developer.log('--> END (${body?.length ?? 0} symbols)',
          name: 'battle.net', level: 800);
    }
  }
}
