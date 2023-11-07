import 'package:dailyremember/infrastructure/dal/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../../../presentation/auth/login/controllers/login.controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(AuthRepositoryImpl()),
    );
  }
}
