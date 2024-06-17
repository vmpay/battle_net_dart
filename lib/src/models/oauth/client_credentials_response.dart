import 'dart:convert';

import 'package:meta/meta.dart';

/// Access token response data model. This is the only request necessary for
/// the client credential flow, OAuth's authentication flow intended for application servers.
@immutable
class ClientCredentialsResponse {
  /// The access token issued by the authorization server.
  final String accessToken;

  /// The type of the token issued, typically "Bearer".
  final String tokenType;

  /// The duration in seconds for which the access token is valid.
  final int expiresIn;

  /// The subject (sub) identifier, representing the client.
  final String sub;

  /// Creates an instance of [ClientCredentialsResponse].
  ///
  /// All fields are required.
  const ClientCredentialsResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.sub,
  });

  /// Creates an instance of [ClientCredentialsResponse] from a JSON string.
  factory ClientCredentialsResponse.fromRawJson(String str) =>
      ClientCredentialsResponse.fromJson(json.decode(str));

  /// Converts this instance to a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Creates an instance of [ClientCredentialsResponse] from a JSON map.
  factory ClientCredentialsResponse.fromJson(Map<String, dynamic> json) =>
      ClientCredentialsResponse(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        sub: json['sub'],
      );

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'sub': sub,
      };

  @override
  String toString() {
    return 'ClientCredentialsResponse{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, sub: $sub}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientCredentialsResponse &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          tokenType == other.tokenType &&
          expiresIn == other.expiresIn &&
          sub == other.sub;

  @override
  int get hashCode =>
      accessToken.hashCode ^
      tokenType.hashCode ^
      expiresIn.hashCode ^
      sub.hashCode;
}
