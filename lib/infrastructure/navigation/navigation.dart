import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_WORD,
      page: () => const AddWordScreen(),
      binding: AddWordControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenScreen(),
      binding: SplashScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.MAIN_PAGE,
      page: () => const MainPageScreen(),
      binding: MainPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROGRESS,
      page: () => const ProgressScreen(),
      binding: ProgressControllerBinding(),
    ),
    GetPage(
      name: Routes.SPEAKING,
      page: () => const SpeakingScreen(),
      binding: SpeakingControllerBinding(),
    ),
    GetPage(
      name: Routes.DICTIONARY,
      page: () => const DictionaryScreen(),
      binding: DictionaryControllerBinding(),
    ),
    GetPage(
      name: Routes.SPEAKING_TIMER,
      page: () => const SpeakingTimerScreen(),
      binding: SpeakingTimerControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => const AccountScreen(),
      binding: AccountControllerBinding(),
    ),
    GetPage(
      name: Routes.SPELLING_CHECK,
      page: () => const SpellingCheckScreen(),
      binding: SpellingCheckControllerBinding(),
    ),
  ];
}
