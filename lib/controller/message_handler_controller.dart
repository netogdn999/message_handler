import 'package:flutter/foundation.dart';

import '../middleware/message_handler_middleware.dart';
import '../models/notification_message.dart';

class MessageHandlerController extends ChangeNotifier {
  static MessageHandlerController? _instance;
  final List<NotificationMessage> notifications = [];
  final List<MessageHandlerMiddleware> middlewares = [];
  bool hasMessageShowing = false;

  bool get haveNotification => notifications.isNotEmpty;

  static get instance {
    _instance ??= MessageHandlerController();
    return _instance;
  }

  void sendMessage(NotificationMessage message) {
    notifications.add(message);
  }

  void callMiddlewares({
    required NotificationMessageLevel level,
    String? message,
    Object? throwable,
  }) {
    for (var middleware in middlewares) {
      middleware.didShowMessage(
        level: level,
        message: message,
        throwable: throwable,
      );
    }
  }

  void consumeMessage() {
    if (!hasMessageShowing) {
      final currentNotification = notifications.first;
      callMiddlewares(
        level: currentNotification.level,
        message: currentNotification.content,
      );
      notifyListeners();
    }
  }

  void removeMessage() {
    if (notifications.isNotEmpty) {
      notifications.removeAt(0);
      hasMessageShowing = false;
    }
  }
}
