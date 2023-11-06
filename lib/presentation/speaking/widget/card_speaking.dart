import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../domain/core/model/local_storage/speaking_model.dart';
import '../../../infrastructure/theme/typography.dart';
import '../../../utils/style_helper/default_border_radius.dart';

class CardSpeaking extends StatefulWidget {
  const CardSpeaking(
      {super.key,
      required this.data,
      required this.isPlaying,
      required this.onPressed});
  final SpeakingModel data;
  final bool isPlaying;
  final Function()? onPressed;

  @override
  State<CardSpeaking> createState() => _CardSpeakingState();
}

class _CardSpeakingState extends State<CardSpeaking> {
  final SlideController slideController = SlideController(
    usePreActionController: true,
  );

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlidablePanel(
      controller: slideController,
      maxSlideThreshold: 0.2,
      axis: Axis.horizontal,
      preActions: const [],
      postActions: [
        Center(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)))
      ],
      child: Card(
        elevation: 4,
        shadowColor: const Color(0xFF6680C5).withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: radiusNormal,
        ),
        child: ListTile(
          onTap: () => slideController.dismiss(),
          title: Text(
            widget.data.title,
            style: titleNormal,
          ),
          subtitle: Text(
            "Duration : ${widget.data.duration}",
            style: hintSubTitleNormal,
          ),
          trailing: Obx(() {
            return IconButton(
              onPressed: widget.onPressed,
              icon: Icon(
                IconlyBold.volume_up,
                color: widget.isPlaying == false
                    ? Colors.grey.shade400
                    : Colors.blueAccent,
              ),
            );
          }),
        ),
      ),
    );
  }
}
