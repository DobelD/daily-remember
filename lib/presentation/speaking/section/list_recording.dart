import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:dailyremember/utils/extension/date_conversion.dart';
import 'package:dailyremember/utils/extension/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/style_helper/default_border_radius.dart';

class ListRecording extends StatelessWidget {
  const ListRecording({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeakingController>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(2.seconds, () {
            controller.getData();
          });
        },
        child: SingleChildScrollView(
          child: Obx(() {
            String currentDate = "";
            return Column(
                children:
                    List.generate(controller.speakingData.length, (index) {
              final data = controller.speakingData[index];
              final isDifferentDate =
                  data.createdAt!.toFormattedDate() != currentDate;
              currentDate = data.createdAt!.toFormattedDate();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDifferentDate)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        currentDate,
                        style: subTitleNormal,
                      ),
                    ),
                  Padding(
                      padding: EdgeInsets.only(
                        bottom: index == controller.speakingData.length - 1
                            ? 82
                            : 0,
                      ),
                      child: Card(
                        elevation: 4,
                        shadowColor: const Color(0xFF6680C5).withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: radiusNormal,
                        ),
                        child: ListTile(
                          onLongPress: () {
                            controller.deleteSpeaking(data.id ?? 0,
                                data.audioPath ?? '', data.idTranscript ?? '');
                          },
                          onTap: () {
                            controller.openTranscribe(
                                data.id ?? 0,
                                data.idTranscript ?? '',
                                data.transcript,
                                index);
                          },
                          title: Text(
                            data.title ?? '',
                            style: titleNormal,
                          ),
                          subtitle: Text(
                            "Duration : ${data.duration}",
                            style: hintSubTitleNormal,
                          ),
                          trailing: Obx(() {
                            return IconButton(
                              onPressed: () {
                                controller.openPlayingBar(
                                    data.audioPath ?? '', index);
                              },
                              icon: Icon(
                                IconlyBold.volume_up,
                                color: controller.isPlaying[index] == false
                                    ? Colors.grey.shade400
                                    : Colors.blueAccent,
                              ),
                            );
                          }),
                        ),
                      )),
                ],
              );
            }));
          }),
        ),
      ),
    );
  }
}
