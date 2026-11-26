import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/toy/index`.
class ToysIndexResponse extends ApiModel {
  /// Creates a [ToysIndexResponse] from its JSON object.
  ToysIndexResponse(super.raw);

  /// All toys.
  List<KeyedRef> get toys => refsOf('toys');
}

/// Response of `GET /data/wow/toy/{toyId}`.
class ToyResponse extends ApiModel {
  /// Creates a [ToyResponse] from its JSON object.
  ToyResponse(super.raw);

  /// The toy ID.
  int? get id => intOf('id');

  /// The item representing this toy.
  KeyedRef? get item => refOf('item');

  /// The source type, for example `VENDOR` or `DROP`.
  String? get source => typeOf('source');

  /// Whether the toy should be hidden if uncollected.
  bool? get shouldExcludeIfUncollected =>
      boolOf('should_exclude_if_uncollected');

  /// The ID to use with item media lookups.
  int? get mediaId => idOf('media');
}
