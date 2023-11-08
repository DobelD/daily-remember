import 'package:dailyremember/infrastructure/dal/repository/transcribe_repository_impl.dart';
import 'package:get/get.dart';

import '../../../../presentation/speaking_timer/controllers/speaking_timer.controller.dart';

class SpeakingTimerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeakingTimerController>(
      () => SpeakingTimerController(TranscribeRepositoryImpl()),
    );
  }
}
