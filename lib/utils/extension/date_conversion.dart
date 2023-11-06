import 'package:intl/intl.dart';

extension StringDateConversion on String {
  String get formattedDate {
    try {
      final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSZ");
      final outputFormat = DateFormat("dd-MM-yyyy");
      final date = inputFormat.parse(this);
      return outputFormat.format(date);
    } catch (e) {
      // Handle error jika format input tidak valid
      return this; // Mengembalikan string asli jika terjadi kesalahan
    }
  }
}
