import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/numeric/pie.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/progress/controllers/progress.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'dart:math';
import '../../../utils/style_helper/default_border_radius.dart';

class VocabularyProgress extends StatelessWidget {
  const VocabularyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProgressController>();
    return Card(
      elevation: 4,
      shadowColor: const Color(0xFF6680C5).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: radiusNormal,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  IconlyLight.activity,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Vocabulary',
                  style: subTitleNormal,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.16,
                      width: Get.height * 0.16,
                      child: Obx(() {
                        return DChartPieN(
                          // ignore: invalid_use_of_protected_member
                          data: controller.rememberedVocabulary.value,
                        );
                      }),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Not Remember Verb',
                          style: hintSubTitleNormal,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember Verb',
                          style: hintSubTitleNormal,
                        )
                      ],
                    )
                  ],
                ))),
                Expanded(
                    child: SizedBox(
                        child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.16,
                      width: Get.height * 0.16,
                      child: Obx(() {
                        return DChartPieO(
                          // ignore: invalid_use_of_protected_member
                          data: controller.targetVocabulary.value,
                          configRenderPie: const ConfigRenderPie(
                            arcWidth: 30,
                            arcLength: 7 / 5 * pi,
                            startAngle: 4 / 5 * pi,
                          ),
                        );
                      }),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Target',
                          style: hintSubTitleNormal,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember',
                          style: hintSubTitleNormal,
                        )
                      ],
                    )
                  ],
                ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
