import 'dart:convert';

import 'package:meta/meta.dart';

// ---------------------------------------------------------------------------
// ForeverAccountProfileResponse
// ---------------------------------------------------------------------------

/// Response for `getForeverAccountProfile` (`GET /profile/user/wow`).
///
/// Requires a user access token with `wow.profile` scope.
@immutable
class ForeverAccountProfileResponse {
  /// WoW account collections of characters grouped by WoW accounts.
  final List<ForeverWowAccount> wowAccounts;

  const ForeverAccountProfileResponse({required this.wowAccounts});

  factory ForeverAccountProfileResponse.fromRawJson(String str) =>
      ForeverAccountProfileResponse.fromJson(json.decode(str));

  factory ForeverAccountProfileResponse.fromJson(Map<String, dynamic> j) =>
      ForeverAccountProfileResponse(
        wowAccounts: (j['wow_accounts'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverWowAccount.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverAccountProfileResponse{accounts: ${wowAccounts.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverAccountProfileResponse &&
          runtimeType == other.runtimeType &&
          wowAccounts.length == other.wowAccounts.length;

  @override
  int get hashCode => wowAccounts.length.hashCode;
}

/// A WoW sub-account containing Forever characters.
@immutable
class ForeverWowAccount {
  final int id;
  final List<ForeverAccountCharacter> characters;

  const ForeverWowAccount({required this.id, required this.characters});

  factory ForeverWowAccount.fromJson(Map<String, dynamic> j) =>
      ForeverWowAccount(
        id: (j['id'] as num?)?.toInt() ?? 0,
        characters: (j['characters'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (dynamic e) =>
                  ForeverAccountCharacter.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  @override
  String toString() =>
      'ForeverWowAccount{id: $id, characters: ${characters.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverWowAccount &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// A single character entry from the account profile.
@immutable
class ForeverAccountCharacter {
  final String? slug;
  final String? name;
  final int? level;
  final int? classId;
  final int? raceId;

  const ForeverAccountCharacter({
    this.slug,
    this.name,
    this.level,
    this.classId,
    this.raceId,
  });

  factory ForeverAccountCharacter.fromJson(Map<String, dynamic> j) =>
      ForeverAccountCharacter(
        slug: j['slug'] as String?,
        name: j['name'] as String?,
        level: (j['level'] as num?)?.toInt(),
        classId: (j['playable_class']?['id'] as num?)?.toInt(),
        raceId: (j['playable_race']?['id'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'ForeverAccountCharacter{slug: $slug, name: $name, level: $level}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeverAccountCharacter &&
          runtimeType == other.runtimeType &&
          slug == other.slug;

  @override
  int get hashCode => slug.hashCode;
}
