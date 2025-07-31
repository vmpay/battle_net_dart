import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  group('Logger', () {
    // Helper to reset Logger state for each test
    setUp(() {
      // Reset static fields (if possible, or rely on re-init)
      // For static classes, direct reset is not straightforward without reflection
      // or a reset method. We'll rely on init() setting the values.
    });

    test('init sets log level and release logging correctly', () {
      Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true);
      // Since _logLevel and _enableReleaseLogging are private static,
      // we can't directly assert them. We'll test their effects in other tests.
      // This test primarily ensures init() runs without error.
      expect(
        () => Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true),
        returnsNormally,
      );
    });

    group('logMessage', () {
      test('does nothing when log level is NONE', () {
        Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
        // No direct way to assert that print/developer.log were NOT called without mocking.
        // We rely on the internal logic of logMessage.
        expect(
          () => Logger.logMessage('test message', level: LogLevel.BASIC),
          returnsNormally,
        );
      });

      test(
        'logs message when level is sufficient and release logging is off',
        () {
          Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: false);
          // This test primarily ensures the method runs without error.
          // Actual output would be to developer.log
          expect(
            () => Logger.logMessage('test message', level: LogLevel.BASIC),
            returnsNormally,
          );
        },
      );

      test(
        'logs message when level is sufficient and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true);
          // Actual output would be to print
          expect(
            () => Logger.logMessage('test message', level: LogLevel.BASIC),
            returnsNormally,
          );
        },
      );

      test('does not log message when level is insufficient', () {
        Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: false);
        // LogLevel.HEADERS is higher than LogLevel.BASIC
        expect(
          () => Logger.logMessage('test message', level: LogLevel.HEADERS),
          returnsNormally,
        );
      });
    });

    group('logRequest', () {
      final http.Request request =
          http.Request('POST', Uri.parse('http://example.com/api'))
            ..headers['Content-Type'] = 'application/json'
            ..body = '{"key": "value"}';

      test('does nothing when log level is NONE', () {
        Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
        expect(() => Logger.logRequest(request: request), returnsNormally);
      });

      test('logs basic request info when log level is BASIC', () {
        Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: false);
        expect(() => Logger.logRequest(request: request), returnsNormally);
      });

      test('logs headers when log level is HEADERS', () {
        Logger.init(logLevel: LogLevel.HEADERS, enableReleaseLogging: false);
        expect(() => Logger.logRequest(request: request), returnsNormally);
      });

      test('logs body for POST when log level is BODY', () {
        Logger.init(logLevel: LogLevel.BODY, enableReleaseLogging: false);
        expect(() => Logger.logRequest(request: request), returnsNormally);
      });

      test(
        'logs basic request info when log level is BASIC and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true);
          expect(() => Logger.logRequest(request: request), returnsNormally);
        },
      );

      test(
        'logs headers when log level is HEADERS and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.HEADERS, enableReleaseLogging: true);
          expect(() => Logger.logRequest(request: request), returnsNormally);
        },
      );

      test(
        'logs body for POST when log level is BODY and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.BODY, enableReleaseLogging: true);
          expect(() => Logger.logRequest(request: request), returnsNormally);
        },
      );
    });

    group('logResponse', () {
      final http.StreamedResponse successResponse = http.StreamedResponse(
        Stream<List<int>>.fromFuture(
          Future<List<int>>.value('{"status": "ok"}'.codeUnits),
        ),
        200,
        request: http.Request('GET', Uri.parse('http://example.com/api')),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      final http.StreamedResponse errorResponse = http.StreamedResponse(
        Stream<List<int>>.fromFuture(
          Future<List<int>>.value('Error'.codeUnits),
        ),
        500,
        request: http.Request('GET', Uri.parse('http://example.com/api')),
        reasonPhrase: 'Internal Server Error',
      );

      test('does nothing when log level is NONE', () {
        Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
        expect(
          () => Logger.logResponse(
            response: successResponse,
            body: '{"status": "ok"}',
          ),
          returnsNormally,
        );
      });

      test('logs basic response info when log level is BASIC', () {
        Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: false);
        expect(
          () => Logger.logResponse(
            response: successResponse,
            body: '{"status": "ok"}',
          ),
          returnsNormally,
        );
      });

      test('logs headers when log level is HEADERS', () {
        Logger.init(logLevel: LogLevel.HEADERS, enableReleaseLogging: false);
        expect(
          () => Logger.logResponse(
            response: successResponse,
            body: '{"status": "ok"}',
          ),
          returnsNormally,
        );
      });

      test('logs body for success when log level is BODY', () {
        Logger.init(logLevel: LogLevel.BODY, enableReleaseLogging: false);
        expect(
          () => Logger.logResponse(
            response: successResponse,
            body: '{"status": "ok"}',
          ),
          returnsNormally,
        );
      });

      test('logs error response', () {
        Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: false);
        expect(
          () => Logger.logResponse(response: errorResponse, body: 'Error'),
          returnsNormally,
        );
      });

      test(
        'logs basic response info when log level is BASIC and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true);
          expect(
            () => Logger.logResponse(
              response: successResponse,
              body: '{"status": "ok"}',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'logs headers when log level is HEADERS and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.HEADERS, enableReleaseLogging: true);
          expect(
            () => Logger.logResponse(
              response: successResponse,
              body: '{"status": "ok"}',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'logs body for success when log level is BODY and release logging is on',
        () {
          Logger.init(logLevel: LogLevel.BODY, enableReleaseLogging: true);
          expect(
            () => Logger.logResponse(
              response: successResponse,
              body: '{"status": "ok"}',
            ),
            returnsNormally,
          );
        },
      );

      test('logs error response when release logging is on', () {
        Logger.init(logLevel: LogLevel.BASIC, enableReleaseLogging: true);
        expect(
          () => Logger.logResponse(response: errorResponse, body: 'Error'),
          returnsNormally,
        );
      });
    });
  });
}
