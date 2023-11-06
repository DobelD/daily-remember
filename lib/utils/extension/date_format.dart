import 'package:intl/intl.dart';

extension DateFormatExtension on String {
  String toCustomDateFormat() {
    // Parsing string waktu ISO 8601 menjadi objek DateTime
    final dateTime = DateTime.parse(this);

    // Format tanggal ke dalam format yang diinginkan (YYYY-MM-DD)
    final formattedDate =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return formattedDate;
  }

  String toFormattedDate() {
    try {
      final parsedDate = DateTime.parse(this);
      final formattedDate =
          "${parsedDate.day.toString().padLeft(2, '0')} ${_getMonthName(parsedDate.month)} ${parsedDate.year.toString()}";
      return formattedDate;
    } catch (e) {
      return "Invalid Date";
    }
  }

  String toCustomDateFormatSort() {
    // Parsing string waktu ISO 8601 menjadi objek DateTime
    final dateTime = DateTime.parse(this);

    // Format tanggal ke dalam format yang diinginkan (MM/DD/YY)
    final formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)}';

    return formattedDate;
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return monthNames[month - 1];
  }
}

extension DateFormatter on String {
  String formatDate() {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime != null) {
      DateFormat dateFormat = DateFormat("dd/MM/yy");
      return dateFormat.format(dateTime);
    } else {
      return "Invalid Date";
    }
  }
}
