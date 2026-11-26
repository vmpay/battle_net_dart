import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/mount/index`.
class MountsIndexResponse extends ApiModel {
  /// Creates a [MountsIndexResponse] from its JSON object.
  MountsIndexResponse(super.raw);

  /// All mounts.
  List<KeyedRef> get mounts => refsOf('mounts');
}

/// Response of `GET /data/wow/mount/{mountId}`.
class MountResponse extends ApiModel {
  /// Creates a [MountResponse] from its JSON object.
  MountResponse(super.raw);

  /// The mount ID.
  int? get id => intOf('id');

  /// The localized mount name.
  String? get name => stringOf('name');

  /// The localized mount description.
  String? get description => stringOf('description');

  /// The source type, for example `VENDOR` or `DROP`.
  String? get source => typeOf('source');

  /// The faction restriction, if any (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');

  /// Creature display references for this mount.
  List<KeyedRef> get creatureDisplays => refsOf('creature_displays');
}
