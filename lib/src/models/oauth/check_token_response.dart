import 'dart:convert';

import 'package:battle_net/src/constants/battle_net_scope.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Check token response data model.
/// In case of client credentials flow token [userName] is null
@immutable
class CheckTokenResponse {
  /// The username associated with the token.
  final String? userName;

  /// A list of scopes that the token is valid for.
  final List<BattleNetScope> scope;

  /// A list of authorities associated with the user's account.
  final List<String> accountAuthorities;

  /// The expiration time of the token, represented as a Unix timestamp.
  final int exp;

  /// A list of authorities associated with the client.
  final List<String> clientAuthorities;

  /// A list of authorities granted to the token.
  final List<String> authorities;

  /// The client ID associated with the token.
  final String clientId;

  /// Creates an instance of [CheckTokenResponse].
  ///
  /// All fields are required.
  const CheckTokenResponse({
    required this.userName,
    required this.scope,
    required this.accountAuthorities,
    required this.exp,
    required this.clientAuthorities,
    required this.authorities,
    required this.clientId,
  });

  /// Returns a copy of this instance with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the existing value is retained.
  CheckTokenResponse copyWith({
    String? userName,
    List<BattleNetScope>? scope,
    List<String>? accountAuthorities,
    int? exp,
    List<String>? clientAuthorities,
    List<String>? authorities,
    String? clientId,
  }) =>
      CheckTokenResponse(
        userName: userName ?? this.userName,
        scope: scope ?? this.scope,
        accountAuthorities: accountAuthorities ?? this.accountAuthorities,
        exp: exp ?? this.exp,
        clientAuthorities: clientAuthorities ?? this.clientAuthorities,
        authorities: authorities ?? this.authorities,
        clientId: clientId ?? this.clientId,
      );

  /// Creates an instance of [CheckTokenResponse] from a JSON string.
  factory CheckTokenResponse.fromRawJson(String str) =>
      CheckTokenResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [CheckTokenResponse] from a JSON map.
  factory CheckTokenResponse.fromJson(Map<String, dynamic> json) =>
      CheckTokenResponse(
        userName: json['user_name'],
        scope: List<BattleNetScope>.from(json['scope'].map((dynamic x) =>
            BattleNetScope.values
                .firstWhere((BattleNetScope element) => element.name == x))),
        accountAuthorities: List<String>.from(
            json['account_authorities'].map((dynamic x) => x)),
        exp: json['exp'],
        clientAuthorities:
            List<String>.from(json['client_authorities'].map((dynamic x) => x)),
        authorities:
            List<String>.from(json['authorities'].map((dynamic x) => x)),
        clientId: json['client_id'],
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_name': userName,
        'scope': List<dynamic>.from(scope.map((BattleNetScope x) => x.name)),
        'account_authorities':
            List<dynamic>.from(accountAuthorities.map((String x) => x)),
        'exp': exp,
        'client_authorities':
            List<dynamic>.from(clientAuthorities.map((String x) => x)),
        'authorities': List<dynamic>.from(authorities.map((String x) => x)),
        'client_id': clientId,
      };

  @override
  String toString() {
    return 'CheckTokenResponse{userName: $userName, scope: $scope, accountAuthorities: $accountAuthorities, exp: $exp, clientAuthorities: $clientAuthorities, authorities: $authorities, clientId: $clientId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckTokenResponse &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          const DeepCollectionEquality().equals(scope, other.scope) &&
          const DeepCollectionEquality()
              .equals(accountAuthorities, other.accountAuthorities) &&
          exp == other.exp &&
          const DeepCollectionEquality()
              .equals(clientAuthorities, other.clientAuthorities) &&
          const DeepCollectionEquality()
              .equals(authorities, other.authorities) &&
          clientId == other.clientId;

  @override
  int get hashCode =>
      userName.hashCode ^
      Object.hashAll(scope) ^
      Object.hashAll(accountAuthorities) ^
      exp.hashCode ^
      Object.hashAll(clientAuthorities) ^
      Object.hashAll(authorities) ^
      clientId.hashCode;
}
