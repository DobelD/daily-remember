import 'package:dailyremember/infrastructure/dal/repository/word_repository_impl.dart';
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
