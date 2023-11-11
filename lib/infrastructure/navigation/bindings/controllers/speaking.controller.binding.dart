import 'package:get/get.dart';

import '../../../../presentation/speaking/controllers/speaking.controller.dart';
import '../../../dal/repository/speaking_repository_impl.dart';
import '../../../dal/repository/transcribe_repository_impl.dart';

class SpeakingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeakingController>(
      () => SpeakingController(
          TranscribeRepositoryImpl(), SpeakingRepositoryImpl()),
    );
  }
}
