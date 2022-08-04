import 'package:flutter/material.dart';

import '../models/notification_message.dart';

/// The visual base classe of the messages.
///
/// It has the default colors values ​​used.
abstract class NotificationBase {
  /// The default colors values.
  final Map<NotificationMessageLevel, Color> borderColor = const {
    NotificationMessageLevel.success: Color(0xFFA5D6A7),
    NotificationMessageLevel.info: Colors.blue,
    NotificationMessageLevel.warning: Color(0xFFFFEF4A),
    NotificationMessageLevel.error: Color(0xFFDA1414)
  };
  const NotificationBase();

  /// Constructor of the Notifications
  Widget buildNotification(
    BuildContext context,
    NotificationMessage notification,
  );
}
