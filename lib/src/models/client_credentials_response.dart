import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class ClientCredentialsResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String sub;

  const ClientCredentialsResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.sub,
  });

  factory ClientCredentialsResponse.fromRawJson(String str) =>
      ClientCredentialsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientCredentialsResponse.fromJson(Map<String, dynamic> json) =>
      ClientCredentialsResponse(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        sub: json['sub'],
      );

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
