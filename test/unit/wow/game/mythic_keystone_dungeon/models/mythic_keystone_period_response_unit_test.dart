import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_period_response.dart';
import 'package:test/test.dart';

void main() {
  final DateTime testStartTime = DateTime.utc(2023, 3, 15);
  final DateTime testEndTime = DateTime.utc(2023, 3, 22);

  final MythicKeystonePeriodResponse expected = MythicKeystonePeriodResponse(
    links: const Links(self: Self(href: 'test_href')),
    id: 123,
    startTime: testStartTime,
    endTime: testEndTime,
  );

  group('MythicKeystonePeriodResponse', () {
    test('should create an instance from a JSON string', () {
      final MythicKeystonePeriodResponse
      actual = MythicKeystonePeriodResponse.fromRawJson(
        '{"_links": {"self": {"href": "test_href"}}, "id": 123, "start_timestamp": 1678838400000, "end_timestamp": 1679443200000}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"_links":{"self":{"href":"test_href"}},"id":123,"start_timestamp":1678838400000,"end_timestamp":1679443200000}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final MythicKeystonePeriodResponse copied = expected.copyWith(id: 456);
      expect(copied.id, equals(456));
      expect(copied.startTime, equals(expected.startTime));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'MythicKeystonePeriodResponse{links: Links{self: Self{href: test_href}}, id: 123, startTime: 2023-03-15 00:00:00.000Z, endTime: 2023-03-22 00:00:00.000Z}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      final MythicKeystonePeriodResponse other = MythicKeystonePeriodResponse(
        links: const Links(self: Self(href: 'test_href')),
        id: 123,
        startTime: testStartTime,
        endTime: testEndTime,
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
