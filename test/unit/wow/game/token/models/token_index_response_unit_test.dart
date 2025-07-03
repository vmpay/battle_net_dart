import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/wow/game/token/models/token_index_response.dart';
import 'package:test/test.dart';

void main() {
  const TokenIndexResponse expected = TokenIndexResponse(
    links: Links(self: Self(href: 'test_href')),
    lastUpdatedTimestamp: 1234567890,
    price: 100000,
  );

  group('TokenIndexResponse', () {
    test('should create an instance from a JSON string', () {
      final TokenIndexResponse actual = TokenIndexResponse.fromRawJson(
        '{"_links": {"self": {"href": "test_href"}}, "last_updated_timestamp": 1234567890, "price": 100000}',
      );
      expect(actual, equals(expected));
    });

    test('should convert an instance to a JSON string', () {
      expect(
        expected.toRawJson(),
        equals(
          '{"_links":{"self":{"href":"test_href"}},"last_updated_timestamp":1234567890,"price":100000}',
        ),
      );
    });

    test('should return a copy with updated values', () {
      final TokenIndexResponse copied = expected.copyWith(price: 200000);
      expect(copied.price, equals(200000));
      expect(
        copied.lastUpdatedTimestamp,
        equals(expected.lastUpdatedTimestamp),
      );
    });

    test('should have a meaningful string representation', () {
      expect(
        expected.toString(),
        equals(
          'TokenIndex{links: Links{self: Self{href: test_href}}, lastUpdatedTimestamp: 1234567890, price: 100000}',
        ),
      );
    });

    test('should have correct equality and hashcode', () {
      const TokenIndexResponse other = TokenIndexResponse(
        links: Links(self: Self(href: 'test_href')),
        lastUpdatedTimestamp: 1234567890,
        price: 100000,
      );
      expect(expected, equals(other));
      expect(expected.hashCode, equals(other.hashCode));
    });
  });
}
