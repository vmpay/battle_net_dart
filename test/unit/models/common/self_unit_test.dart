import 'package:battle_net/src/models/common/self.dart';
import 'package:test/test.dart';

void main() {
  const Self expected = Self(href: 'test_href');

  group('Self', () {
    test('should create an instance from a JSON string', () {
      final Self actual = Self.fromRawJson('{"href":"test_href"}');
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(expected.toRawJson(), equals('{"href":"test_href"}'));
    });

    test('should return a copy with updated values', () {
      final Self copied = expected.copyWith(href: 'new_href');
      expect(copied.href, equals('new_href'));
    });

    test('should have a meaningful string representation', () {
      expect(expected.toString(), equals('Self{href: test_href}'));
    });

    test('should have correct equality and hashcode', () {
      const Self other = Self(href: 'test_href');
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
