/// Class required to describe typed values
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((String k, T v) => MapEntry<T, String>(v, k));
    return reverseMap;
  }
}
