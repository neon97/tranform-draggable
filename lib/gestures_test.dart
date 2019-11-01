import 'package:flutter/material.dart';

class GDTest extends StatefulWidget {
  @override
  _GDTestState createState() => _GDTestState();
}

class _GDTestState extends State<GDTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 200.0,
          ),
          Container(
            color: Colors.blue,
            height: 500.0,
            width: 200.0,
          ),
          
        ],
      )),
    );
  }
}
