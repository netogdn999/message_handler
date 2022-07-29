import 'package:flutter/foundation.dart';

import '../models/notification_message.dart';

class MessageHandlerController extends ChangeNotifier {
  static MessageHandlerController? _instance;
  final List<NotificationMessage> notifications = [];
  bool hasMessageShowing = false;

  bool get haveNotification => notifications.isNotEmpty;

  static get instance {
    _instance ??= MessageHandlerController();
    return _instance;
  }

  void sendMessage(NotificationMessage message) {
    notifications.add(message);
  }

  void consumeMessage() {
    notifyListeners();
  }

  void removeMessage() {
    if(notifications.isNotEmpty) {
      notifications.removeAt(0);
      hasMessageShowing = false;
    }
  }

}