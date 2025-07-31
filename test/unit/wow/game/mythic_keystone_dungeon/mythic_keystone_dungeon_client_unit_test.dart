// test/unit/wow/game/mythic_keystone_dungeon/mythic_keystone_dungeon_client_unit_test.dart
import 'package:battle_net/src/constants/battle_net_locale.dart';
import 'package:battle_net/src/constants/battle_net_namespace.dart';
import 'package:battle_net/src/constants/battle_net_region.dart';
import 'package:battle_net/src/logger/log_level.dart';
import 'package:battle_net/src/logger/logger.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_period_response.dart';
import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/models/mythic_keystone_periods_index_response.dart';

import 'package:battle_net/src/wow/game/mythic_keystone_dungeon/mythic_keystone_dungeon_client.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

const String sampleMythicKeystonePeriodsIndexJson = '''
{
    "_links": {
        "self": {
            "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/?namespace=dynamic-eu"
        }
    },
    "periods": [
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/641?namespace=dynamic-eu"
            },
            "id": 641
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/642?namespace=dynamic-eu"
            },
            "id": 642
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/643?namespace=dynamic-eu"
            },
            "id": 643
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/644?namespace=dynamic-eu"
            },
            "id": 644
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/645?namespace=dynamic-eu"
            },
            "id": 645
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/646?namespace=dynamic-eu"
            },
            "id": 646
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/647?namespace=dynamic-eu"
            },
            "id": 647
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/648?namespace=dynamic-eu"
            },
            "id": 648
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/649?namespace=dynamic-eu"
            },
            "id": 649
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/650?namespace=dynamic-eu"
            },
            "id": 650
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/651?namespace=dynamic-eu"
            },
            "id": 651
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/652?namespace=dynamic-eu"
            },
            "id": 652
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/653?namespace=dynamic-eu"
            },
            "id": 653
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/654?namespace=dynamic-eu"
            },
            "id": 654
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/655?namespace=dynamic-eu"
            },
            "id": 655
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/656?namespace=dynamic-eu"
            },
            "id": 656
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/657?namespace=dynamic-eu"
            },
            "id": 657
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/658?namespace=dynamic-eu"
            },
            "id": 658
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/659?namespace=dynamic-eu"
            },
            "id": 659
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/660?namespace=dynamic-eu"
            },
            "id": 660
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/661?namespace=dynamic-eu"
            },
            "id": 661
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/662?namespace=dynamic-eu"
            },
            "id": 662
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/663?namespace=dynamic-eu"
            },
            "id": 663
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/664?namespace=dynamic-eu"
            },
            "id": 664
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/665?namespace=dynamic-eu"
            },
            "id": 665
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/666?namespace=dynamic-eu"
            },
            "id": 666
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/667?namespace=dynamic-eu"
            },
            "id": 667
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/668?namespace=dynamic-eu"
            },
            "id": 668
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/669?namespace=dynamic-eu"
            },
            "id": 669
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/670?namespace=dynamic-eu"
            },
            "id": 670
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/671?namespace=dynamic-eu"
            },
            "id": 671
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/672?namespace=dynamic-eu"
            },
            "id": 672
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/673?namespace=dynamic-eu"
            },
            "id": 673
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/674?namespace=dynamic-eu"
            },
            "id": 674
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/675?namespace=dynamic-eu"
            },
            "id": 675
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/676?namespace=dynamic-eu"
            },
            "id": 676
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/677?namespace=dynamic-eu"
            },
            "id": 677
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/678?namespace=dynamic-eu"
            },
            "id": 678
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/679?namespace=dynamic-eu"
            },
            "id": 679
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/680?namespace=dynamic-eu"
            },
            "id": 680
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/681?namespace=dynamic-eu"
            },
            "id": 681
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/682?namespace=dynamic-eu"
            },
            "id": 682
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/683?namespace=dynamic-eu"
            },
            "id": 683
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/684?namespace=dynamic-eu"
            },
            "id": 684
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/685?namespace=dynamic-eu"
            },
            "id": 685
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/686?namespace=dynamic-eu"
            },
            "id": 686
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/687?namespace=dynamic-eu"
            },
            "id": 687
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/688?namespace=dynamic-eu"
            },
            "id": 688
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/689?namespace=dynamic-eu"
            },
            "id": 689
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/690?namespace=dynamic-eu"
            },
            "id": 690
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/691?namespace=dynamic-eu"
            },
            "id": 691
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/692?namespace=dynamic-eu"
            },
            "id": 692
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/693?namespace=dynamic-eu"
            },
            "id": 693
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/694?namespace=dynamic-eu"
            },
            "id": 694
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/695?namespace=dynamic-eu"
            },
            "id": 695
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/696?namespace=dynamic-eu"
            },
            "id": 696
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/697?namespace=dynamic-eu"
            },
            "id": 697
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/698?namespace=dynamic-eu"
            },
            "id": 698
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/699?namespace=dynamic-eu"
            },
            "id": 699
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/700?namespace=dynamic-eu"
            },
            "id": 700
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/701?namespace=dynamic-eu"
            },
            "id": 701
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/702?namespace=dynamic-eu"
            },
            "id": 702
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/703?namespace=dynamic-eu"
            },
            "id": 703
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/704?namespace=dynamic-eu"
            },
            "id": 704
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/705?namespace=dynamic-eu"
            },
            "id": 705
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/706?namespace=dynamic-eu"
            },
            "id": 706
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/707?namespace=dynamic-eu"
            },
            "id": 707
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/708?namespace=dynamic-eu"
            },
            "id": 708
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/709?namespace=dynamic-eu"
            },
            "id": 709
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/710?namespace=dynamic-eu"
            },
            "id": 710
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/711?namespace=dynamic-eu"
            },
            "id": 711
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/712?namespace=dynamic-eu"
            },
            "id": 712
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/713?namespace=dynamic-eu"
            },
            "id": 713
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/714?namespace=dynamic-eu"
            },
            "id": 714
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/715?namespace=dynamic-eu"
            },
            "id": 715
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/716?namespace=dynamic-eu"
            },
            "id": 716
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/717?namespace=dynamic-eu"
            },
            "id": 717
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/718?namespace=dynamic-eu"
            },
            "id": 718
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/719?namespace=dynamic-eu"
            },
            "id": 719
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/720?namespace=dynamic-eu"
            },
            "id": 720
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/721?namespace=dynamic-eu"
            },
            "id": 721
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/722?namespace=dynamic-eu"
            },
            "id": 722
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/723?namespace=dynamic-eu"
            },
            "id": 723
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/724?namespace=dynamic-eu"
            },
            "id": 724
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/725?namespace=dynamic-eu"
            },
            "id": 725
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/726?namespace=dynamic-eu"
            },
            "id": 726
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/727?namespace=dynamic-eu"
            },
            "id": 727
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/728?namespace=dynamic-eu"
            },
            "id": 728
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/729?namespace=dynamic-eu"
            },
            "id": 729
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/730?namespace=dynamic-eu"
            },
            "id": 730
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/731?namespace=dynamic-eu"
            },
            "id": 731
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/732?namespace=dynamic-eu"
            },
            "id": 732
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/733?namespace=dynamic-eu"
            },
            "id": 733
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/734?namespace=dynamic-eu"
            },
            "id": 734
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/735?namespace=dynamic-eu"
            },
            "id": 735
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/736?namespace=dynamic-eu"
            },
            "id": 736
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/737?namespace=dynamic-eu"
            },
            "id": 737
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/738?namespace=dynamic-eu"
            },
            "id": 738
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/739?namespace=dynamic-eu"
            },
            "id": 739
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/740?namespace=dynamic-eu"
            },
            "id": 740
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/741?namespace=dynamic-eu"
            },
            "id": 741
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/742?namespace=dynamic-eu"
            },
            "id": 742
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/743?namespace=dynamic-eu"
            },
            "id": 743
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/744?namespace=dynamic-eu"
            },
            "id": 744
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/745?namespace=dynamic-eu"
            },
            "id": 745
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/746?namespace=dynamic-eu"
            },
            "id": 746
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/747?namespace=dynamic-eu"
            },
            "id": 747
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/748?namespace=dynamic-eu"
            },
            "id": 748
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/749?namespace=dynamic-eu"
            },
            "id": 749
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/750?namespace=dynamic-eu"
            },
            "id": 750
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/751?namespace=dynamic-eu"
            },
            "id": 751
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/752?namespace=dynamic-eu"
            },
            "id": 752
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/753?namespace=dynamic-eu"
            },
            "id": 753
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/754?namespace=dynamic-eu"
            },
            "id": 754
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/755?namespace=dynamic-eu"
            },
            "id": 755
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/756?namespace=dynamic-eu"
            },
            "id": 756
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/757?namespace=dynamic-eu"
            },
            "id": 757
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/758?namespace=dynamic-eu"
            },
            "id": 758
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/759?namespace=dynamic-eu"
            },
            "id": 759
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/760?namespace=dynamic-eu"
            },
            "id": 760
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/761?namespace=dynamic-eu"
            },
            "id": 761
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/762?namespace=dynamic-eu"
            },
            "id": 762
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/763?namespace=dynamic-eu"
            },
            "id": 763
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/764?namespace=dynamic-eu"
            },
            "id": 764
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/765?namespace=dynamic-eu"
            },
            "id": 765
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/766?namespace=dynamic-eu"
            },
            "id": 766
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/767?namespace=dynamic-eu"
            },
            "id": 767
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/768?namespace=dynamic-eu"
            },
            "id": 768
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/769?namespace=dynamic-eu"
            },
            "id": 769
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/770?namespace=dynamic-eu"
            },
            "id": 770
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/771?namespace=dynamic-eu"
            },
            "id": 771
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/772?namespace=dynamic-eu"
            },
            "id": 772
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/773?namespace=dynamic-eu"
            },
            "id": 773
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/774?namespace=dynamic-eu"
            },
            "id": 774
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/775?namespace=dynamic-eu"
            },
            "id": 775
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/776?namespace=dynamic-eu"
            },
            "id": 776
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/777?namespace=dynamic-eu"
            },
            "id": 777
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/778?namespace=dynamic-eu"
            },
            "id": 778
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/779?namespace=dynamic-eu"
            },
            "id": 779
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/780?namespace=dynamic-eu"
            },
            "id": 780
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/781?namespace=dynamic-eu"
            },
            "id": 781
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/782?namespace=dynamic-eu"
            },
            "id": 782
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/783?namespace=dynamic-eu"
            },
            "id": 783
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/784?namespace=dynamic-eu"
            },
            "id": 784
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/785?namespace=dynamic-eu"
            },
            "id": 785
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/786?namespace=dynamic-eu"
            },
            "id": 786
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/787?namespace=dynamic-eu"
            },
            "id": 787
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/788?namespace=dynamic-eu"
            },
            "id": 788
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/789?namespace=dynamic-eu"
            },
            "id": 789
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/790?namespace=dynamic-eu"
            },
            "id": 790
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/791?namespace=dynamic-eu"
            },
            "id": 791
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/792?namespace=dynamic-eu"
            },
            "id": 792
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/793?namespace=dynamic-eu"
            },
            "id": 793
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/794?namespace=dynamic-eu"
            },
            "id": 794
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/795?namespace=dynamic-eu"
            },
            "id": 795
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/796?namespace=dynamic-eu"
            },
            "id": 796
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/797?namespace=dynamic-eu"
            },
            "id": 797
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/798?namespace=dynamic-eu"
            },
            "id": 798
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/799?namespace=dynamic-eu"
            },
            "id": 799
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/800?namespace=dynamic-eu"
            },
            "id": 800
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/801?namespace=dynamic-eu"
            },
            "id": 801
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/802?namespace=dynamic-eu"
            },
            "id": 802
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/803?namespace=dynamic-eu"
            },
            "id": 803
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/804?namespace=dynamic-eu"
            },
            "id": 804
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/805?namespace=dynamic-eu"
            },
            "id": 805
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/806?namespace=dynamic-eu"
            },
            "id": 806
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/807?namespace=dynamic-eu"
            },
            "id": 807
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/808?namespace=dynamic-eu"
            },
            "id": 808
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/809?namespace=dynamic-eu"
            },
            "id": 809
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/810?namespace=dynamic-eu"
            },
            "id": 810
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/811?namespace=dynamic-eu"
            },
            "id": 811
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/812?namespace=dynamic-eu"
            },
            "id": 812
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/813?namespace=dynamic-eu"
            },
            "id": 813
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/814?namespace=dynamic-eu"
            },
            "id": 814
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/815?namespace=dynamic-eu"
            },
            "id": 815
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/816?namespace=dynamic-eu"
            },
            "id": 816
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/817?namespace=dynamic-eu"
            },
            "id": 817
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/818?namespace=dynamic-eu"
            },
            "id": 818
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/819?namespace=dynamic-eu"
            },
            "id": 819
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/820?namespace=dynamic-eu"
            },
            "id": 820
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/821?namespace=dynamic-eu"
            },
            "id": 821
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/822?namespace=dynamic-eu"
            },
            "id": 822
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/823?namespace=dynamic-eu"
            },
            "id": 823
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/824?namespace=dynamic-eu"
            },
            "id": 824
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/825?namespace=dynamic-eu"
            },
            "id": 825
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/826?namespace=dynamic-eu"
            },
            "id": 826
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/827?namespace=dynamic-eu"
            },
            "id": 827
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/828?namespace=dynamic-eu"
            },
            "id": 828
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/829?namespace=dynamic-eu"
            },
            "id": 829
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/830?namespace=dynamic-eu"
            },
            "id": 830
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/831?namespace=dynamic-eu"
            },
            "id": 831
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/832?namespace=dynamic-eu"
            },
            "id": 832
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/833?namespace=dynamic-eu"
            },
            "id": 833
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/834?namespace=dynamic-eu"
            },
            "id": 834
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/835?namespace=dynamic-eu"
            },
            "id": 835
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/836?namespace=dynamic-eu"
            },
            "id": 836
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/837?namespace=dynamic-eu"
            },
            "id": 837
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/838?namespace=dynamic-eu"
            },
            "id": 838
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/839?namespace=dynamic-eu"
            },
            "id": 839
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/840?namespace=dynamic-eu"
            },
            "id": 840
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/841?namespace=dynamic-eu"
            },
            "id": 841
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/842?namespace=dynamic-eu"
            },
            "id": 842
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/843?namespace=dynamic-eu"
            },
            "id": 843
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/844?namespace=dynamic-eu"
            },
            "id": 844
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/845?namespace=dynamic-eu"
            },
            "id": 845
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/846?namespace=dynamic-eu"
            },
            "id": 846
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/847?namespace=dynamic-eu"
            },
            "id": 847
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/848?namespace=dynamic-eu"
            },
            "id": 848
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/849?namespace=dynamic-eu"
            },
            "id": 849
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/850?namespace=dynamic-eu"
            },
            "id": 850
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/851?namespace=dynamic-eu"
            },
            "id": 851
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/852?namespace=dynamic-eu"
            },
            "id": 852
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/853?namespace=dynamic-eu"
            },
            "id": 853
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/854?namespace=dynamic-eu"
            },
            "id": 854
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/855?namespace=dynamic-eu"
            },
            "id": 855
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/856?namespace=dynamic-eu"
            },
            "id": 856
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/857?namespace=dynamic-eu"
            },
            "id": 857
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/858?namespace=dynamic-eu"
            },
            "id": 858
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/859?namespace=dynamic-eu"
            },
            "id": 859
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/860?namespace=dynamic-eu"
            },
            "id": 860
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/861?namespace=dynamic-eu"
            },
            "id": 861
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/862?namespace=dynamic-eu"
            },
            "id": 862
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/863?namespace=dynamic-eu"
            },
            "id": 863
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/864?namespace=dynamic-eu"
            },
            "id": 864
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/865?namespace=dynamic-eu"
            },
            "id": 865
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/866?namespace=dynamic-eu"
            },
            "id": 866
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/867?namespace=dynamic-eu"
            },
            "id": 867
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/868?namespace=dynamic-eu"
            },
            "id": 868
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/869?namespace=dynamic-eu"
            },
            "id": 869
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/870?namespace=dynamic-eu"
            },
            "id": 870
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/871?namespace=dynamic-eu"
            },
            "id": 871
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/872?namespace=dynamic-eu"
            },
            "id": 872
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/873?namespace=dynamic-eu"
            },
            "id": 873
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/874?namespace=dynamic-eu"
            },
            "id": 874
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/875?namespace=dynamic-eu"
            },
            "id": 875
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/876?namespace=dynamic-eu"
            },
            "id": 876
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/877?namespace=dynamic-eu"
            },
            "id": 877
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/878?namespace=dynamic-eu"
            },
            "id": 878
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/879?namespace=dynamic-eu"
            },
            "id": 879
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/880?namespace=dynamic-eu"
            },
            "id": 880
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/881?namespace=dynamic-eu"
            },
            "id": 881
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/882?namespace=dynamic-eu"
            },
            "id": 882
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/883?namespace=dynamic-eu"
            },
            "id": 883
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/884?namespace=dynamic-eu"
            },
            "id": 884
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/885?namespace=dynamic-eu"
            },
            "id": 885
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/886?namespace=dynamic-eu"
            },
            "id": 886
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/887?namespace=dynamic-eu"
            },
            "id": 887
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/888?namespace=dynamic-eu"
            },
            "id": 888
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/889?namespace=dynamic-eu"
            },
            "id": 889
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/890?namespace=dynamic-eu"
            },
            "id": 890
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/891?namespace=dynamic-eu"
            },
            "id": 891
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/892?namespace=dynamic-eu"
            },
            "id": 892
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/893?namespace=dynamic-eu"
            },
            "id": 893
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/894?namespace=dynamic-eu"
            },
            "id": 894
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/895?namespace=dynamic-eu"
            },
            "id": 895
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/896?namespace=dynamic-eu"
            },
            "id": 896
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/897?namespace=dynamic-eu"
            },
            "id": 897
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/898?namespace=dynamic-eu"
            },
            "id": 898
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/899?namespace=dynamic-eu"
            },
            "id": 899
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/900?namespace=dynamic-eu"
            },
            "id": 900
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/901?namespace=dynamic-eu"
            },
            "id": 901
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/902?namespace=dynamic-eu"
            },
            "id": 902
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/903?namespace=dynamic-eu"
            },
            "id": 903
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/904?namespace=dynamic-eu"
            },
            "id": 904
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/905?namespace=dynamic-eu"
            },
            "id": 905
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/906?namespace=dynamic-eu"
            },
            "id": 906
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/907?namespace=dynamic-eu"
            },
            "id": 907
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/908?namespace=dynamic-eu"
            },
            "id": 908
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/909?namespace=dynamic-eu"
            },
            "id": 909
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/910?namespace=dynamic-eu"
            },
            "id": 910
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/911?namespace=dynamic-eu"
            },
            "id": 911
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/912?namespace=dynamic-eu"
            },
            "id": 912
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/913?namespace=dynamic-eu"
            },
            "id": 913
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/914?namespace=dynamic-eu"
            },
            "id": 914
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/915?namespace=dynamic-eu"
            },
            "id": 915
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/916?namespace=dynamic-eu"
            },
            "id": 916
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/917?namespace=dynamic-eu"
            },
            "id": 917
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/918?namespace=dynamic-eu"
            },
            "id": 918
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/919?namespace=dynamic-eu"
            },
            "id": 919
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/920?namespace=dynamic-eu"
            },
            "id": 920
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/921?namespace=dynamic-eu"
            },
            "id": 921
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/922?namespace=dynamic-eu"
            },
            "id": 922
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/923?namespace=dynamic-eu"
            },
            "id": 923
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/924?namespace=dynamic-eu"
            },
            "id": 924
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/925?namespace=dynamic-eu"
            },
            "id": 925
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/926?namespace=dynamic-eu"
            },
            "id": 926
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/927?namespace=dynamic-eu"
            },
            "id": 927
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/928?namespace=dynamic-eu"
            },
            "id": 928
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/929?namespace=dynamic-eu"
            },
            "id": 929
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/930?namespace=dynamic-eu"
            },
            "id": 930
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/931?namespace=dynamic-eu"
            },
            "id": 931
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/932?namespace=dynamic-eu"
            },
            "id": 932
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/933?namespace=dynamic-eu"
            },
            "id": 933
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/934?namespace=dynamic-eu"
            },
            "id": 934
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/935?namespace=dynamic-eu"
            },
            "id": 935
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/936?namespace=dynamic-eu"
            },
            "id": 936
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/937?namespace=dynamic-eu"
            },
            "id": 937
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/938?namespace=dynamic-eu"
            },
            "id": 938
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/939?namespace=dynamic-eu"
            },
            "id": 939
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/940?namespace=dynamic-eu"
            },
            "id": 940
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/941?namespace=dynamic-eu"
            },
            "id": 941
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/942?namespace=dynamic-eu"
            },
            "id": 942
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/943?namespace=dynamic-eu"
            },
            "id": 943
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/944?namespace=dynamic-eu"
            },
            "id": 944
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/945?namespace=dynamic-eu"
            },
            "id": 945
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/946?namespace=dynamic-eu"
            },
            "id": 946
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/947?namespace=dynamic-eu"
            },
            "id": 947
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/948?namespace=dynamic-eu"
            },
            "id": 948
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/949?namespace=dynamic-eu"
            },
            "id": 949
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/950?namespace=dynamic-eu"
            },
            "id": 950
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/951?namespace=dynamic-eu"
            },
            "id": 951
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/952?namespace=dynamic-eu"
            },
            "id": 952
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/953?namespace=dynamic-eu"
            },
            "id": 953
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/954?namespace=dynamic-eu"
            },
            "id": 954
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/955?namespace=dynamic-eu"
            },
            "id": 955
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/956?namespace=dynamic-eu"
            },
            "id": 956
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/957?namespace=dynamic-eu"
            },
            "id": 957
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/958?namespace=dynamic-eu"
            },
            "id": 958
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/959?namespace=dynamic-eu"
            },
            "id": 959
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/960?namespace=dynamic-eu"
            },
            "id": 960
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/961?namespace=dynamic-eu"
            },
            "id": 961
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/962?namespace=dynamic-eu"
            },
            "id": 962
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/963?namespace=dynamic-eu"
            },
            "id": 963
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/964?namespace=dynamic-eu"
            },
            "id": 964
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/965?namespace=dynamic-eu"
            },
            "id": 965
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/966?namespace=dynamic-eu"
            },
            "id": 966
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/967?namespace=dynamic-eu"
            },
            "id": 967
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/968?namespace=dynamic-eu"
            },
            "id": 968
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/969?namespace=dynamic-eu"
            },
            "id": 969
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/970?namespace=dynamic-eu"
            },
            "id": 970
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/971?namespace=dynamic-eu"
            },
            "id": 971
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/972?namespace=dynamic-eu"
            },
            "id": 972
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/973?namespace=dynamic-eu"
            },
            "id": 973
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/974?namespace=dynamic-eu"
            },
            "id": 974
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/975?namespace=dynamic-eu"
            },
            "id": 975
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/976?namespace=dynamic-eu"
            },
            "id": 976
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/977?namespace=dynamic-eu"
            },
            "id": 977
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/978?namespace=dynamic-eu"
            },
            "id": 978
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/979?namespace=dynamic-eu"
            },
            "id": 979
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/980?namespace=dynamic-eu"
            },
            "id": 980
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/981?namespace=dynamic-eu"
            },
            "id": 981
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/982?namespace=dynamic-eu"
            },
            "id": 982
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/983?namespace=dynamic-eu"
            },
            "id": 983
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/984?namespace=dynamic-eu"
            },
            "id": 984
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/985?namespace=dynamic-eu"
            },
            "id": 985
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/986?namespace=dynamic-eu"
            },
            "id": 986
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/987?namespace=dynamic-eu"
            },
            "id": 987
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/988?namespace=dynamic-eu"
            },
            "id": 988
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/989?namespace=dynamic-eu"
            },
            "id": 989
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/990?namespace=dynamic-eu"
            },
            "id": 990
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/991?namespace=dynamic-eu"
            },
            "id": 991
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/992?namespace=dynamic-eu"
            },
            "id": 992
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/993?namespace=dynamic-eu"
            },
            "id": 993
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/994?namespace=dynamic-eu"
            },
            "id": 994
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/995?namespace=dynamic-eu"
            },
            "id": 995
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/996?namespace=dynamic-eu"
            },
            "id": 996
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/997?namespace=dynamic-eu"
            },
            "id": 997
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/998?namespace=dynamic-eu"
            },
            "id": 998
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/999?namespace=dynamic-eu"
            },
            "id": 999
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1000?namespace=dynamic-eu"
            },
            "id": 1000
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1001?namespace=dynamic-eu"
            },
            "id": 1001
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1002?namespace=dynamic-eu"
            },
            "id": 1002
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1003?namespace=dynamic-eu"
            },
            "id": 1003
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1004?namespace=dynamic-eu"
            },
            "id": 1004
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1005?namespace=dynamic-eu"
            },
            "id": 1005
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1006?namespace=dynamic-eu"
            },
            "id": 1006
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1007?namespace=dynamic-eu"
            },
            "id": 1007
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1008?namespace=dynamic-eu"
            },
            "id": 1008
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1009?namespace=dynamic-eu"
            },
            "id": 1009
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1010?namespace=dynamic-eu"
            },
            "id": 1010
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1011?namespace=dynamic-eu"
            },
            "id": 1011
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1012?namespace=dynamic-eu"
            },
            "id": 1012
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1013?namespace=dynamic-eu"
            },
            "id": 1013
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1014?namespace=dynamic-eu"
            },
            "id": 1014
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1015?namespace=dynamic-eu"
            },
            "id": 1015
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1016?namespace=dynamic-eu"
            },
            "id": 1016
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1017?namespace=dynamic-eu"
            },
            "id": 1017
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1018?namespace=dynamic-eu"
            },
            "id": 1018
        },
        {
            "key": {
                "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1019?namespace=dynamic-eu"
            },
            "id": 1019
        }
    ],
    "current_period": {
        "key": {
            "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1019?namespace=dynamic-eu"
        },
        "id": 1019
    }
}
''';

const String sampleMythicKeystonePeriodJson = '''
{
    "_links": {
        "self": {
            "href": "https://eu.api.blizzard.com/data/wow/mythic-keystone/period/1019?namespace=dynamic-eu"
        }
    },
    "id": 1019,
    "start_timestamp": 1600000000000,
    "end_timestamp": 1752638399000
}
''';

void main() {
  group('MythicKeystoneDungeonClient Unit Tests', () {
    late MythicKeystoneDungeonClient dungeonClient;
    late MockClient mockHttpClient;

    const String accessToken = 'dummy_access_token';
    const BattleNetRegion region = BattleNetRegion.us;
    const BattleNetLocale locale = BattleNetLocale.enUS;
    const int connectionTimeout = 5000;

    setUp(() {
      // MockClient will be created with a handler in each test
      Logger.init(logLevel: LogLevel.NONE, enableReleaseLogging: false);
    });

    // --- Tests for getMythicKeystonePeriodsIndex ---
    test('getMythicKeystonePeriodsIndex - success', () async {
      mockHttpClient = MockClient((http.Request request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/data/wow/mythic-keystone/period/index');
        return http.Response(
          sampleMythicKeystonePeriodsIndexJson,
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      dungeonClient = MythicKeystoneDungeonClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );

      final MythicKeystonePeriodsIndexResponse result = await dungeonClient
          .getMythicKeystonePeriodsIndex(
            accessToken: accessToken,
            region: region,
            namespace: BattleNetNamespace.dynamic,
            locale: locale,
          );
      expect(result.periods, isNotEmpty);
      expect(result.periods.length, 379);
      expect(result.currentPeriod.id, 1019);
    });

    test('getMythicKeystonePeriodsIndex - API error', () async {
      mockHttpClient = MockClient((http.Request request) async {
        return http.Response('{"error":"failed"}', 500);
      });
      dungeonClient = MythicKeystoneDungeonClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );
      expect(
        () => dungeonClient.getMythicKeystonePeriodsIndex(
          accessToken: accessToken,
          region: region,
          namespace: BattleNetNamespace.dynamic,
          locale: locale,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // --- Tests for getMythicKeystonePeriod ---
    test('getMythicKeystonePeriod - success', () async {
      mockHttpClient = MockClient((http.Request request) async {
        expect(request.url.path, '/data/wow/mythic-keystone/period/1');
        return http.Response(
          sampleMythicKeystonePeriodJson,
          200,
          headers: <String, String>{'content-type': 'application/json'},
        );
      });
      dungeonClient = MythicKeystoneDungeonClient(
        connectionTimeout: connectionTimeout,
        client: mockHttpClient,
      );

      final MythicKeystonePeriodResponse result = await dungeonClient
          .getMythicKeystonePeriod(
            accessToken: accessToken,
            region: region,
            namespace: BattleNetNamespace.dynamic,
            locale: locale,
            periodId: 1,
          );
      expect(result.id, 1019);
      expect(
        result.startTime,
        DateTime.fromMillisecondsSinceEpoch(1600000000000, isUtc: true),
      );
    });
  });
}
