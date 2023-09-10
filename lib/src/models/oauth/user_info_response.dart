import 'dart:convert';

import 'package:meta/meta.dart';

/// User Info data model
@immutable
class UserInfoResponse {
  final String sub;
  final int id;
  final String battleTag;

  const UserInfoResponse({
    required this.sub,
    required this.id,
    required this.battleTag,
  });

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

  factory UserInfoResponse.fromRawJson(String str) =>
      UserInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        sub: json['sub'],
        id: json['id'],
        battleTag: json['battletag'],
      );

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
