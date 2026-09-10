// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:souq_app/core/routing/app_router.dart';

// /// Top-level background message handler for FCM
// /// MUST be outside any class and marked with @pragma('vm:entry-point')
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint("Handling background/terminated message: ${message.messageId}");
// }

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   /// Initialize Firebase & FCM handlers
//   Future<void> initialize() async {
//     // 1. Initialize Firebase App
//     await Firebase.initializeApp();

//     // 2. Set Background Handler (State 2 & 3: Background / Terminated)
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // 3. Request User Permissions
//     await _requestPermissions();

//     // 4. Setup Notification Listeners
//     _setupForegroundListener();
//     _setupBackgroundOpenedListener();
//     await _handleInitialMessage();

//     // 5. Fetch & Log FCM Token
//     await _logFcmToken();
//   }

//   Future<void> _requestPermissions() async {
//     final settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     debugPrint('FCM Authorization Status: ${settings.authorizationStatus}');
//   }

//   /// STATE 1: Foreground Notification Handler (App open)
//   void _setupForegroundListener() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint("Foreground message received: ${message.notification?.title}");
      
//       final notification = message.notification;
//       if (notification != null) {
//         rootScaffoldMessengerKey.currentState?.showSnackBar(
//           SnackBar(
//             content: Text("${notification.title}: ${notification.body}"),
//           ),
//         );
//       }
//     });
//   }

//   /// STATE 2: Background Notification Click Handler (App minimized)
//   void _setupBackgroundOpenedListener() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint("App opened from background via notification: ${message.data}");
//       // TODO: Handle routing via GoRouter if needed
//     });
//   }

//   /// STATE 3: Terminated Notification Click Handler (App killed)
//   Future<void> _handleInitialMessage() async {
//     RemoteMessage? initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       debugPrint("App launched from terminated state via notification: ${initialMessage.data}");
//       // TODO: Handle routing via GoRouter if needed
//     }
//   }

//   Future<void> _logFcmToken() async {
//     final token = await _messaging.getToken();
//     debugPrint("==================================================");
//     debugPrint("FCM DEVICE TOKEN: $token");
//     debugPrint("==================================================");
//   }
// }