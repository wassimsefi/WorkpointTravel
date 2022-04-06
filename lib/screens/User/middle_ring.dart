import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/screens/User/neumorphic_pie.dart';

class MiddleRing extends StatelessWidget {
  final num width;

  const MiddleRing({Key key, @required this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        color:NeumorphicColors.background,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: width * 0.3,
          width: width * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Edge shadow
              BoxShadow(
                offset: Offset(-1.5, -1.5),
                color: shadowColor,
                spreadRadius: 2.0,
                // blurRadius: 0,
              ),

              // Circular shadow
              BoxShadow(
                offset: Offset(1.5, 1.5),
                color: NeumorphicColors.background,
                spreadRadius: 2.0,
                blurRadius: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}