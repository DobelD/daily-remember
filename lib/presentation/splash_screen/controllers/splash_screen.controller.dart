import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Future<void> onActiveSplashScreen() async {
    await Future.delayed(5.seconds, () {
      Get.offAllNamed(Routes.MAIN_PAGE);
    });
  }
}
