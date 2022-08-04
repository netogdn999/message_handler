## Getting started
the `MessageManager` class should be added at the top of the widget tree, this class will allow both editing the desgin of standard messages, sending messages and adding middlwares as in the example below:

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MessageManager(
        middlewares: , // add list of middlewares, middlewares must inherit from base class: MessageHandlerMiddleware. called before messages are shown [optional, default => null]
        alertDialog: , // Change the base design of the alert dialog emitted by the message handler [optional, default => null]
        bottomSheet: , // Change the base design of the bottom sheet emitted by the message handler [optional, default => null]
        persistentSnackBar: , // Change the base design of the persistent snack bar emitted by the message handler [optional, default => null]
        snackBar: , // Change the base design of the snack bar emitted by the message handler [optional, default => null]
        child: const MyHomePage(title: 'Flutter Demo Home Page'), // [required]
      ),
    );
  }
}
```
To send the messages, just call the sendMessage function using the messageHandler keyword.

```dart
messageHandler.sendMessage(
    message: NotificationMessage(
        level: , // Declare the message level, being these: info, warning, error. Must be accessed by the NotificationMessageLevel enum [optional, default => error]
        title: , // Title of the message [optional, default => null]
        type: , // Declare the message type, being these: alertDialog, snackBar, bottomSheet,persistentSnackBar. Must be accessed by the NotificationMessageType enum [optional, default => null]
        content: "testing alert dialog", // content of the message [required]
        onDismiss: () {} // called when the message was dismissed [optional, default => null]
    ),
);
```
We can also call the middlewares without triggering a message to the user, just call the sendMessageToMiddlewares method

```dart
messageHandler.sendMessageToMiddlewares(
    level: NotificationMessageLevel.error, // Declare the message level, being these: info, warning, error. Must be accessed by the NotificationMessageLevel enum [required]
    message: "testing middleware" // [optional, default => null]
    throwable: , // Exception thrown, [option, default => null] 
);
```