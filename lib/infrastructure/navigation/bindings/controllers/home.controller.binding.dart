import 'package:dailyremember/infrastructure/dal/repository/word_repository_impl.dart';
import 'package:get/get.dart';

import '../../../../presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(WordRepositoryImpl()),
    );
  }
}
