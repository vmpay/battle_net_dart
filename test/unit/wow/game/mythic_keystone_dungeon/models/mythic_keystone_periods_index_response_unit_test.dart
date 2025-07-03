import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_periods_index_response.dart';
import 'package:test/test.dart';

void main() {
  const Period expectedPeriod = Period(id: 123);
  const MythicKeystonePeriodsIndexResponse expected =
      MythicKeystonePeriodsIndexResponse(
        links: Links(self: Self(href: 'test_href')),
        periods: <Period>[expectedPeriod],
        currentPeriod: expectedPeriod,
      );

  group('MythicKeystonePeriodsIndexResponse', () {
    test('should create an instance from a JSON string', () {
      final MythicKeystonePeriodsIndexResponse
      actual = MythicKeystonePeriodsIndexResponse.fromRawJson(
        '{"_links": {"self": {"href": "test_href"}}, "periods": [{"id": 123}], "current_period": {"id": 123}}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"_links":{"self":{"href":"test_href"}},"periods":[{"id":123}],"current_period":{"id":123}}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final MythicKeystonePeriodsIndexResponse copied = expected.copyWith(
        currentPeriod: const Period(id: 456),
      );
      expect(copied.currentPeriod.id, equals(456));
      expect(copied.periods, equals(expected.periods));
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'MythicKeystonePeriodsIndexResponse{links: Links{self: Self{href: test_href}}, periods: [Period{id: 123}], currentPeriod: Period{id: 123}}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const MythicKeystonePeriodsIndexResponse other =
          MythicKeystonePeriodsIndexResponse(
            links: Links(self: Self(href: 'test_href')),
            periods: <Period>[expectedPeriod],
            currentPeriod: expectedPeriod,
          );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });

  group('Period', () {
    test('should create an instance from a JSON map', () {
      final Period actual = Period.fromJson(const <String, dynamic>{'id': 123});
      expect(actual, equals(expectedPeriod));
    });

    test('should convert an instance to a JSON map', () {
      expect(expectedPeriod.toJson(), equals(<String, dynamic>{'id': 123}));
    });

    test('should return a copy with updated values', () {
      final Period copied = expectedPeriod.copyWith(id: 456);
      expect(copied.id, equals(456));
    });

    test('should have a meaningful string representation', () {
      expect(expectedPeriod.toString(), equals('Period{id: 123}'));
    });

    test('should have correct equality and hashcode', () {
      const Period other = Period(id: 123);
      expect(expectedPeriod, equals(other));
      expect(expectedPeriod.hashCode, equals(other.hashCode));
    });
  });
}
