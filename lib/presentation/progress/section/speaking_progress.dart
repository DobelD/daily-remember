import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../infrastructure/theme/typography.dart';
import '../../../utils/style_helper/default_border_radius.dart';
import '../controllers/progress.controller.dart';

class SpeakingProgress extends StatelessWidget {
  const SpeakingProgress({super.key});

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
                  IconlyLight.volume_up,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Speaking',
                  style: subTitleNormal,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
