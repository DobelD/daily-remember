import 'package:dailyremember/infrastructure/dal/repository/word_repository_impl.dart';
import 'package:get/get.dart';

import '../../../../presentation/add_word/controllers/add_word.controller.dart';

class AddWordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWordController>(
      () => AddWordController(WordRepositoryImpl()),
    );
  }
}
