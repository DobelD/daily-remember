import 'package:dailyremember/infrastructure/dal/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../../../presentation/account/controllers/account.controller.dart';

class AccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(AuthRepositoryImpl()),
    );
  }
}
