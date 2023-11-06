import 'package:dailyremember/presentation/home/widget/build_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/theme/typography.dart';
import '../controllers/home.controller.dart';

Widget buildSortEnglishByNoRemember(HomeController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Not Remembered',
              style: titleBold,
            ),
            Text(
              '${controller.countNoRememberEnglish.value} Word',
              style: subTitleNormal,
            ),
          ],
        ),
      ),
      Column(
          children: List.generate(controller.wordsEnglish.length, (index) {
        if (controller.wordsEnglish[index].remember == false) {
          return buildListTile(
              controller, controller.wordsEnglish[index], "eng");
        } else {
          return const SizedBox();
        }
      })),
    ],
  );
}

Widget buildSortIndonesiaByNoRemember(HomeController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Not Remembered',
              style: titleBold,
            ),
            Text(
              '${controller.countNoRememberIndonesia.value} Word',
              style: subTitleNormal,
            ),
          ],
        ),
      ),
      Column(
          children: List.generate(controller.wordsIndonesia.length, (index) {
        if (controller.wordsIndonesia[index].remember == false) {
          return buildListTile(
              controller, controller.wordsIndonesia[index], "ind");
        } else {
          return const SizedBox();
        }
      })),
    ],
  );
}
