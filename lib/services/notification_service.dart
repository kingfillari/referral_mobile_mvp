import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

/// Notification Service for Push/SMS reminders
class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notifications
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = IOSInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  /// Display notification
  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'rms_channel',
      'RMS Notifications',
      channelDescription: 'Notifications for RMS app',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = IOSNotificationDetails();
    const generalDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(id, title, body, generalDetails);
  }

  /// Scheduled notifications
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime scheduledTime}) async {
    const androidDetails = AndroidNotificationDetails(
      'rms_channel',
      'RMS Notifications',
      channelDescription: 'Scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = IOSNotificationDetails();
    const generalDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      generalDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Handle notification tap
  void _onSelectNotification(String? payload) {
    debugPrint('Notification clicked: $payload');
  }
}