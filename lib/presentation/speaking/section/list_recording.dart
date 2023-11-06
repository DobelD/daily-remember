import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/domain/core/model/local_storage/speaking_model.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:dailyremember/utils/extension/date_conversion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/style_helper/default_border_radius.dart';

class ListRecording extends StatelessWidget {
  const ListRecording({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeakingController>();
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: controller.box.listenable(),
              builder: (_, box, child) {
                final speaking = box.values.toList().cast<SpeakingModel>();
                return Column(
                  children: [
                    // const AppForm.search(
                    //   hintText: "Search...",
                    // ),
                    // const SizedBox(height: 12),
                    Column(
                        children: List.generate(speaking.length, (index) {
                      var data = speaking[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                index == controller.box.length - 1 ? 82 : 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // speaking[index].createdAt !=
                            //             speaking[index + 1].createdAt &&
                            //         index != 0
                            //     ? Padding(
                            //         padding:
                            //             const EdgeInsets.symmetric(vertical: 8),
                            //         child: Text(
                            //           data.createdAt.formattedDate,
                            //           style: titleBold,
                            //         ),
                            //       )
                            //     : const SizedBox(),
                            Card(
                                elevation: 4,
                                shadowColor:
                                    const Color(0xFF6680C5).withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: radiusNormal,
                                ),
                                child: ListTile(
                                  title: Text(
                                    data.title,
                                    style: titleNormal,
                                  ),
                                  trailing: Obx(() {
                                    return IconButton(
                                        onPressed: () {
                                          controller.openPlayingBar(
                                              data.audioPath, index);
                                        },
                                        icon: Icon(
                                          IconlyBold.volume_up,
                                          color: controller.isPlaying[index] ==
                                                  false
                                              ? Colors.grey.shade400
                                              : Colors.blueAccent,
                                        ));
                                  }),
                                )),
                          ],
                        ),
                      );
                    })),
                  ],
                );
              }),
        ));
  }
}
