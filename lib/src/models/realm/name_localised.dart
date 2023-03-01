import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class NameLocalised {
  const NameLocalised({
    required this.itIt,
    required this.ruRu,
    required this.enGb,
    required this.zhTw,
    required this.koKr,
    required this.enUs,
    required this.esMx,
    required this.ptBr,
    required this.esEs,
    required this.zhCn,
    required this.frFr,
    required this.deDe,
  });

  final String? itIt;
  final String ruRu;
  final String enGb;
  final String zhTw;
  final String koKr;
  final String enUs;
  final String esMx;
  final String ptBr;
  final String esEs;
  final String zhCn;
  final String frFr;
  final String deDe;

  NameLocalised copyWith({
    String? itIt,
    String? ruRu,
    String? enGb,
    String? zhTw,
    String? koKr,
    String? enUs,
    String? esMx,
    String? ptBr,
    String? esEs,
    String? zhCn,
    String? frFr,
    String? deDe,
  }) =>
      NameLocalised(
        itIt: itIt ?? this.itIt,
        ruRu: ruRu ?? this.ruRu,
        enGb: enGb ?? this.enGb,
        zhTw: zhTw ?? this.zhTw,
        koKr: koKr ?? this.koKr,
        enUs: enUs ?? this.enUs,
        esMx: esMx ?? this.esMx,
        ptBr: ptBr ?? this.ptBr,
        esEs: esEs ?? this.esEs,
        zhCn: zhCn ?? this.zhCn,
        frFr: frFr ?? this.frFr,
        deDe: deDe ?? this.deDe,
      );

  factory NameLocalised.fromRawJson(String str) =>
      NameLocalised.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NameLocalised.fromJson(Map<String, dynamic> json) => NameLocalised(
        itIt: json['it_IT'],
        ruRu: json['ru_RU'],
        enGb: json['en_GB'],
        zhTw: json['zh_TW'],
        koKr: json['ko_KR'],
        enUs: json['en_US'],
        esMx: json['es_MX'],
        ptBr: json['pt_BR'],
        esEs: json['es_ES'],
        zhCn: json['zh_CN'],
        frFr: json['fr_FR'],
        deDe: json['de_DE'],
      );

  Map<String, dynamic> toJson() => {
        'it_IT': itIt,
        'ru_RU': ruRu,
        'en_GB': enGb,
        'zh_TW': zhTw,
        'ko_KR': koKr,
        'en_US': enUs,
        'es_MX': esMx,
        'pt_BR': ptBr,
        'es_ES': esEs,
        'zh_CN': zhCn,
        'fr_FR': frFr,
        'de_DE': deDe,
      };

  @override
  String toString() {
    return 'NameLocalised{itIt: $itIt, ruRu: $ruRu, enGb: $enGb, zhTw: $zhTw, koKr: $koKr, enUs: $enUs, esMx: $esMx, ptBr: $ptBr, esEs: $esEs, zhCn: $zhCn, frFr: $frFr, deDe: $deDe}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameLocalised &&
          runtimeType == other.runtimeType &&
          itIt == other.itIt &&
          ruRu == other.ruRu &&
          enGb == other.enGb &&
          zhTw == other.zhTw &&
          koKr == other.koKr &&
          enUs == other.enUs &&
          esMx == other.esMx &&
          ptBr == other.ptBr &&
          esEs == other.esEs &&
          zhCn == other.zhCn &&
          frFr == other.frFr &&
          deDe == other.deDe;

  @override
  int get hashCode =>
      itIt.hashCode ^
      ruRu.hashCode ^
      enGb.hashCode ^
      zhTw.hashCode ^
      koKr.hashCode ^
      enUs.hashCode ^
      esMx.hashCode ^
      ptBr.hashCode ^
      esEs.hashCode ^
      zhCn.hashCode ^
      frFr.hashCode ^
      deDe.hashCode;
}
