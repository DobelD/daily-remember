import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../infrastructure/theme/typography.dart';
import 'controllers/speaking_timer.controller.dart';
import 'section/countdown_timer.dart';

class SpeakingTimerScreen extends GetView<SpeakingTimerController> {
  const SpeakingTimerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Speaking Timer',
            style: whiteHeaderBold,
          ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () => controller.showTimerPicker(),
                icon: const Icon(
                  IconlyBold.time_circle,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CountDownTimer()],
          ),
        ));
  }
}
