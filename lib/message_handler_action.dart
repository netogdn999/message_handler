import 'controller/message_handler_controller.dart';
import 'models/notification_message.dart';

abstract class MessageHandlerActionInterface {
  ///
  /// Displays a [NotificationMessage] to the user, if a [NotificationMessage] is already displayed, it will be sent to the display queue.
  ///
  /// If you have any middleware registered, it will be called previously.
  ///
  /// Example:
  /// ```dart
  /// messageHandler.sendMessage(
  ///   message: NotificationMessage(
  ///     title: "title", //optional, default -> null
  ///     content: "testando modal bottom sheet", // required
  ///     type: NotificationMessageType.bottomSheet, //optional, default -> alertDialog
  ///     level: NotificationMessageLevel.info, //optional, default -> error
  ///     onDismiss: () { // optional, default -> null
  ///     }
  ///   ),
  /// );
  /// ```
  ///
  void sendMessage({required NotificationMessage message});

  /// Call registered middlewares.
  ///
  /// Example:
  /// ```dart
  /// messageHandler.sendMessageToMiddlewares(
  ///   level: NotificationMessageLevel.error,
  ///   message: "testando middleware",
  /// );
  /// ```
  void sendMessageToMiddlewares(
      {required NotificationMessageLevel level,
      String? message,
      Object? throwable});
}

class MessageHandlerAction implements MessageHandlerActionInterface {
  static MessageHandlerActionInterface? _instance;
  late final MessageHandlerController _controller =
      MessageHandlerController.instance;

  static get instance {
    _instance ??= MessageHandlerAction();
    return _instance;
  }

  @override
  void sendMessage({required NotificationMessage message}) {
    _controller.sendMessage(message);
    _controller.consumeMessage();
  }

  @override
  void sendMessageToMiddlewares(
      {required NotificationMessageLevel level,
      String? message,
      Object? throwable}) {
    _controller.callMiddlewares(
      level: level,
      message: message,
      throwable: throwable,
    );
  }
}
