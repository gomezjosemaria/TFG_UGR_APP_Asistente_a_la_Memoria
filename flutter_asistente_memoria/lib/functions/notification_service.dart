import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  static final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  static final String sound = 'sound.wav';

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id 2',
        'channel name',
        'channel description',
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  static Future<void> init(bool initScheduled) async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future<void> showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> deleteAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<List<ActiveNotification>> getNotifications() async {
    List<ActiveNotification> listNotifications = <ActiveNotification>[];
    listNotifications = (await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.getActiveNotifications())!;
    if (listNotifications != null) {
      return listNotifications;
    }
    else {
      return <ActiveNotification>[];
    }
  }
}
