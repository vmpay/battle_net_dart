import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/heirloom/index`.
class HeirloomsIndexResponse extends ApiModel {
  /// Creates a [HeirloomsIndexResponse] from its JSON object.
  HeirloomsIndexResponse(super.raw);

  /// All heirlooms.
  List<KeyedRef> get heirlooms => refsOf('heirlooms');
}

/// Response of `GET /data/wow/heirloom/{heirloomId}`.
class HeirloomResponse extends ApiModel {
  /// Creates a [HeirloomResponse] from its JSON object.
  HeirloomResponse(super.raw);

  /// The heirloom ID.
  int? get id => intOf('id');

  /// The base item reference.
  KeyedRef? get item => refOf('item');

  /// The source type, for example `VENDOR` or `ACHIEVEMENT`.
  String? get source => typeOf('source');

  /// The localized source description.
  String? get sourceDescription => stringOf('source_description');

  /// The ID to use with item media lookups.
  int? get mediaId => idOf('media');
}
