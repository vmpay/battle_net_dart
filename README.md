<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
Dart wrapper client for [Battle.Net API](https://develop.battle.net/documentation)

![workflow](https://github.com/vmpay/battle_net_dart/actions/workflows/main.yml/badge.svg)
[![codecov](https://codecov.io/github/vmpay/battle_net_dart/graph/badge.svg?token=H0S7UH54MS)](https://codecov.io/github/vmpay/battle_net_dart)
[![GitHub](https://img.shields.io/github/license/vmpay/battle_net_dart?color=salad&logo=github)](https://github.com/vmpay/battle_net_dart/blob/master/LICENSE)
[![Pub](https://img.shields.io/pub/v/battle_net.svg?logo=dart&logoColor=blue)](https://pub.dev/packages/battle_net)
[![package publisher](https://img.shields.io/pub/publisher/battle_net.svg?logo=dart&logoColor=blue)](https://pub.dev/packages/battle_net/publisher)
[![Pub Points](https://img.shields.io/pub/points/battle_net?logo=flutter&logoColor=lightblue)](https://pub.dev/packages/battle_net)

You can easily communicate with BattleNet service inside your Flutter/Dart application.   

## Code Quality

This library now boasts significantly increased unit and integration test coverage, ensuring the reliability and stability of the Battle.net API client. A continuous integration (CI/CD) pipeline is in place to enforce a minimum of 90% code coverage, automatically failing builds if this threshold is not met.

## Available Features

### [Battle.net OAuth APIs](https://develop.battle.net/documentation/battle-net/oauth-apis)

* User Authentication
  * Authorization Request - The authorization request is the first part of the authorization code flow, 
  OAuth's authentication flow for performing API requests on behalf of a user.
  * Access Token Request - The access token request is the second part of the authorization code flow.
  * User Info - Returns basic information about the user associated with the current bearer token.
* Application Authentication
  * Post Client Credentials - Access Token Request. This is the only request necessary for the client 
  credential flow, OAuth's authentication flow intended for application servers.
* Token Validation
  * Post Token Validation - Verifies that a given bearer token is valid and retrieves metadata
  about the token, including the **client_id** used to create the token, expiration timestamp,
  and scopes granted to the token.


### [World of Warcraft Game Data APIs](https://develop.battle.net/documentation/world-of-warcraft/game-data-apis)

* WoW Token API
  * Get Token Index - Returns the WoW Token index.
* Connected Realm API
  * Connected Realm - Returns a connected realm by ID.
  * Connected Realms Search - Performs a search of connected realms.
* Mythic Keystone Dungeon API
  * Get Mythic Keystone Periods Index - Returns an index of Mythic Keystone periods.
  * Get Mythic Keystone Period - Returns a Mythic Keystone period by ID.
* Mythic Keystone Affix API
  * Get Mythic Keystone Affixes Index - Returns an index of Mythic Keystone affixes.
  * Get Mythic Keystone Affix - Returns a Mythic Keystone affix by ID.
  * Get Mythic Keystone Affix Media - Returns media for a Mythic Keystone affix by ID.
* Realm & Region APIs (`battleNet.wow.realm`, `battleNet.wow.region`)
  * Realms Index, Realm, Realm Search, Connected Realms Index, Regions Index, Region.
* Auction House API (`battleNet.wow.auctionHouse`)
  * Connected Realm Auctions, Region Commodities.
* Item API (`battleNet.wow.item`)
  * Item Classes, Subclasses, Item Sets, Item, Item Media, Item Search.
* Profession API (`battleNet.wow.profession`)
  * Professions Index, Profession, Media, Skill Tier, Recipe, Recipe Media.
* Mythic Keystone & Raid Leaderboards (`battleNet.wow.mythicKeystoneLeaderboard`, `battleNet.wow.mythicRaidLeaderboard`)
  * Mythic Keystone Dungeon/Season/Index, Realm Mythic Leaderboards, Hall of Fame Raid Leaderboards.
* Core Reference Game Data (`battleNet.wow`):
  * `achievement`, `creature`, `journal`, `mount`, `pet`, `playableClass`, `playableRace`, `playableSpecialization`, `pvpSeason`, `pvpTier`, `quest`, `spell`, `talent`.

### World of Warcraft: Forever APIs

WoW: Forever is realmless: characters are identified by a `ForeverCharacterSlug` (`{name}-{surname}`, lowercase)
instead of a realm slug. Characters only appear in the API from level 10 and after they have logged out;
otherwise a `BattleNetNotFoundException` (`HTTP 404` / `BLZWEBAPI00000404`) is thrown.

* Character Profile APIs (`profile-forever-{region}` namespace)
  * Profile, Equipment, Media, Achievements, Achievement Statistics, Dungeon Encounters, PvP Summary,
  Completed Quests, Reputations, Professions, Specializations, Titles, Collections
* Account Profile API
  * Get Forever Account Profile - requires a user token with the `wow.profile` scope.
* Item API (`static-forever-{region}` namespace)
  * Get Item Data - Returns item data by ID.
* Ruleset API (`dynamic-forever-{region}` namespace)
  * Get Ruleset Index, Get Ruleset, Get Ruleset Auctions (client-side pagination).

### OAuth token refresh

* Refresh Access Token - exchanges a refresh token for a new access token.

## Getting started

Add to your pubspec.yaml the latest version of the library

```yaml
dependencies:
  battle_net: ^<latest_version>
```

Now in your Dart code, you can use:

```dart
import 'package:battle_net/battle_net.dart';
```

## Usage

Provide client id and client secret, which can be found in your developer account on [BattleNet](https://develop.battle.net/access/clients).

```dart
final BattleNet battleNet = 
  BattleNet(clientId: 'clientId', clientSecret: 'clientSecret');
```

Now you can fetch data from BattleNet services.

```dart
final ClientCredentialsResponse clientCredentialsResponse = 
    await battleNet.postClientCredentials();
```

### Get Token Index
You can fetch Retail WoW Token price in EU region using this example.

```dart
final TokenIndex tokenIndex = await battleNet.getTokenIndex(
    accessToken: clientCredentialsResponse.accessToken,
    region: BattleNetRegion.eu,
    namespace: BattleNetNamespace.dynamic,
    locale: BattleNetLocale.enGB);
```

### Connected Realm
You can also fetch connected realm details by id using the example below:

```dart
const int connectedRealmId = 1301;
final ConnectedRealmResponse connectedRealm = await battleNet.getConnectedRealm(
    accessToken: clientCredentialsResponse.accessToken,
    region: BattleNetRegion.eu,
    namespace: BattleNetNamespace.dynamic,
    id: connectedRealmId);
```

### Connected Realm Search
You can also fetch connected realm details by id using the example below:

```dart
final ConnectedRealmSearchResponse result = 
    await battleNet.getConnectedRealmSearch(
      accessToken: clientCredentialsResponse.accessToken,
      region: BattleNetRegion.eu,
      namespace: BattleNetNamespace.dynamic,
      statusType: ServerStatus.UP,
      realmsTimezone: RealmTimezone.EUROPE_PARIS,
      hasQueue: false,
      populationType: PopulationType.FULL,
      realmsIsTournament: false,
);
```

### Mythic Keystone Dungeon API

#### Get Mythic Keystone Periods Index

```dart
final MythicKeystonePeriodsIndexResponse mythicKeystonePeriodsIndex =
    await battleNet.getMythicKeystonePeriodsIndex(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  namespace: BattleNetNamespace.dynamic,
);
```

#### Get Mythic Keystone Period

```dart
const int periodId = 641; // Example period ID
final MythicKeystonePeriodResponse mythicKeystonePeriod =
    await battleNet.getMythicKeystonePeriod(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  namespace: BattleNetNamespace.dynamic,
  id: periodId,
);
```

### Mythic Keystone Affix API

#### Get Mythic Keystone Affixes Index

```dart
final MythicKeystoneAffixesIndexResponse mythicKeystoneAffixesIndex =
    await battleNet.getMythicKeystoneAffixesIndex(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  namespace: BattleNetNamespace.dynamic,
);
```

#### Get Mythic Keystone Affix

```dart
const int affixId = 1; // Example affix ID
final MythicKeystoneAffixResponse mythicKeystoneAffix =
    await battleNet.getMythicKeystoneAffix(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  namespace: BattleNetNamespace.dynamic,
  id: affixId,
);
```

#### Get Mythic Keystone Affix Media

```dart
final MythicKeystoneAffixMediaResponse mythicKeystoneAffixMedia =
    await battleNet.getMythicKeystoneAffixMedia(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  namespace: BattleNetNamespace.dynamic,
  id: affixId,
);
```

## Additional information

### Grouped sub-clients (`battleNet.wow`)

Newer WoW Game Data APIs are exposed through `battleNet.wow.<group>` with sensible default Retail namespaces:

```dart
final ItemResponse item = await battleNet.wow.item.getItem(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  locale: BattleNetLocale.enGB,
  itemId: 19019,
);

final AuctionsResponse auctions = await battleNet.wow.auctionHouse.getAuctions(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  locale: BattleNetLocale.enGB,
  connectedRealmId: 1301,
);
```

### WoW: Forever usage

```dart
final ForeverCharacterSlug slug =
    ForeverCharacterSlug(name: 'Ada', surname: 'Brightwood');

try {
  final ForeverCharacterProfileResponse profile =
      await battleNet.getForeverCharacterProfile(
    accessToken: clientCredentialsResponse.accessToken,
    region: BattleNetRegion.eu,
    locale: BattleNetLocale.enGB,
    slug: slug,
  );
} on BattleNetNotFoundException {
  // Character is below level 10, still online, or not yet propagated.
}

final ForeverItemResponse item = await battleNet.getItemData(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  locale: BattleNetLocale.enGB,
  itemId: 19019,
);

final ForeverAuctionPageResponse auctions =
    await battleNet.getForeverRulesetAuctions(
  accessToken: clientCredentialsResponse.accessToken,
  region: BattleNetRegion.eu,
  locale: BattleNetLocale.enGB,
  rulesetId: 1,
  page: 1,
  pageSize: 100,
);
print('${auctions.page}/${auctions.totalPages}, hasNext: ${auctions.hasNextPage}');
```

Account profile and token refresh (user token with `wow.profile` scope):

```dart
final AuthorizationCodeResponse refreshed =
    await battleNet.refreshAccessToken(refreshToken: 'refresh_token');
final ForeverAccountProfileResponse account =
    await battleNet.getForeverAccountProfile(
  accessToken: refreshed.accessToken,
  region: BattleNetRegion.eu,
  locale: BattleNetLocale.enGB,
);
```

### Available BattleNet regions

API data is limited to specific regions. BattleNet region is the region of the data to retrieve.
Locale support is limited to locations supported on Blizzard community game sites.

| Region | Data                     |
|--------|--------------------------|
| US     | Battle.net, WoW, D3, SC2 |
| EU     | Battle.net, WoW, D3, SC2 |
| KR     | Battle.net, WoW, D3, SC2 |
| TW     | Battle.net, WoW, D3, SC2 |

For example,
```dart
BattleNetRegion.eu
```

### Localization

All available API resources provide localized strings using BattleNetLocale parameter. Supported
locales vary from region to region and align with those supported on Blizzard community sites.

| Region        | Host                               | Available Locales                               |
|---------------|------------------------------------|-------------------------------------------------|
| North America | https://us.api.blizzard.com/       | en_US, es_MX, pt_BR                             |
| Europe        | https://eu.api.blizzard.com/       | en_GB, es_ES, fr_FR, ru_RU, de_DE, pt_PT, it_IT |
| Korea         | https://kr.api.blizzard.com/       | ko_KR                                           |
| Taiwan        | https://tw.api.blizzard.com/       | zh_TW                                           |

For example,
```dart
BattleNetLocale.enGB
```

### Copyright & License
This project follows MIT [license](https://github.com/vmpay/battle_net_dart/blob/master/LICENSE).
