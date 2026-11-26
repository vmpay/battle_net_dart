import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/title_models.dart';

/// Client for the Title API (`battleNet.wow.title`).
///
/// [namespace] defaults to [BattleNetNamespace.static] (Retail).
class TitleClient extends ApiClient {
  /// Creates a [TitleClient].
  TitleClient({required super.connectionTimeout, super.client});

  /// Returns an index of titles.
  Future<TitlesIndexResponse> getTitlesIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/title/index',
    parse: TitlesIndexResponse.new,
  );

  /// Returns a title by [titleId].
  Future<TitleResponse> getTitle({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int titleId,
    BattleNetNamespace namespace = BattleNetNamespace.static,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/data/wow/title/$titleId',
    parse: TitleResponse.new,
  );
}
