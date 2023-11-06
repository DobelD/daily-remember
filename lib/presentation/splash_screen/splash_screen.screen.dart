import 'package:dailyremember/utils/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: controller.onActiveSplashScreen(),
            builder: (_, snap) {
              return Center(
                child: SizedBox(
                  height: Get.height * 0.3,
                  width: Get.height * 0.3,
                  child: LottieBuilder.asset(splashJson),
                ),
              );
            }));
  }
}
