import '../models/notification_message.dart';

abstract class MessageHandlerMiddleware {
  void didShowMessage({required NotificationMessageLevel level, String? message, Object? throwable});
}