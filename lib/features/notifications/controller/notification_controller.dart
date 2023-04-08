import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/notification_api.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
  return NotificationController(
    notificationAPI: ref.watch(notificationAPIProvider),
  );
});

class NotificationController extends StateNotifier<bool> {
  final NotificationAPI _notificationAPI;

  NotificationController({
    required NotificationAPI notificationAPI,
  })  : _notificationAPI = notificationAPI,
        super(false);
}
