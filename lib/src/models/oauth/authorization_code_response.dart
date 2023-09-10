import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Access token response data model. This is the only request necessary for
/// the Authorization Code flow
@immutable
class AuthorizationCodeResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final List<BattleNetScope> scope;
  final String sub;
  final String idToken;

  const AuthorizationCodeResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
    required this.sub,
    required this.idToken,
  });

  AuthorizationCodeResponse copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    List<BattleNetScope>? scope,
    String? sub,
    String? idToken,
  }) =>
      AuthorizationCodeResponse(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        scope: scope ?? this.scope,
        sub: sub ?? this.sub,
        idToken: idToken ?? this.idToken,
      );

  factory AuthorizationCodeResponse.fromRawJson(String str) =>
      AuthorizationCodeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthorizationCodeResponse.fromJson(Map<String, dynamic> json) =>
      AuthorizationCodeResponse(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        scope: (json['scope'] as String)
            .split(' ')
            .map((String e) => BattleNetScope.values
                .firstWhere((BattleNetScope element) => element.name == e))
            .toList(),
        sub: json['sub'],
        idToken: json['id_token'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'scope': scope,
        'sub': sub,
        'id_token': idToken,
      };

  @override
  String toString() {
    return 'AuthorizationCodeResponse{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, scope: $scope, sub: $sub, idToken: $idToken}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorizationCodeResponse &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          tokenType == other.tokenType &&
          expiresIn == other.expiresIn &&
          const DeepCollectionEquality().equals(scope, other.scope) &&
          sub == other.sub &&
          idToken == other.idToken;

  @override
  int get hashCode =>
      accessToken.hashCode ^
      tokenType.hashCode ^
      expiresIn.hashCode ^
      Object.hashAll(scope) ^
      sub.hashCode ^
      idToken.hashCode;
}
