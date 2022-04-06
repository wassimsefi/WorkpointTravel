import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Mission/add_missions.dart';
import 'package:vato/widgets/topContainerScan.dart';

class TabMission extends StatelessWidget {
  const TabMission({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopContainer(),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Expanded(
                child: Container(
                 // padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: NeumorphicColors.background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child:  AddMissions(),

                ),
              ),
            ),
          )
        ],
      ),
        )
    );

  }
}
