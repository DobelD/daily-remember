import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

extension DateFormatter on String {
  String get dateOnly {
    // Split the string into date and time parts
    List<String> parts = split(" ");

    // Return the date part
    return parts[0];
  }

  String get formattedDate {
    // Split the date part into year, month, and day
    List<String> parts = dateOnly.split("-");

    // Convert the month to a localized string
    String month = DateFormat.MMMM(Localizations.localeOf(Get.context!))
        .format(DateTime.parse(parts[1]));

    // Return the formatted date
    return "${parts[2]} $month ${parts[0]}";
  }
}
