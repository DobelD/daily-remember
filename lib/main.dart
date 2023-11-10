import 'package:dailyremember/domain/core/model/local_storage/speaking_model.dart';
import 'package:dailyremember/domain/core/model/local_storage/vocabulary.dart';
import 'package:dailyremember/infrastructure/dal/services/firebase/firebase_api.dart';
import 'package:dailyremember/utils/notification/notification_initialize.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'domain/core/model/local_storage/auth_model.dart';
import 'firebase_options.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'utils/preference/app_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await NotificationService.initialize();
  await FirebaseApi().initNotification();
  var initialRoute = await Routes.initialRoute;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppPreference.initialize();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<AuthModel>(AuthModelAdapter());
  await Hive.openBox<AuthModel>('auth');
  Hive.registerAdapter<SpeakingModel>(SpeakingModelAdapter());
  await Hive.openBox<SpeakingModel>('speakings');
  Hive.registerAdapter<VocabularyModel>(VocabularyModelAdapter());
  await Hive.openBox<VocabularyModel>('vocabulary');
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widgets) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            getPages: Nav.routes,
          );
        });
  }
}
