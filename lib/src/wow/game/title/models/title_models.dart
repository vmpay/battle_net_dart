import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/title/index`.
class TitlesIndexResponse extends ApiModel {
  /// Creates a [TitlesIndexResponse] from its JSON object.
  TitlesIndexResponse(super.raw);

  /// All titles.
  List<KeyedRef> get titles => refsOf('titles');
}

/// Response of `GET /data/wow/title/{titleId}`.
class TitleResponse extends ApiModel {
  /// Creates a [TitleResponse] from its JSON object.
  TitleResponse(super.raw);

  /// The title ID.
  int? get id => intOf('id');

  /// The localized title name.
  String? get name => stringOf('name');
}
