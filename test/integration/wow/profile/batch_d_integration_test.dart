import 'dart:io';

import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

import '../../credentials.dart';

void main() {
  final BattleNet battleNet = BattleNet(
    clientId: clientId,
    clientSecret: clientSecret,
    logLevel: LogLevel.NONE,
    enableReleaseLogging: false,
  );

  late String token;

  setUpAll(() async {
    final ClientCredentialsResponse creds = await battleNet
        .postClientCredentials();
    token = creds.accessToken;
  });

  group('Batch D Live Integration Smoke Tests (EU)', () {
    const BattleNetRegion region = BattleNetRegion.eu;
    const BattleNetLocale locale = BattleNetLocale.enGB;
    const String realmSlug = 'ravencrest';
    const String characterName = 'rinox';
    const String guildSlug = 'viysko-nightelfiyske';

    test('Character Profile endpoints (ravencrest/rinox)', () async {
      final CharacterProfileResponse profile = await battleNet.wow.character
          .getCharacterProfile(
            accessToken: token,
            region: region,
            locale: locale,
            realmSlug: realmSlug,
            characterName: characterName,
          );
      expect(profile.name?.toLowerCase(), characterName);

      expect(
        (await battleNet.wow.character.getCharacterProfileStatus(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).isValid,
        isTrue,
      );
      expect(
        (await battleNet.wow.character.getCharacterAchievements(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).achievements,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.character.getCharacterEquipment(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).equippedItems,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.character.getCharacterMedia(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).assets,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.character.getCharacterSpecializations(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).specializations,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.character.getCharacterStatistics(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).health,
        isNotNull,
      );
      expect(
        (await battleNet.wow.character.getCharacterTitles(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          characterName: characterName,
        )).titles,
        isNotEmpty,
      );
    });

    test('Guild endpoints (ravencrest/viysko-nightelfiyske)', () async {
      final GuildResponse guild = await battleNet.wow.guild.getGuild(
        accessToken: token,
        region: region,
        locale: locale,
        realmSlug: realmSlug,
        nameSlug: guildSlug,
      );
      expect(guild.id, isNotNull);

      expect(
        (await battleNet.wow.guild.getGuildActivity(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          nameSlug: guildSlug,
        )).guild,
        isNotNull,
      );
      expect(
        (await battleNet.wow.guild.getGuildAchievements(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          nameSlug: guildSlug,
        )).achievements,
        isNotEmpty,
      );
      expect(
        (await battleNet.wow.guild.getGuildRoster(
          accessToken: token,
          region: region,
          locale: locale,
          realmSlug: realmSlug,
          nameSlug: guildSlug,
        )).members,
        isNotEmpty,
      );
    });

    test(
      'Account Profile (skipped unless USER_ACCESS_TOKEN env var is set)',
      () async {
        final String? userToken = Platform.environment['USER_ACCESS_TOKEN'];
        if (userToken == null || userToken.isEmpty) {
          markTestSkipped('USER_ACCESS_TOKEN not set');
          return;
        }
        final AccountProfileResponse acc = await battleNet.wow.account
            .getAccountProfile(
              accessToken: userToken,
              region: region,
              locale: locale,
            );
        expect(acc.wowAccounts, isNotEmpty);
      },
    );
  });
}
