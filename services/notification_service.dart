import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  static Future<void> showMoviePlayingNotification(String movieTitle) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'movie_channel',
      'Movie Notifications',
      channelDescription: 'Notifications for movie playback',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      'Now Playing',
      '$movieTitle is now playing',
      notificationDetails,
    );
  }
}
