import 'package:flutter/material.dart';
import 'package:message_handler/models/notification_message.dart';
import 'package:message_handler/notification_base_design.dart';

class NotificationAlertDialog implements NotificationBaseDesign {
  const NotificationAlertDialog();

  @override
  Widget buildNotification(BuildContext context, NotificationMessage notification) {
    return AlertDialog(
      title: notification.title != null ? Text(notification.title!) : null,
      content: Text(notification.content),
    );
  }

}