import 'package:flutter/material.dart';
import 'package:testing/next.dart';
import 'package:testing/transform_demo.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
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
     return TransformDemo();
  }
}




