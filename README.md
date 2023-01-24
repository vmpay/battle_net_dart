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
![workflow](https://github.com/vmpay/battle_net_dart/actions/workflows/main.yml/badge.svg)
[![GitHub](https://img.shields.io/github/license/vmpay/battle_net_dart?color=salad&logo=github)](https://github.com/vmpay/battle_net_dart/blob/master/LICENSE)
[![Pub](https://img.shields.io/pub/v/battle_net.svg?logo=dart&logoColor=blue)](https://pub.dev/packages/battle_net)
[![package publisher](https://img.shields.io/pub/publisher/battle_net.svg?logo=dart&logoColor=blue)](https://pub.dev/packages/battle_net/publisher)
[![Pub Points](https://img.shields.io/pub/points/battle_net?logo=flutter&logoColor=lightblue)](https://pub.dev/packages/battle_net)


Dart wrapper client for [Battle.Net API](https://develop.battle.net/documentation). 
You can easily communicate with BattleNet service inside your Flutter/Dart application.   

## Available Features

* Post Client Credentials - Access Token Request. This is the only request necessary for the client 
credential flow, OAuth's authentication flow intended for application servers.
* Get Token Index - Returns the WoW Token index.

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
final BattleNet battleNet = BattleNet('clientId', 'clientSecret');
```

Now you can fetch data from BattleNet services. 

You can fetch Retail WoW Token price in EU region using this example.

```dart
final ClientCredentialsResponse clientCredentialsResponse =
    await battleNet.postClientCredentials(BattleNetRegion.eu);
final TokenIndex tokenIndex = await battleNet.getTokenIndex(
    clientCredentialsResponse.accessToken,
    BattleNetRegion.eu,
    BattleNetNamespace.dynamic,
    BattleNetLocale.enGB);
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
| CN     | Battle.net, WoW, D3, SC2 |

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
| China         | https://gateway.battlenet.com.cn/  | zh_CN                                           |

For example,
```dart
BattleNetLocale.enGB
```

### Copyright & License
This project follows MIT [license](https://github.com/vmpay/battle_net_dart/blob/master/LICENSE).
