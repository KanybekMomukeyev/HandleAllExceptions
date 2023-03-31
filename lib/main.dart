import 'package:flutter/material.dart';
import 'dart:async';
import 'pages/home_page.dart';

Future<void> main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      print('This is an error on the Flutter SDK');
      print(errorDetails.exception);
      print('-----');
      print(errorDetails.stack);
    };

    runApp(MyApp());
  }, (error, stackTrace) {
    print('This is a pure Dart error');
    print(error);
    print('-----');
    print(stackTrace);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        counter: counter,
        onPress: resetCounter,
      ),
    );
  }
}
