import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/realm/index`.
class RealmsIndexResponse extends ApiModel {
  /// Creates a [RealmsIndexResponse] from its JSON object.
  RealmsIndexResponse(super.raw);

  /// All realms of the region.
  List<KeyedRef> get realms => refsOf('realms');
}

/// Response of `GET /data/wow/realm/{realmSlug}`.
class RealmResponse extends ApiModel {
  /// Creates a [RealmResponse] from its JSON object.
  RealmResponse(super.raw);

  /// The realm ID.
  int? get id => intOf('id');

  /// The localized realm name.
  String? get name => stringOf('name');

  /// The realm slug.
  String? get slug => stringOf('slug');

  /// The localized realm category, for example `English`.
  String? get category => stringOf('category');

  /// The realm locale, for example `enGB`.
  String? get locale => stringOf('locale');

  /// The realm timezone, for example `Europe/Paris`.
  String? get timezone => stringOf('timezone');

  /// The realm type, for example `NORMAL` or `RP`.
  String? get type => typeOf('type');

  /// Whether the realm is a tournament realm.
  bool? get isTournament => boolOf('is_tournament');

  /// The region the realm belongs to.
  KeyedRef? get region => refOf('region');

  /// The URL of the connected realm the realm belongs to.
  String? get connectedRealmHref => hrefOf('connected_realm');
}

/// Response of `GET /data/wow/connected-realm/index`.
class ConnectedRealmsIndexResponse extends ApiModel {
  /// Creates a [ConnectedRealmsIndexResponse] from its JSON object.
  ConnectedRealmsIndexResponse(super.raw);

  /// The URLs of all connected realms of the region.
  List<String> get connectedRealmHrefs => hrefsOf('connected_realms');

  /// The IDs of all connected realms, parsed from [connectedRealmHrefs].
  List<int> get connectedRealmIds => List<int>.unmodifiable(
    connectedRealmHrefs
        .map((String href) => int.tryParse(Uri.parse(href).pathSegments.last))
        .whereType<int>(),
  );
}

/// Response of `GET /data/wow/region/index`.
class RegionsIndexResponse extends ApiModel {
  /// Creates a [RegionsIndexResponse] from its JSON object.
  RegionsIndexResponse(super.raw);

  /// The URLs of all regions available on this host.
  List<String> get regionHrefs => hrefsOf('regions');
}

/// Response of `GET /data/wow/region/{regionId}`.
class RegionResponse extends ApiModel {
  /// Creates a [RegionResponse] from its JSON object.
  RegionResponse(super.raw);

  /// The region ID.
  int? get id => intOf('id');

  /// The localized region name.
  String? get name => stringOf('name');

  /// The region tag, for example `EU`.
  String? get tag => stringOf('tag');

  /// The current game patch of the region.
  String? get patchString => stringOf('patch_string');
}
