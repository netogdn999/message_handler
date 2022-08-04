import 'package:flutter/material.dart';
import 'package:message_handler/message_handler.dart';
import 'package:message_handler/models/notification_message.dart';

void main() {
  runApp(const MyApp());
}

class TestMiddleware implements MessageHandlerMiddleware {
  const TestMiddleware();
  @override
  void didShowMessage({required NotificationMessageLevel level, String? message, Object? throwable}) {
    debugPrint({
      level: level,
      message: message,
      throwable: throwable,
    }.toString());
  }

}

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
        middlewares: const [TestMiddleware()],
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      messageHandler.sendMessage(
        message: NotificationMessage(
          content: "testando alert dialog",
          onDismiss: () {
          }
        ),
      );
      messageHandler.sendMessage(
        message: NotificationMessage(
          title: "title",
          content: "testando snack bar",
          type: NotificationMessageType.snackBar,
          onDismiss: () {
          }
        ),
      );
      messageHandler.sendMessage(
        message: NotificationMessage(
          title: "title",
          content: "testando modal bottom sheet",
          type: NotificationMessageType.bottomSheet,
          level: NotificationMessageLevel.info,
          onDismiss: () {
          }
        ),
      );
      messageHandler.sendMessage(
        message: NotificationMessage(
          title: "title",
          content: "testando persistent snack bar",
          type: NotificationMessageType.persistentSnackBar,
          level: NotificationMessageLevel.warning,
          onDismiss: () {
          }
        ),
      );
      messageHandler.sendMessageToMiddlewares(
        level: NotificationMessageLevel.error,
        message: "testando middleware"
      );
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
