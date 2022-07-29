import 'package:flutter/material.dart';

import '../message_handler_action.dart';
import '../models/notification_message.dart';
import '../notification_alert_dialog.dart';
import '../notification_base_design.dart';
import 'message_handler_controller.dart';

MessageHandlerActionInterface get messageHandler => MessageHandlerAction.instance;

class MessageManager extends StatelessWidget {
  final Widget child;
  late final MessageHandlerController _controller = MessageHandlerController.instance;
  final NotificationBaseDesign? alertDialog;
  MessageManager({Key? key, required this.child, this.alertDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      _listenerMessageManager(context, _controller);
    });
    return child;
  }

  void _listenerMessageManager(BuildContext context, MessageHandlerController controller) {
    if(controller.haveNotification && !controller.hasMessageShowing) {
      controller.hasMessageShowing = true;
      final currentNotification = controller.notifications.first;
      switch(currentNotification.type) {
        case NotificationMessageType.alertDialog:
          _showAlertDialog(context, currentNotification, controller);
          break;
        case NotificationMessageType.toast:
          _showToast(context, currentNotification);
          break;
        case NotificationMessageType.bottomSheet:
          _showBottomSheet(context, currentNotification);
          break;
      }
    }
  }

  void _showAlertDialog(BuildContext context, NotificationMessage notification, MessageHandlerController controller) {
    final alert = alertDialog ?? const NotificationAlertDialog();
    showDialog<void>(
      context: context,
      builder: (_) => alert.buildNotification(context, notification),
    ).then((_) async {
      if(notification.onDismiss != null) {
        await notification.onDismiss!();
      }
      controller.removeMessage();
      if(controller.haveNotification) {
        controller.consumeMessage();
      }
    });
  }

  void _showToast(BuildContext context, NotificationMessage notification) {

  }

  void _showBottomSheet(BuildContext context, NotificationMessage notification) {

  }
}