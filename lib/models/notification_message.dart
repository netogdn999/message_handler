import 'dart:async';

enum NotificationMessageType {
  alertDialog,
  snackBar,
  bottomSheet,
  persistentSnackBar,
}

enum NotificationMessageLevel {
  info,
  warning,
  error,
}

class NotificationMessage {
  final String? title;
  final String content;
  final NotificationMessageType type;
  final NotificationMessageLevel level;
  final FutureOr<void> Function()? onDismiss;

  NotificationMessage({
    required this.content,
    this.title,
    this.type = NotificationMessageType.alertDialog,
    this.level = NotificationMessageLevel.error,
    this.onDismiss,
  });
}
