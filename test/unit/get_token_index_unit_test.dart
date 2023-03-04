import 'package:battle_net/src/models/common/links.dart';
import 'package:battle_net/src/models/common/self.dart';
import 'package:battle_net/src/models/token/token_index_response.dart';
import 'package:test/test.dart';

void main() {
  const Self expectedSelf = Self(
      href: 'https://eu.api.blizzard.com/data/wow/token/?namespace=dynamic-eu');
  const Links expectedLinks = Links(self: expectedSelf);
  const TokenIndexResponse expectedTokenIndexResponse = TokenIndexResponse(
      links: expectedLinks,
      lastUpdatedTimestamp: 1675888263000,
      price: 2508420000);

  group('get token index mapping', () {
    test('self response', () {
      final Self self = Self.fromRawJson(
          '{"href": "https://eu.api.blizzard.com/data/wow/token/?namespace=dynamic-eu"}');
      expect(self, expectedSelf);
    });

    test('links response', () {
      final Links links = Links.fromRawJson(
          '{"self": {"href": "https://eu.api.blizzard.com/data/wow/token/?namespace=dynamic-eu"}}');
      expect(links, expectedLinks);
    });

    test('token index response', () {
      final TokenIndexResponse tokenIndexResponse = TokenIndexResponse.fromRawJson(
          '{"_links": {"self": {"href": "https://eu.api.blizzard.com/data/wow/token/?namespace=dynamic-eu"}},"last_updated_timestamp": 1675888263000,"price": 2508420000}');
      expect(tokenIndexResponse, expectedTokenIndexResponse);
    });
  });
}
