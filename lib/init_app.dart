import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/services/fcm_service.dart';

Future<void> initApp() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setPathUrlStrategy();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await FcmService.requestNotificationPermission();
  await FcmService.setForegroundNotification();
  await FcmService.listenOnMessage();
  await FcmService.onMessageOpenedApp();
}
