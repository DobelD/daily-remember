import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/account/controllers/account.controller.dart';
import '../../../../presentation/dictionary/controllers/dictionary.controller.dart';
import '../../../../presentation/main_page/controllers/main_page.controller.dart';
import '../../../../presentation/progress/controllers/progress.controller.dart';
import '../../../../presentation/speaking/controllers/speaking.controller.dart';
import '../../../dal/repository/auth_repository.dart';
import '../../../dal/repository/word_repository_impl.dart';

class MainPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(WordRepositoryImpl()),
    );
    Get.lazyPut<DictionaryController>(
      () => DictionaryController(),
    );
    Get.lazyPut<SpeakingController>(
      () => SpeakingController(),
    );
    Get.lazyPut<ProgressController>(
      () => ProgressController(),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(AuthRepositoryImpl()),
    );
  }
}
