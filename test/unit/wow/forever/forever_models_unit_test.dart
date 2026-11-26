import 'package:battle_net/battle_net.dart';
import 'package:test/test.dart';

/// Builds two equal instances and verifies value semantics.
void checkValue<T extends Object>(T Function() make) {
  final T a = make();
  final T b = make();
  expect(identical(a, b), isFalse);
  expect(a, equals(b));
  expect(a.hashCode, b.hashCode);
  expect(a.toString(), isNotEmpty);
  expect(a == Object(), isFalse);
  expect(a == a, isTrue);
}

void main() {
  group('Forever character models', () {
    test('ForeverCharacterProfileResponse', () {
      const String raw =
          '{"slug":"ada-brightwood","name":"Ada","surname":"Brightwood","level":60,'
          '"achievement_points":10,"gender":{"type":"MALE"},"race":{"id":1},'
          '"character_class":{"id":8}}';
      checkValue(() => ForeverCharacterProfileResponse.fromRawJson(raw));
      final ForeverCharacterProfileResponse p =
          ForeverCharacterProfileResponse.fromRawJson(raw);
      expect(p.gender, 0);
      expect(p.achievementPoints, 10);
      final ForeverCharacterProfileResponse empty =
          ForeverCharacterProfileResponse.fromRawJson('{}');
      expect(empty.slug, '');
      expect(empty.gender, isNull);
    });

    test('ForeverCharacterEquipmentResponse and ForeverEquippedItem', () {
      const String raw =
          '{"character":{"slug":"a-b"},"equipped_items":[{"item":{"id":1},'
          '"slot":{"type":"HEAD"},"name":"Helm","level":{"value":5}}]}';
      checkValue(() => ForeverCharacterEquipmentResponse.fromRawJson(raw));
      final ForeverCharacterEquipmentResponse r =
          ForeverCharacterEquipmentResponse.fromRawJson(raw);
      checkValue(
        () => ForeverEquippedItem.fromJson(const <String, dynamic>{
          'item': <String, dynamic>{'id': 1},
          'slot': <String, dynamic>{'type': 'HEAD'},
        }),
      );
      expect(r.equippedItems!.first.itemLevel, 5);
      expect(
        ForeverCharacterEquipmentResponse.fromRawJson('{}').equippedItems,
        isNull,
      );
    });

    test('ForeverCharacterMediaResponse and ForeverMediaAsset', () {
      const String raw =
          '{"character":{"slug":"a-b"},"assets":[{"key":"avatar","value":"u","file_data_id":1}]}';
      checkValue(() => ForeverCharacterMediaResponse.fromRawJson(raw));
      checkValue(
        () => ForeverMediaAsset.fromJson(const <String, dynamic>{
          'key': 'k',
          'value': 'v',
        }),
      );
      expect(ForeverCharacterMediaResponse.fromRawJson('{}').assets, isNull);
    });

    test('Achievements and statistics', () {
      checkValue(
        () => ForeverCharacterAchievementsResponse.fromRawJson(
          '{"total_points":5,"achievements":[{"id":1,"completed_timestamp":2}]}',
        ),
      );
      checkValue(
        () =>
            ForeverAchievementEntry.fromJson(const <String, dynamic>{'id': 1}),
      );
      checkValue(
        () => ForeverCharacterStatisticsResponse.fromRawJson(
          '{"total_quantity":1,"statistics":[{"id":1,"name":"n","quantity":3}]}',
        ),
      );
      checkValue(
        () => ForeverStatistic.fromJson(const <String, dynamic>{'id': 1}),
      );
    });

    test('Encounters', () {
      const String raw =
          '{"expansions":[{"expansion":{"id":1,"name":"Classic"},"instances":'
          '[{"instance":{"id":2,"name":"WC"},"modes":[{"progress":{"encounters":'
          '[{"encounter":{"id":3,"name":"Boss"},"completed_count":1,"last_kill_timestamp":9}]}}]}]}]}';
      checkValue(() => ForeverCharacterEncountersResponse.fromRawJson(raw));
      checkValue(
        () => ForeverEncounterMode.fromJson(const <String, dynamic>{
          'expansion': <String, dynamic>{'id': 1},
        }),
      );
      checkValue(
        () => ForeverDungeonEncounter.fromJson(const <String, dynamic>{
          'instance': <String, dynamic>{'id': 1},
        }),
      );
      checkValue(
        () => ForeverEncounterEntry.fromJson(const <String, dynamic>{
          'encounter': <String, dynamic>{'id': 1},
        }),
      );
    });

    test('PvP, quests, reputations', () {
      checkValue(
        () => ForeverCharacterPvpSummaryResponse.fromRawJson(
          '{"honor_level":1,"honorable_kills":2}',
        ),
      );
      checkValue(
        () => ForeverCharacterQuestsResponse.fromRawJson(
          '{"quests":[{"id":1,"title":"t"}]}',
        ),
      );
      checkValue(
        () => ForeverQuestEntry.fromJson(const <String, dynamic>{'id': 1}),
      );
      checkValue(
        () => ForeverCharacterReputationsResponse.fromRawJson(
          '{"reputations":[{"faction":{"id":1,"name":"f"},"standing":{"value":2}}]}',
        ),
      );
      checkValue(
        () => ForeverReputationEntry.fromJson(const <String, dynamic>{}),
      );
    });

    test('Professions', () {
      checkValue(
        () => ForeverCharacterProfessionsResponse.fromRawJson(
          '{"primaries":[{"profession":{"id":1,"name":"p"},"tiers":'
          '[{"skill_points":1,"max_skill_points":2}]}],"secondaries":[]}',
        ),
      );
      final ForeverProfessionEntry noTier = ForeverProfessionEntry.fromJson(
        const <String, dynamic>{},
      );
      expect(noTier.skillPoints, 0);
      checkValue(
        () => ForeverProfessionEntry.fromJson(const <String, dynamic>{}),
      );
    });

    test('Specializations, titles, collections', () {
      checkValue(
        () => ForeverCharacterSpecializationsResponse.fromRawJson(
          '{"active_specialization":{"id":1,"name":"s"},"specializations":'
          '[{"specialization":{"id":1,"name":"s"}}]}',
        ),
      );
      checkValue(() => ForeverSpecEntry.fromJson(const <String, dynamic>{}));
      checkValue(
        () => ForeverCharacterTitlesResponse.fromRawJson(
          '{"active_title":{"id":1},"titles":[{"id":1,"name":"n"}]}',
        ),
      );
      checkValue(
        () => ForeverTitleEntry.fromJson(const <String, dynamic>{'id': 1}),
      );
      checkValue(
        () => ForeverCharacterCollectionsResponse.fromRawJson(
          '{"mounts":[{"mount":{"id":1,"name":"m"}}],"pets":[{"species":{"id":2,"name":"p"}}]}',
        ),
      );
      checkValue(
        () => ForeverCollectionEntry.fromJson(const <String, dynamic>{
          'id': 1,
          'name': 'x',
        }),
      );
      expect(
        ForeverCharacterCollectionsResponse.fromRawJson('{}').pets,
        isNull,
      );
    });
  });

  group('Forever account, item and ruleset models', () {
    test('Account models', () {
      checkValue(
        () => ForeverAccountProfileResponse.fromRawJson(
          '{"wow_accounts":[{"id":1,"characters":[{"slug":"a-b","name":"A","level":1,'
          '"playable_class":{"id":1},"playable_race":{"id":2}}]}]}',
        ),
      );
      checkValue(
        () => ForeverWowAccount.fromJson(const <String, dynamic>{'id': 1}),
      );
      checkValue(
        () => ForeverAccountCharacter.fromJson(const <String, dynamic>{
          'slug': 's',
        }),
      );
    });

    test('ForeverItemResponse quality mapping', () {
      checkValue(
        () => ForeverItemResponse.fromRawJson(
          '{"id":1,"name":"n","quality":{"type":"EPIC"},"level":2,"required_level":3,'
          '"item_class":{"id":4},"item_subclass":{"id":5}}',
        ),
      );
      expect(
        ForeverItemResponse.fromRawJson('{"quality":{"type":"EPIC"}}').quality,
        4,
      );
      expect(
        ForeverItemResponse.fromRawJson('{"quality":{"type":"???"}}').quality,
        1,
      );
      expect(ForeverItemResponse.fromRawJson('{}').quality, isNull);
    });

    test('Ruleset models', () {
      checkValue(
        () => ForeverRulesetIndexResponse.fromRawJson(
          '{"rulesets":[{"id":1,"name":"n"}]}',
        ),
      );
      checkValue(
        () => ForeverRulesetRef.fromJson(const <String, dynamic>{'id': 1}),
      );
      checkValue(
        () => ForeverRulesetResponse.fromRawJson(
          '{"id":1,"name":"n","slug":"s","population":{"value":2}}',
        ),
      );
    });

    test('ForeverAuctionPageResponse pagination and ForeverAuctionItem', () {
      const String raw =
          '{"auctions":[{"id":1,"item":{"id":1}},{"id":2,"item":{"id":2}},{"id":3,"item":{"id":3}}]}';
      checkValue(
        () => ForeverAuctionPageResponse.fromRawJson(raw, pageSize: 2),
      );
      final ForeverAuctionPageResponse last =
          ForeverAuctionPageResponse.fromRawJson(raw, page: 2, pageSize: 2);
      expect(last.hasNextPage, isFalse);
      expect(last.auctions.length, 1);
      final ForeverAuctionPageResponse beyond =
          ForeverAuctionPageResponse.fromRawJson(raw, page: 9, pageSize: 2);
      expect(beyond.auctions, isEmpty);
      expect(ForeverAuctionPageResponse.fromRawJson('{}').totalAuctions, 0);
      checkValue(
        () => ForeverAuctionItem.fromJson(const <String, dynamic>{
          'id': 1,
          'item': <String, dynamic>{'id': 2},
          'quantity': 1,
          'unit_price': 2,
          'buyout': 3,
          'bid': 4,
          'time_left': 'LONG',
        }),
      );
    });
  });
}
