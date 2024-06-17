import 'dart:convert';

import 'package:meta/meta.dart';

/// A class that represents the response received after
/// requesting user information in an OAuth2 authentication flow.
@immutable
class UserInfoResponse {
  /// The subject (sub) identifier, representing the user.
  final String sub;

  /// The unique identifier for the user.
  final int id;

  /// The BattleTag associated with the user.
  final String battleTag;

  /// Creates an instance of [UserInfoResponse].
  ///
  /// All fields are required.
  const UserInfoResponse({
    required this.sub,
    required this.id,
    required this.battleTag,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  UserInfoResponse copyWith({
    String? sub,
    int? id,
    String? battleTag,
  }) =>
      UserInfoResponse(
        sub: sub ?? this.sub,
        id: id ?? this.id,
        battleTag: battleTag ?? this.battleTag,
      );

  /// Creates an instance of [UserInfoResponse] from a JSON string.
  factory UserInfoResponse.fromRawJson(String str) =>
      UserInfoResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [UserInfoResponse] from a JSON map.
  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        sub: json['sub'],
        id: json['id'],
        battleTag: json['battletag'],
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sub': sub,
        'id': id,
        'battletag': battleTag,
      };

  @override
  String toString() {
    return 'UserInfoResponse{sub: $sub, id: $id, battleTag: $battleTag}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoResponse &&
          runtimeType == other.runtimeType &&
          sub == other.sub &&
          id == other.id &&
          battleTag == other.battleTag;

  @override
  int get hashCode => sub.hashCode ^ id.hashCode ^ battleTag.hashCode;
}
