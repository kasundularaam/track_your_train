class StringFormatter {
  static String capitalize({required String string}) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}
