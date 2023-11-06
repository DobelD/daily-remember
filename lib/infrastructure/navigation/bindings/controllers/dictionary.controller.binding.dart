import 'package:get/get.dart';

import '../../../../presentation/dictionary/controllers/dictionary.controller.dart';

class DictionaryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DictionaryController>(
      () => DictionaryController(),
    );
  }
}
