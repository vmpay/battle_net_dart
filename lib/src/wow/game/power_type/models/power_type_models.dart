import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /data/wow/power-type/index`.
class PowerTypesIndexResponse extends ApiModel {
  /// Creates a [PowerTypesIndexResponse] from its JSON object.
  PowerTypesIndexResponse(super.raw);

  /// All power types.
  List<KeyedRef> get powerTypes => refsOf('power_types');
}

/// Response of `GET /data/wow/power-type/{powerTypeId}`.
class PowerTypeResponse extends ApiModel {
  /// Creates a [PowerTypeResponse] from its JSON object.
  PowerTypeResponse(super.raw);

  /// The power type ID.
  int? get id => intOf('id');

  /// The localized power type name.
  String? get name => stringOf('name');
}
