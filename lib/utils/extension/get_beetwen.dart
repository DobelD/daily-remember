extension StringExtension on String {
  String getTextBetween(String start, String end) {
    final startIndex = indexOf(start);
    if (startIndex == -1) return ''; // Tidak menemukan "start"

    final endIndex = indexOf(end, startIndex + start.length);
    if (endIndex == -1) return ''; // Tidak menemukan "end" setelah "start"

    return substring(startIndex + start.length, endIndex);
  }
}
