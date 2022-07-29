import 'package:flutter/material.dart';
import 'package:message_handler/models/notification_message.dart';
import 'notification_base.dart';

class NotificationAlertDialog extends NotificationBase {
  const NotificationAlertDialog();

  @override
  Widget buildNotification(BuildContext context, NotificationMessage notification) {
    return AlertDialog(
      title: notification.title != null ? Text(notification.title!) : null,
      content: Text(notification.content),
    );
  }

}