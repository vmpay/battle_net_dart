import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

class _TestModel extends ApiModel {
  _TestModel(super.raw);

  int? get id => intOf('id');
  String? get name => stringOf('name');
  bool? get flag => boolOf('flag');
  String? get type => typeOf('quality');
  String? get href => hrefOf('self');
  int? get nestedId => idOf('item');
  String? get nestedName => nameOf('item');
  KeyedRef? get ref => refOf('item');
  List<KeyedRef> get refs => refsOf('items');
  List<String> get hrefs => hrefsOf('links');
}

void main() {
  group('ApiModel', () {
    test('extracts typed fields, handles missing/wrong types, and equality', () {
      final _TestModel a = _TestModel(
        ApiModel.decode(
          '{"id":1,"name":"Test","flag":true,"quality":{"type":"EPIC"},'
          '"self":{"href":"https://x"},"item":{"key":{"href":"https://k"},'
          '"id":2,"name":"Item","slug":"item"},"items":[{"id":3,"name":"Sub"}],'
          '"links":[{"href":"https://l1"},{"href":123}]}',
        ),
      );
      final _TestModel b = _TestModel(ApiModel.decode(a.toRawJson()));
      final _TestModel empty = _TestModel(const <String, dynamic>{
        'id': 'bad',
        'name': 123,
        'flag': 'no',
        'items': 'not-a-list',
      });

      expect(a.id, 1);
      expect(a.name, 'Test');
      expect(a.flag, isTrue);
      expect(a.type, 'EPIC');
      expect(a.href, 'https://x');
      expect(a.nestedId, 2);
      expect(a.nestedName, 'Item');
      expect(a.ref?.href, 'https://k');
      expect(a.ref?.slug, 'item');
      expect(a.refs.single.id, 3);
      expect(a.hrefs, <String>['https://l1']);

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a.toString(), contains('_TestModel'));
      expect(a == empty, isFalse);

      expect(empty.id, isNull);
      expect(empty.name, isNull);
      expect(empty.flag, isNull);
      expect(empty.ref, isNull);
      expect(empty.refs, isEmpty);
    });

    test('MediaResponse and SearchResponse', () {
      final MediaResponse media = MediaResponse(const <String, dynamic>{
        'id': 19019,
        'assets': <dynamic>[
          <String, dynamic>{
            'key': 'icon',
            'value': 'https://img',
            'file_data_id': 42,
          },
        ],
      });
      expect(media.id, 19019);
      expect(media.assets.single.key, 'icon');
      expect(media.assets.single.value, 'https://img');
      expect(media.assets.single.fileDataId, 42);

      final SearchResponse search = SearchResponse(const <String, dynamic>{
        'page': 1,
        'pageSize': 2,
        'maxPageSize': 100,
        'pageCount': 5,
        'results': <dynamic>[
          <String, dynamic>{
            'key': <String, dynamic>{'href': 'https://r'},
            'data': <String, dynamic>{'id': 10},
          },
        ],
      });
      expect(search.page, 1);
      expect(search.pageSize, 2);
      expect(search.maxPageSize, 100);
      expect(search.pageCount, 5);
      expect(search.results.single.href, 'https://r');
      expect(search.results.single.id, 10);
      expect(SearchResult(const <String, dynamic>{}).data, isEmpty);
    });
  });
}
