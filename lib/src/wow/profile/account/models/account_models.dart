import 'package:battle_net/src/models/common/api_model.dart';

/// Response of `GET /profile/user/wow`.
class AccountProfileResponse extends ApiModel {
  /// Creates an [AccountProfileResponse] from its JSON object.
  AccountProfileResponse(super.raw);

  /// The Battle.net account ID.
  int? get id => intOf('id');

  /// The WoW sub-accounts on this Battle.net account.
  List<AccountWowSubAccount> get wowAccounts =>
      listOf<AccountWowSubAccount>('wow_accounts', AccountWowSubAccount.new);
}

/// A WoW sub-account within [AccountProfileResponse].
class AccountWowSubAccount extends ApiModel {
  /// Creates an [AccountWowSubAccount] from its JSON object.
  AccountWowSubAccount(super.raw);

  /// The WoW sub-account ID.
  int? get id => intOf('id');

  /// The characters on this sub-account.
  List<AccountCharacterSummary> get characters =>
      listOf<AccountCharacterSummary>(
        'characters',
        AccountCharacterSummary.new,
      );
}

/// A character summary entry on an account profile.
class AccountCharacterSummary extends ApiModel {
  /// Creates an [AccountCharacterSummary] from its JSON object.
  AccountCharacterSummary(super.raw);

  /// The character ID.
  int? get id => intOf('id');

  /// The character name.
  String? get name => stringOf('name');

  /// The character level.
  int? get level => intOf('level');

  /// The character's realm.
  KeyedRef? get realm => refOf('realm');

  /// The character's playable class.
  KeyedRef? get playableClass => refOf('playable_class');

  /// The character's playable race.
  KeyedRef? get playableRace => refOf('playable_race');

  /// The character's faction (`ALLIANCE` or `HORDE`).
  String? get faction => typeOf('faction');
}

/// Response of `GET /profile/user/wow/protected-character/{realmId}-{characterId}`.
class ProtectedCharacterProfileResponse extends ApiModel {
  /// Creates a [ProtectedCharacterProfileResponse] from its JSON object.
  ProtectedCharacterProfileResponse(super.raw);

  /// The character ID.
  int? get id => intOf('id');

  /// The character name.
  String? get name => stringOf('name');

  /// The character's current money in copper.
  int? get money => intOf('money');
}

/// Response of `GET /profile/user/wow/collections`.
class AccountCollectionsIndexResponse extends ApiModel {
  /// Creates an [AccountCollectionsIndexResponse] from its JSON object.
  AccountCollectionsIndexResponse(super.raw);

  /// URL of the account pets collection.
  String? get petsHref => hrefOf('pets');

  /// URL of the account mounts collection.
  String? get mountsHref => hrefOf('mounts');

  /// URL of the account heirlooms collection.
  String? get heirloomsHref => hrefOf('heirlooms');

  /// URL of the account toys collection.
  String? get toysHref => hrefOf('toys');

  /// URL of the account transmogs collection.
  String? get transmogsHref => hrefOf('transmogs');
}

/// Response of `GET /profile/user/wow/collections/mounts`.
class AccountMountsCollectionResponse extends ApiModel {
  /// Creates an [AccountMountsCollectionResponse] from its JSON object.
  AccountMountsCollectionResponse(super.raw);

  /// The collected mounts, as raw JSON entries.
  List<Map<String, dynamic>> get mounts =>
      listOf<Map<String, dynamic>>('mounts', (Map<String, dynamic> m) => m);
}

/// Response of `GET /profile/user/wow/collections/pets`.
class AccountPetsCollectionResponse extends ApiModel {
  /// Creates an [AccountPetsCollectionResponse] from its JSON object.
  AccountPetsCollectionResponse(super.raw);

  /// The collected battle pets, as raw JSON entries.
  List<Map<String, dynamic>> get pets =>
      listOf<Map<String, dynamic>>('pets', (Map<String, dynamic> p) => p);

  /// Number of unlocked battle pet team slots.
  int? get unlockedBattlePetSlots => intOf('unlocked_battle_pet_slots');
}

/// Response of `GET /profile/user/wow/collections/toys`.
class AccountToysCollectionResponse extends ApiModel {
  /// Creates an [AccountToysCollectionResponse] from its JSON object.
  AccountToysCollectionResponse(super.raw);

  /// The collected toys, as raw JSON entries.
  List<Map<String, dynamic>> get toys =>
      listOf<Map<String, dynamic>>('toys', (Map<String, dynamic> t) => t);
}

/// Response of `GET /profile/user/wow/collections/heirlooms`.
class AccountHeirloomsCollectionResponse extends ApiModel {
  /// Creates an [AccountHeirloomsCollectionResponse] from its JSON object.
  AccountHeirloomsCollectionResponse(super.raw);

  /// The collected heirlooms, as raw JSON entries.
  List<Map<String, dynamic>> get heirlooms =>
      listOf<Map<String, dynamic>>('heirlooms', (Map<String, dynamic> h) => h);
}

/// Response of `GET /profile/user/wow/collections/transmogs`.
class AccountTransmogsCollectionResponse extends ApiModel {
  /// Creates an [AccountTransmogsCollectionResponse] from its JSON object.
  AccountTransmogsCollectionResponse(super.raw);

  /// The collected appearance sets.
  List<KeyedRef> get appearanceSets => refsOf('appearance_sets');

  /// The collected transmog slots, as raw JSON entries.
  List<Map<String, dynamic>> get slots =>
      listOf<Map<String, dynamic>>('slots', (Map<String, dynamic> s) => s);
}
