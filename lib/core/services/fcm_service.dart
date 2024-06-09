import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_notification_service.dart';
part 'fcm_service.g.dart';

class FcmService {
  FcmService();
  FirebaseMessaging fcm = FirebaseMessaging.instance;

  static Future<void> requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> setForegroundNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getFcmToken() async {
    String? token = await fcm.getToken();

    if (kIsWeb) {
      token = await fcm.getToken(
          vapidKey:
              "BGPkZZrbC3AcB2H6iNc5OEVJFvxP_uPRC4DZWjongYLJ2KbbnPH3mfUUBN9yl_otLRDYhA5ywLKbXx86nz0drII");
    } else {
      token = await fcm.getToken();
    }
    if (token == null) {
      fcm.onTokenRefresh.listen((newToken) {
        token = newToken;
      });
    }
    return token;
  }

  static listenOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AndroidNotification? android = message.notification?.android;

      if (android != null) {
        LocalNotificationService.initialize();
        LocalNotificationService.display(message);
      }
    });
  }

  static onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  void subscribeTopic(String role) async {
    await fcm.subscribeToTopic(role);
    await fcm.subscribeToTopic("ALL");
  }
}

@riverpod
FcmService fcmService(ref) {
  return FcmService();
}
