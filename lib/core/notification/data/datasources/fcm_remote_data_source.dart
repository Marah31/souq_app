import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling background/terminated message: ${message.messageId}");
}

abstract class FcmRemoteDataSource {
  Future<void> init();
  Future<String?> getToken();
  Stream<RemoteMessage> get onForegroundMessage;
  Stream<RemoteMessage> get onMessageOpenedApp;
  Future<RemoteMessage?> getInitialMessage();
}

class FcmRemoteDataSourceImpl implements FcmRemoteDataSource {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  Future<void> init() async {
    await Firebase.initializeApp();

    // Register top-level background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Request permissions (Android 13+ requires explicit POST_NOTIFICATIONS)
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Future<String?> getToken() => _messaging.getToken();

  @override
  Stream<RemoteMessage> get onForegroundMessage => FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<RemoteMessage?> getInitialMessage() => _messaging.getInitialMessage();
}