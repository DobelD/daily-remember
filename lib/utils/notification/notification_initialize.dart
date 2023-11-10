import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'notification_controller.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true,
              enableVibration: true)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupName: 'Basic group',
              channelGroupKey: 'basic_channel_group')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod:
            AwesomeNotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            AwesomeNotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            AwesomeNotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            AwesomeNotificationController.onDismissActionReceivedMethod);
  }

  static Future<void> createNotification(
      {required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final NotificationCategory? category,
      final String? bigPicture,
      final List<NotificationActionButton>? actionButtons,
      final bool scheduled = false,
      final int? interval}) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'basic_channel',
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture,
        ),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }
}
