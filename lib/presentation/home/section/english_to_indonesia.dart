import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/home/widget/build_by_noremember.dart';
import 'package:dailyremember/presentation/home/widget/build_by_remember.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home.controller.dart';
import '../widget/build_by_abjad.dart';

class EnglishToIndonesia extends StatelessWidget {
  const EnglishToIndonesia({super.key});

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
                        controller.searchWordOnEnglish(query);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 1,
                    child: Obx(() => PopupMenuButton<int>(
                          icon: const Icon(Icons.sort),
                          initialValue: controller.selectedSortOnEnglish.value,
                          onSelected: (int value) {
                            controller.changeSortEnglish(value);
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
                    if (controller.selectedSortOnEnglish.value == 0) {
                      return buildOnSortEnglishByAbjad(
                          controller, prevFirstLetter);
                    } else if (controller.selectedSortOnEnglish.value == 1) {
                      return buildSortEnglishByRemember(controller);
                    } else {
                      return buildSortEnglishByNoRemember(controller);
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

  // Build widget on Sort by Abjad

// Build list tile content
}
