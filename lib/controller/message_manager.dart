import 'dart:async';

import 'package:flutter/material.dart';

import '../notifications_default_types/notification_bottom_sheet.dart';
import '../notifications_default_types/notification_snack_bar.dart';
import '../message_handler_action.dart';
import '../middleware/message_handler_middleware.dart';
import '../models/notification_message.dart';
import '../notifications_default_types/notification_alert_dialog.dart';
import '../notifications_default_types/notification_base.dart';
import '../notifications_default_types/notification_persistent_snack_bar.dart';
import 'message_handler_controller.dart';

MessageHandlerActionInterface get messageHandler =>
    MessageHandlerAction.instance;

class MessageManager extends StatelessWidget {
  final Widget child;
  final MessageHandlerController _controller =
      MessageHandlerController.instance;

  /// The displayed visual of the [NotificationMessage] when the type are [NotificationMessageType.alertDialog].
  final NotificationBase? alertDialog;

  /// The displayed visual of the [NotificationMessage] when the type are [NotificationMessageType.snackBar].
  final NotificationSnackBar? snackBar;

  /// The displayed visual of the [NotificationMessage] when the type are [NotificationMessageType.bottomSheet].
  final NotificationBottomSheet? bottomSheet;

  /// The displayed visual of the [NotificationMessage] when the type are [NotificationMessageType.persistentSnackBar].
  final NotificationPersistentSnackBar? persistentSnackBar;

  /// List of [MessageHandlerMiddleware] that will be registred in the middlewares queue
  final List<MessageHandlerMiddleware>? middlewares;
  MessageManager({
    Key? key,
    required this.child,
    this.alertDialog,
    this.snackBar,
    this.bottomSheet,
    this.persistentSnackBar,
    this.middlewares,
  }) : super(key: key);

  /// Registers the [middlewares] in the queue.
  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      _listenerMessageManager(context, _controller);
    });
    if (middlewares != null) {
      _controller.middlewares.addAll(middlewares!);
    }
    return child;
  }

  /// Displays the first [NotificationMessage] in the queue.
  void _listenerMessageManager(
    BuildContext context,
    MessageHandlerController controller,
  ) {
    if (controller.haveNotification) {
      controller.hasMessageShowing = true;
      final currentNotification = controller.notifications.first;
      switch (currentNotification.type) {
        case NotificationMessageType.alertDialog:
          _showAlertDialog(context, currentNotification, controller).then((_) {
            _consumeNextMessage(controller);
          });
          break;
        case NotificationMessageType.snackBar:
          _showSnackBar(context, currentNotification).then((_) {
            _consumeNextMessage(controller);
          });
          break;
        case NotificationMessageType.bottomSheet:
          _showBottomSheet(context, currentNotification).then((_) {
            _consumeNextMessage(controller);
          });
          break;
        case NotificationMessageType.persistentSnackBar:
          _showPersistentSnackBar(context, currentNotification).then((_) {
            _consumeNextMessage(controller);
          });
          break;
      }
    }
  }

  /// Displays the next [NotificationMessage] in the queue.
  ///
  /// Remove the previously [NotificationMessage].
  void _consumeNextMessage(MessageHandlerController controller) {
    controller.removeMessage();
    if (controller.haveNotification) {
      controller.consumeMessage();
    }
  }

  /// Display the [NotificationMessage] of the type [NotificationMessageType.alertDialog].
  ///
  /// If the parameter [alertDialog] is null, the message will be displayed with the default visual.
  Future<void> _showAlertDialog(
    BuildContext context,
    NotificationMessage notification,
    MessageHandlerController controller,
  ) {
    final alert = alertDialog ?? const NotificationAlertDialog();
    return showDialog<void>(
      context: context,
      builder: (_) => alert.buildNotification(context, notification),
    ).then((_) async {
      if (notification.onDismiss != null) {
        await notification.onDismiss!();
      }
    });
  }

  /// Display the [NotificationMessage] of the type [NotificationMessageType.snackBar].
  ///
  /// If the parameter [snackBar] is null, the message will be displayed with the default visual.
  Future<void> _showSnackBar(
    BuildContext context,
    NotificationMessage notification,
  ) {
    final snackBar = this.snackBar ?? const NotificationSnackBar();
    return ScaffoldMessenger.of(context)
        .showSnackBar(
          snackBar.buildNotification(context, notification) as SnackBar,
        )
        .closed
        .then((_) async {
      if (notification.onDismiss != null) {
        await notification.onDismiss!();
      }
    });
  }

  /// Display the [NotificationMessage] of the type [NotificationMessageType.bottomSheet].
  ///
  /// If the parameter [bottomSheet] is null, the message will be displayed with the default visual.
  Future<void> _showBottomSheet(
    BuildContext context,
    NotificationMessage notification,
  ) {
    final bottomSheet = this.bottomSheet ?? const NotificationBottomSheet();
    return showModalBottomSheet(
      context: context,
      builder: (_) => bottomSheet.buildNotification(context, notification),
    ).then((_) async {
      if (notification.onDismiss != null) {
        await notification.onDismiss!();
      }
    });
  }

  /// Display the [NotificationMessage] of the type [NotificationMessageType.persistentSnackBar].
  ///
  /// If the parameter [persistentSnackBar] is null, the message will be displayed with the default visual.
  Future<void> _showPersistentSnackBar(
    BuildContext context,
    NotificationMessage notification,
  ) {
    final persistentSnackBar =
        this.persistentSnackBar ?? const NotificationPersistentSnackBar();
    return ScaffoldMessenger.of(context)
        .showSnackBar(
          persistentSnackBar.buildNotification(
            context,
            notification,
          ) as SnackBar,
        )
        .closed
        .then((_) async {
      if (notification.onDismiss != null) {
        await notification.onDismiss!();
      }
    });
  }
}
