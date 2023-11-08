import 'package:get/get.dart';

import '../../../../presentation/spelling_check/controllers/spelling_check.controller.dart';

class SpellingCheckControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpellingCheckController>(
      () => SpellingCheckController(),
    );
  }
}
