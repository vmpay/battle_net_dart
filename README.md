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
