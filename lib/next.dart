import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Drag app"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double width = 100.0, height = 100.0;
  Offset position ;

  @override
  void initState() {
    super.initState();
    position = Offset(0.0, height - 20);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: position.dx,
          top: position.dy - height + 20,
          child: Draggable(
            child: getCont(context),
            feedback: getCont(context),
            childWhenDragging: Container(),
            onDraggableCanceled: (Velocity velocity, Offset offset){
              setState(() => position = offset);
            },
          ),
        ),
      ],
    );
  }


  Widget getCont(BuildContext context)
  {
    return Container(
              child: Center(
                child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
              color: Colors.blue[300],
              width: width,
              height: height,
            );
  }
}
