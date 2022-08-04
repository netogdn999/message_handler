import 'package:flutter/foundation.dart';

import '../middleware/message_handler_middleware.dart';
import '../models/notification_message.dart';

class MessageHandlerController extends ChangeNotifier {
  static MessageHandlerController? _instance;

  /// [NotificationMessage] queue.
  final List<NotificationMessage> notifications = [];

  /// [MessageHandlerMiddleware] queue.
  final List<MessageHandlerMiddleware> middlewares = [];

  /// Check if there is a NotificationMessage being displayed.
  bool hasMessageShowing = false;

  /// hook for checking if [NotificationMessage] queues are empty.
  bool get haveNotification => notifications.isNotEmpty;

  static get instance {
    _instance ??= MessageHandlerController();
    return _instance;
  }

  /// Add a [NotificationMessage] to the queue.
  void sendMessage(NotificationMessage message) {
    notifications.add(message);
  }

  /// Calls all [MessageHandlerMiddleware] registred in the queue.
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

  /// If the [NotificationMessage] queue is not empty, call the next [NotificationMessage].
  ///
  /// This method calls all [MessageHandlerMiddleware] registred in the queue.
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

  /// Remove the first [MessageHandlerMiddleware] in the queue.
  void removeMessage() {
    if (notifications.isNotEmpty) {
      notifications.removeAt(0);
      hasMessageShowing = false;
    }
  }
}
