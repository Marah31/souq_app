import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/core/notification/data/datasources/fcm_remote_data_source.dart';

final fcmDataSourceProvider = Provider<FcmRemoteDataSource>((ref) {
  return FcmRemoteDataSourceImpl();
});

class NotificationRepository {
  final FcmRemoteDataSource _dataSource;

  NotificationRepository(this._dataSource);

  Future<void> initialize({
    required Function(RemoteMessage) onForeground,
    required Function(RemoteMessage) onNotificationClick,
  }) async {
    await _dataSource.init();

    // Fetch and log token
    final token = await _dataSource.getToken();
    debugPrint("==================================================");
    debugPrint("FCM DEVICE TOKEN: $token");
    debugPrint("==================================================");

    // Foreground listener
    _dataSource.onForegroundMessage.listen(onForeground);

    // Background click listener
    _dataSource.onMessageOpenedApp.listen(onNotificationClick);

    // Terminated launch listener
    final initialMessage = await _dataSource.getInitialMessage();
    if (initialMessage != null) {
      onNotificationClick(initialMessage);
    }
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(fcmDataSourceProvider));
});