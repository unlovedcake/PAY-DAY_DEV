import 'package:flutter/material.dart';
import 'dart:math' as math;

IntrinsicWidth test(){
  return 
  IntrinsicWidth(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Divider(height:1,color: Colors.black,),
      ],
    )
  );
}

Expanded gk_horizontalLine({Color color = Colors.black}){
  return
    Expanded(
      child: Column(
        children: [
          Divider(
            color: color
          )
        ],
      ),
    );
}


class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key? key, required this.diameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}


// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF9ECA7D);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: 800,
        width: 800,
      ),
      0,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}