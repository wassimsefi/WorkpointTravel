import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vato/constants/light_colors.dart';

class TopContainerOld extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainerOld({this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0,),
        decoration: BoxDecoration(
            color: LightColors.kDarkBlue,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(59.0),
            )),
        height: height,
       // margin: EdgeInsets.only(top: 15),
        width: width,
        child: child,
      ),
    );
  }
}
