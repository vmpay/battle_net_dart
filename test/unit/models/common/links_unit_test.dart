import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:test/test.dart';

void main() {
  const Links expected = Links(self: Self(href: 'test_href'));

  group('Links', () {
    test('should create an instance from a JSON string', () {
      final Links actual = Links.fromRawJson('{"self":{"href":"test_href"}}');
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(expected.toRawJson(), equals('{"self":{"href":"test_href"}}'));
    });

    test('should return a copy with updated values', () {
      final Links copied = expected.copyWith(
        self: const Self(href: 'new_href'),
      );
      expect(copied.self.href, equals('new_href'));
    });

    test('should have a meaningful string representation', () {
      expect(expected.toString(), equals('Links{self: Self{href: test_href}}'));
    });

    test('should have correct equality and hashcode', () {
      const Links other = Links(self: Self(href: 'test_href'));
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
