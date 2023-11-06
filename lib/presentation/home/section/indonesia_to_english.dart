// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/app_form.dart';
import '../../../infrastructure/theme/typography.dart';
import '../controllers/home.controller.dart';
import '../widget/build_by_abjad.dart';
import '../widget/build_by_noremember.dart';
import '../widget/build_by_remember.dart';
import '../widget/build_list_tile.dart';

class IndonesiaToEnglish extends StatelessWidget {
  const IndonesiaToEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        controller.getWord();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: AppForm.search(
                      hintText: "Search...",
                      onChanged: (query) {
                        controller.searchWordOnIndonesia(query);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 1,
                    child: Obx(() => PopupMenuButton<int>(
                          icon: const Icon(Icons.sort),
                          initialValue:
                              controller.selectedSortOnIndonesia.value,
                          onSelected: (int value) {
                            controller.changeSortIndonesia(value);
                          },
                          itemBuilder: (BuildContext context) {
                            return List.generate(controller.listSort.length,
                                (index) {
                              return PopupMenuItem<int>(
                                value: index,
                                child: Text(controller.listSort[index],
                                    style: subTitleNormal),
                              );
                            });
                          },
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Obx(() {
                  String? prevFirstLetter;
                  if (controller.homeStatus.value == HomeStatus.loading) {
                    return SizedBox(
                        height: Get.height * 0.6,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else {
                    if (controller.selectedSortOnIndonesia.value == 0) {
                      return buildOnSortIndonesiaByAbjad(
                          controller, prevFirstLetter);
                    } else if (controller.selectedSortOnIndonesia.value == 1) {
                      return buildSortIndonesiaByRemember(controller);
                    } else {
                      return buildSortIndonesiaByNoRemember(controller);
                    }
                  }
                }),
              ),
            ),
            const SizedBox(height: 92)
          ],
        ),
      ),
    );
  }

  Widget buildOnSortByAbjad(
      HomeController controller, int index, String? prevFirstLetter) {
    final data = controller
        .sortIndonesiaWordByAlphabet(controller.wordsIndonesia.value)[index];

    final firstLetter = data.indonesia?[0].toUpperCase() ?? '';

    if (index > 0) {
      final prevData = controller.sortIndonesiaWordByAlphabet(
          controller.wordsIndonesia.value)[index - 1];
      prevFirstLetter = prevData.indonesia?[0].toUpperCase() ?? '';
    }

    if (firstLetter != prevFirstLetter) {
      // Tampilkan teks "Nama Abjad" saat abjad berubah
      int abjadCount = 1; // Setel ulang jumlah data untuk abjad yang baru
      for (int i = index + 1; i < controller.wordsIndonesia.length; i++) {
        final nextData = controller
            .sortIndonesiaWordByAlphabet(controller.wordsIndonesia.value)[i];
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
  }
}
