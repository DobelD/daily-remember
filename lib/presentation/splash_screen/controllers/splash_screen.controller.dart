import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

import '../../../utils/preference/app_preference.dart';

class SplashScreenController extends GetxController {
  Future<void> onActiveSplashScreen() async {
    await Future.delayed(5.seconds, () {
      var accessToken = AppPreference().getAccessToken();
      if (accessToken != null) {
        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
