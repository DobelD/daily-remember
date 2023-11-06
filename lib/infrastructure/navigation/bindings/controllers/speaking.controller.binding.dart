import 'package:get/get.dart';

import '../../../../presentation/speaking/controllers/speaking.controller.dart';

class SpeakingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeakingController>(
      () => SpeakingController(),
    );
  }
}
