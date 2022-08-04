import '../models/notification_message.dart';

/// Middleware that will be every called before each [NotificationMessage]
abstract class MessageHandlerMiddleware {
  /// Callback called every before each [NotificationMessage]
  void didShowMessage({
    required NotificationMessageLevel level,
    String? message,
    Object? throwable,
  });
}
