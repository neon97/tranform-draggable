import 'package:flutter/material.dart';

class TransformDemo extends StatefulWidget {
  TransformDemo() : super();

  final String title = "Transform Demo";

  @override
  TransformDemoState createState() => TransformDemoState();
}

class TransformDemoState extends State<TransformDemo> {
  double width = 100.0, height = 100.0;
  Offset position;

  double rotateValue = 0;
  double threeDValue = 0;
  double skewValue = 0;
  double scaleValue = 0;
  double transValueHo = 0;
  double transValueVt = 0;

  @override
  initState() {
    super.initState();
    rotateValue = 0;
    threeDValue = 0;
    skewValue = 0;
    scaleValue = 0;
    transValueHo = 0;
    transValueVt = 0;
    position = Offset(0.0, height - 20);
  }

  Draggable diagram() {
    return Draggable(
      child: mainCont(context),
      feedback: mainCont(context),
      childWhenDragging: Container(),
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() => position = offset);
      },
    );
  }

  Slider rotate() {
    return Slider(
      value: rotateValue,
      min: 0,
      max: 100,
      onChanged: (val) {
        setState(() {
          rotateValue = val;
        });
      },
    );
  }

  Slider threeD() {
    return Slider(
      value: threeDValue,
      min: 0,
      max: 100,
      onChanged: (val) {
        setState(() {
          threeDValue = val;
        });
      },
    );
  }

  Slider skew() {
    return Slider(
      value: skewValue,
      min: 0,
      max: 100,
      onChanged: (val) {
        setState(() {
          skewValue = val;
        });
      },
    );
  }

  Slider scaling() {
    return Slider(
      value: scaleValue,
      min: 0,
      max: 100,
      onChanged: (val) {
        setState(() {
          scaleValue = val;
        });
      },
    );
  }

  Slider transHo() {
    return Slider(
      value: transValueHo,
      min: 0,
      max: MediaQuery.of(context).size.width / 2,
      onChanged: (val) {
        setState(() {
          transValueHo = val;
        });
      },
    );
  }

  Slider transVt() {
    return Slider(
      value: transValueVt,
      min: 0,
      max: MediaQuery.of(context).size.height / 2,
      onChanged: (val) {
        setState(() {
          transValueVt = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Rotate"),
                rotate(),
                Text("3D"),
                threeD(),
                Text("skew"),
                skew(),
                Text("scaling"),
                scaling(),
                Text("trans HO"),
                transHo(),
                Text("trans VT"),
                transVt(),
              ],
            ),
            Positioned(
              left: position.dx,
              top: position.dy - height + 20,
              child: diagram(),
            ),
          ],
        ));
  }

  Widget mainCont(BuildContext context) {
    return Container(
      //rotaion
      child: Transform.rotate(
        angle: rotateValue,
        origin: Offset(0.0, 0.0),

        //3D
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, threeDValue / 1000)
            ..rotateX(3.14 / 20.0),
          alignment: FractionalOffset.center,

          //skew
          child: Transform(
            transform: Matrix4.skewX(skewValue / 100),

            //scale
            child: Transform.scale(
              scale: scaleValue == 0 ? 1 : scaleValue / 50,
              origin: Offset(0.0, 0.0),

              //location
              child: Transform.translate(
                offset: Offset(transValueHo, transValueVt),
                child: getCont(context),
                // child: Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: AssetImage("images/text2.png"))),
                //   height: 100.0,
                //   width: 100.0,
                // ),
              ),
            ),
          ),
        ),
      ),
    )
    ;
  }

  Widget getCont(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image:AssetImage("images/text2.png",),fit: BoxFit.contain)
      ),
     
 
      width: width,
      height: height,
    );
  }
}
