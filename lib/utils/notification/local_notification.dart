import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class AppLocalNotification {
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin get local =>
      AppLocalNotification._local;

  static Future<void> show(
      {required String title, required String body, String? payload}) async {
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializeSetting = InitializationSettings(android: androidInitialize);
    await _local.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (details) {
        return;
      },
    );

    List<AndroidNotificationActionInput> input = [];

    var androidDetails = const AndroidNotificationDetails(
      'high_importance_channel',
      'high_importance_channel_name',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      // actions: [
      //   AndroidNotificationAction('open', 'Open', inputs: input),
      // ],
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await AppLocalNotification._local.show(
      -2,
      title.capitalizeFirst,
      body.capitalizeFirst,
      platformDetails,
      // payload: json.encode({"id": payload}),
    );
  }
}
