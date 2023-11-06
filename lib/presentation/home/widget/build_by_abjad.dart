import 'package:flutter/material.dart';

import '../../../infrastructure/theme/typography.dart';
import '../controllers/home.controller.dart';
import 'build_list_tile.dart';

Widget buildOnSortEnglishByAbjad(
    HomeController controller, String? prevFirstLetter) {
  return Column(
      children: List.generate(controller.wordsEnglish.length, (index) {
    final data = controller.sortEnglishWordByAlphabet(
        // ignore: invalid_use_of_protected_member
        controller.wordsEnglish.value)[index];

    final firstLetter = data.english?[0].toUpperCase() ?? '';

    if (index > 0) {
      final prevData = controller.sortEnglishWordByAlphabet(
          // ignore: invalid_use_of_protected_member
          controller.wordsEnglish.value)[index - 1];
      prevFirstLetter = prevData.english?[0].toUpperCase() ?? '';
    }

    if (firstLetter != prevFirstLetter) {
      // Tampilkan teks "Nama Abjad" saat abjad berubah
      int abjadCount = 1; // Setel ulang jumlah data untuk abjad yang baru
      for (int i = index + 1; i < controller.wordsEnglish.length; i++) {
        final nextData = controller.sortEnglishWordByAlphabet(
            // ignore: invalid_use_of_protected_member
            controller.wordsEnglish.value)[i];
        final nextFirstLetter = nextData.english?[0].toUpperCase() ?? '';
        if (nextFirstLetter == firstLetter) {
          abjadCount++;
        } else {
          break; // Keluar dari loop jika abjad berubah lagi
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8, top: index == 0 ? 0 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '- $firstLetter',
                  style: titleBold,
                ),
                Text(
                  '$abjadCount Word',
                  style: subTitleNormal,
                ),
              ],
            ),
          ),
          buildListTile(controller, data, "eng"),
        ],
      );
    } else {
      return buildListTile(controller, data, "eng");
    }
  }));
}

Widget buildOnSortIndonesiaByAbjad(
    HomeController controller, String? prevFirstLetter) {
  return Column(
      children: List.generate(controller.wordsIndonesia.length, (index) {
    final data = controller.sortIndonesiaWordByAlphabet(
        // ignore: invalid_use_of_protected_member
        controller.wordsIndonesia.value)[index];

    final firstLetter = data.indonesia?[0].toUpperCase() ?? '';

    if (index > 0) {
      final prevData = controller.sortIndonesiaWordByAlphabet(
          // ignore: invalid_use_of_protected_member
          controller.wordsIndonesia.value)[index - 1];
      prevFirstLetter = prevData.indonesia?[0].toUpperCase() ?? '';
    }

    if (firstLetter != prevFirstLetter) {
      // Tampilkan teks "Nama Abjad" saat abjad berubah
      int abjadCount = 1; // Setel ulang jumlah data untuk abjad yang baru
      for (int i = index + 1; i < controller.wordsIndonesia.length; i++) {
        final nextData = controller.sortIndonesiaWordByAlphabet(
            // ignore: invalid_use_of_protected_member
            controller.wordsIndonesia.value)[i];
        final nextFirstLetter = nextData.indonesia?[0].toUpperCase() ?? '';
        if (nextFirstLetter == firstLetter) {
          abjadCount++;
        } else {
          break; // Keluar dari loop jika abjad berubah lagi
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8, top: index == 0 ? 0 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '- $firstLetter',
                  style: titleBold,
                ),
                Text(
                  '$abjadCount Word',
                  style: subTitleNormal,
                ),
              ],
            ),
          ),
          buildListTile(controller, data, "ind"),
        ],
      );
    } else {
      return buildListTile(controller, data, "ind");
    }
  }));
}
