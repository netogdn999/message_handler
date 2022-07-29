import 'controller/message_handler_controller.dart';
import 'models/notification_message.dart';

abstract class MessageHandlerActionInterface {
  void sendMessage({required NotificationMessage message});
  void sendMessageToMiddlewares({required NotificationMessageLevel level, String? message, dynamic throwable});
}

class MessageHandlerAction implements MessageHandlerActionInterface {
  static MessageHandlerActionInterface? _instance;
  late final MessageHandlerController _controller = MessageHandlerController.instance;

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
  void sendMessageToMiddlewares({required NotificationMessageLevel level, String? message, Object? throwable}) {
    _controller.callMiddlewares(
      level: level,
      message: message,
      throwable: throwable,
    );
  }

}