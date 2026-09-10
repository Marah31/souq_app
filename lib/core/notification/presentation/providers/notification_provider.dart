import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/routing/app_router.dart';

final notificationInitializerProvider = FutureProvider<void>((ref) async {
  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  debugPrint('FCM Authorization Status: ${settings.authorizationStatus}');

  // 3. Fetch & Print Token
  try {
    final token = await messaging.getToken();
    debugPrint('==================================================');
    debugPrint('FCM DEVICE TOKEN: $token');
    debugPrint('==================================================');
  } catch (e) {
    debugPrint('Error fetching FCM token: $e');
  }

  // 4. Foreground Message Listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("${notification.title}: ${notification.body}"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  });

  // 5. Background Notification Click Listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("Notification clicked: ${message.data}");
    final route = message.data['route'];
    if (route != null && route is String) {
      rootNavigatorKey.currentState?.context.push(route);
    }
  });

  // 6. Terminated State Launch Listener
  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    debugPrint("App launched from terminated state: ${initialMessage.data}");
  }
});