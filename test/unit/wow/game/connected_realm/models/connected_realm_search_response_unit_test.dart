import 'package:battle_net/src/wow/game/connected_realm/models/connected_realm_result.dart';
import 'package:battle_net/src/wow/game/connected_realm/models/connected_realm_search_response.dart';
import 'package:test/test.dart';

void main() {
  group('ConnectedRealmSearchResponse', () {
    test('copyWith', () {
      const ConnectedRealmSearchResponse response =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );

      final ConnectedRealmSearchResponse response2 = response.copyWith(page: 2);
      expect(response2.page, 2);
      expect(response.page, 1);
    });

    test('toString', () {
      const ConnectedRealmSearchResponse response =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );
      expect(
        response.toString(),
        'ConnectedRealmSearchResponse{page: 1, pageSize: 20, maxPageSize: 100, pageCount: 1, results: []}',
      );
    });

    test('equality', () {
      const ConnectedRealmSearchResponse response1 =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );
      const ConnectedRealmSearchResponse response2 =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );
      const ConnectedRealmSearchResponse response3 =
          ConnectedRealmSearchResponse(
            page: 2,
            pageSize: 30,
            maxPageSize: 150,
            pageCount: 2,
            results: <ConnectedRealmResult>[],
          );
      expect(response1, response2);
      expect(response1 == response2, isTrue);
      expect(response1 == response3, isFalse);
    });

    test('hashCode', () {
      const ConnectedRealmSearchResponse response1 =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );
      const ConnectedRealmSearchResponse response2 =
          ConnectedRealmSearchResponse(
            page: 1,
            pageSize: 20,
            maxPageSize: 100,
            pageCount: 1,
            results: <ConnectedRealmResult>[],
          );
      expect(response1.hashCode, response2.hashCode);
    });
  });
}
