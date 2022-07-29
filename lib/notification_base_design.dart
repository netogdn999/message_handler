import 'package:flutter/material.dart';

import 'models/notification_message.dart';

abstract class NotificationBaseDesign {
  Widget buildNotification(BuildContext context, NotificationMessage notification);
}