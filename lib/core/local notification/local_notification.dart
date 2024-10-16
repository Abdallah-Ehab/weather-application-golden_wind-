import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  late final AndroidInitializationSettings initializationSettingsAndroid;
  late final InitializationSettings initializationSettings;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static final LocalNotification _instance = LocalNotification._init();

  static LocalNotification get instance => _instance;

  LocalNotification._init() {
    initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initialize() async {
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('weather_channel', 'weather_channel',
            channelDescription: 'weather channel that shows notifications',
            importance: Importance.max,
            priority: Priority.max,
            ongoing: true,
            styleInformation: BigTextStyleInformation(''),
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(256),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
