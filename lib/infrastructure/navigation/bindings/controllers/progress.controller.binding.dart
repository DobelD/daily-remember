import 'package:get/get.dart';

import '../../../../presentation/progress/controllers/progress.controller.dart';

class ProgressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressController>(
      () => ProgressController(),
    );
  }
}
