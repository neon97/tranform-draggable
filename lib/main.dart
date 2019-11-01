import 'package:flutter/material.dart';
import 'package:testing/gestures_test.dart';
import 'package:testing/next.dart';
import 'package:testing/transform_demo.dart';

import 'multi_demo.dart';
import 'multi_demo2.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.pinkAccent,
    ),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // return MyApp();
    // return TransformDemo();
    //return ExampleScreen();
    // return MyHomePage();
    return GDTest();
  }
}
