import 'package:flutter/material.dart';
import 'package:widget_lifecycle/pages/example_page.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.counter, @required this.onPress})
      : super(key: key);

  int counter;
  final Function onPress;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    print('Widget Lifecycle: initState');
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    print('Widget Lifecycle: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');
    if (this.widget.counter != oldWidget.counter) {
      print('Count has changed');
    }
  }

  @override
  void deactivate() {
    print('Widget Lifecycle: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Widget Lifecycle: dispose');
    _animationController.dispose();
    super.dispose();
  }

  void misbehave() {
    try {
      dynamic foo = true;
      print(foo++); // Runtime error
    } catch (e) {
      print('misbehave() partially handled ${e.runtimeType}.');
      rethrow; // Allow callers to see the exception.
    }
  }

  void misbehaveAsync() async {
    try {
      dynamic foo = true;
      print(foo++); // Runtime error
    } catch (e) {
      print('misbehave() partially handled ${e.runtimeType}.');
      rethrow; // Allow callers to see the exception.
    }
  }

  void _incrementCounter() async {
    try {
      misbehave();
      misbehaveAsync();
    } catch (e) {
      print('main() finished handling ${e.runtimeType}.');
      rethrow;
    }

    // setState(() {
    //   widget.counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Lifecycle: build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget Lifecycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${widget.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {
                throw CustomException();
              },
              child: Text('Custom Exception'),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {
                final int hundred = 100;
                var result = hundred ~/ 0;
                debugPrint("$result");
              },
              child: Text('Division by Zero'),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: widget.onPress,
              child: Text('Reset count'),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
              child: Text('Navigate to new route'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomException implements Exception {
  @override
  String toString() {
    return "My Custom Exception";
  }
}
