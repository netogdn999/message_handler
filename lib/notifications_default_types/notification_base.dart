import 'package:flutter/material.dart';

import '../models/notification_message.dart';

abstract class NotificationBase {
  final Map<NotificationMessageLevel, Color> borderColor = const {
    NotificationMessageLevel.info: Colors.blue,
    NotificationMessageLevel.warning: Color(0xFFFFEF4A),
    NotificationMessageLevel.error: Color(0xFFDA1414)
  };
  const NotificationBase();
  
  Widget buildNotification(BuildContext context, NotificationMessage notification);
}