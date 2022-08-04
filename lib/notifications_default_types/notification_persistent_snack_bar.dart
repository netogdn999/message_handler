import 'package:flutter/material.dart';
import 'package:message_handler/models/notification_message.dart';
import 'notification_base.dart';

class NotificationPersistentSnackBar extends NotificationBase {
  const NotificationPersistentSnackBar();

  @override
  Widget buildNotification(
    BuildContext context,
    NotificationMessage notification,
  ) {
    return SnackBar(
      padding: const EdgeInsets.all(0.0),
      duration: const Duration(days: 365),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: borderColor[notification.level]!,
              width: 8.0,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.title != null) ...[
              Text(notification.title!),
            ],
            Text(notification.content)
          ],
        ),
      ),
    );
  }
}
