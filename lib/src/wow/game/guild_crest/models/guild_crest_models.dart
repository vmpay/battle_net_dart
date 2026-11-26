import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/guild-crest/index`.
class GuildCrestComponentsIndexResponse extends ApiModel {
  /// Creates a [GuildCrestComponentsIndexResponse] from its JSON object.
  GuildCrestComponentsIndexResponse(super.raw);

  /// Guild crest emblems.
  List<KeyedRef> get emblems => refsOf('emblems');

  /// Guild crest borders.
  List<KeyedRef> get borders => refsOf('borders');
}
