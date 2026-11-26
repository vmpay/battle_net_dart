import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/utils/api_client.dart';

import 'models/account_models.dart';

/// Client for the Account Profile API (`battleNet.wow.account`).
///
/// **Requires a user access token** with the `wow.profile` scope (obtained via
/// the Authorization Code OAuth flow). Calling these endpoints with a
/// client-credentials token returns `401 Unauthorized`.
///
/// [namespace] defaults to [BattleNetNamespace.profile] (Retail).
class AccountProfileClient extends ApiClient {
  /// Creates an [AccountProfileClient].
  AccountProfileClient({required super.connectionTimeout, super.client});

  /// Returns a profile summary of the user's WoW account.
  Future<AccountProfileResponse> getAccountProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow',
    parse: AccountProfileResponse.new,
  );

  /// Returns protected profile details for a user's character.
  Future<ProtectedCharacterProfileResponse> getProtectedCharacterProfile({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    required int realmId,
    required int characterId,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/protected-character/$realmId-$characterId',
    parse: ProtectedCharacterProfileResponse.new,
  );

  /// Returns an index of the user's account-wide collections.
  Future<AccountCollectionsIndexResponse> getAccountCollectionsIndex({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections',
    parse: AccountCollectionsIndexResponse.new,
  );

  /// Returns the user's account-wide mounts collection.
  Future<AccountMountsCollectionResponse> getAccountMountsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections/mounts',
    parse: AccountMountsCollectionResponse.new,
  );

  /// Returns the user's account-wide battle pets collection.
  Future<AccountPetsCollectionResponse> getAccountPetsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections/pets',
    parse: AccountPetsCollectionResponse.new,
  );

  /// Returns the user's account-wide toys collection.
  Future<AccountToysCollectionResponse> getAccountToysCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections/toys',
    parse: AccountToysCollectionResponse.new,
  );

  /// Returns the user's account-wide heirlooms collection.
  Future<AccountHeirloomsCollectionResponse> getAccountHeirloomsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections/heirlooms',
    parse: AccountHeirloomsCollectionResponse.new,
  );

  /// Returns the user's account-wide transmogs collection.
  Future<AccountTransmogsCollectionResponse> getAccountTransmogsCollection({
    required String accessToken,
    required BattleNetRegion region,
    required BattleNetLocale locale,
    BattleNetNamespace namespace = BattleNetNamespace.profile,
  }) => get(
    accessToken: accessToken,
    region: region,
    namespace: namespace,
    locale: locale,
    path: '/profile/user/wow/collections/transmogs',
    parse: AccountTransmogsCollectionResponse.new,
  );
}
