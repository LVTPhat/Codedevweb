class Test {
  String? canNull; // null | ""
  late String notNull;

  String get() {
    return canNull!.replaceAll("from", "replace"); // canNull = null => null;
  }

  String get2() {
    return notNull.replaceAll("from", "replace");
  }
}
