import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/notification/constant.dart';
import '../../../../utils/notification/notification_initialize.dart';
import 'app_lifecycle.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log(message.notification?.title ?? '');
  log(message.notification?.body ?? '');
  log("Data : ${message.data}");
}

settingShowNotification(RemoteMessage message) async {
  var androidDetails = const AndroidNotificationDetails(
    'high_importance_channel',
    'high_importance_channel_name',
    priority: Priority.high,
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );
  var platformDetails = NotificationDetails(android: androidDetails);

  // Tampilkan notifikasi
  await FirebaseApi._local.show(
    -2,
    message.notification?.title?.capitalizeFirst,
    message.notification?.body?.capitalizeFirst,
    platformDetails,
    payload: message.data.toString(),
  );
}

class FirebaseApi {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseApi._firebaseMessaging;
  static FlutterLocalNotificationsPlugin get local => FirebaseApi._local;

  final box = GetStorage();
  bool appForeground = true;

  void init() {
    WidgetsBinding.instance.addObserver(AppLifecycleObserver(this));
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(AppLifecycleObserver(this));
  }

  handleMessage(RemoteMessage? message) {
    if (message != null) return;
    log(message?.notification?.title ?? '');
  }

  static Future<void> showLocalNotification(
    RemoteMessage message,
  ) async {
    // Konfigurasi notifikasi
    settingShowNotification(message);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final tokenFcm = await _firebaseMessaging.getToken();
    await FirebaseMessaging.instance.subscribeToTopic("imron");
    fcmToken = tokenFcm ?? '';
    box.write('fcm_token', tokenFcm);
    log("TOKEN : $tokenFcm");
    init();
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializeSetting = InitializationSettings(android: androidInitialize);
    _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    _local.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (details) {
        return;
      },
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: false, sound: false, badge: false);

    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    if (appForeground == true) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        String? title = message.notification!.title;
        String? body = message.notification!.body;
        // Map<String, String> payload() {
        //   Map<String, String> data = {};
        //   data['program_id'] = "${message.data['program_id']}";
        //   data['notification_id'] = "${message.data['notification_id']}";
        //   return data;
        // }

        NotificationService.createNotification(
          title: title ?? '',
          body: body ?? '',
          // payload: payload(),
          // actionButtons: [
          //   NotificationActionButton(
          //     key: "Detail Program",
          //     label: "Detail Program",
          //     color: Colors.white,
          //     autoDismissible: true,
          //   ),
          // ]
        );
      });
    } else {
      FirebaseMessaging.onMessage.listen(showLocalNotification);
    }
  }
}
