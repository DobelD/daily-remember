import 'package:dailyremember/infrastructure/dal/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../../../presentation/auth/register/controllers/register.controller.dart';

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(AuthRepositoryImpl()),
    );
  }
}
