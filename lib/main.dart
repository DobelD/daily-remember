import 'package:dailyremember/domain/core/model/local_storage/speaking_model.dart';
import 'package:dailyremember/domain/core/model/local_storage/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  var initialRoute = await Routes.initialRoute;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
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
