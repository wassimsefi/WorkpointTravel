import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/detail%20mission/documents.dart';
import 'package:vato/travel/detail%20mission/stepperpage.dart';
import 'package:vato/widgets/topContainerBack.dart';
import 'package:vato/widgets/topContainerScan.dart';

class DetailMission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopContainerBack(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                    backgroundColor: NeumorphicColors.background,
                    appBar: TabBar(
                      indicatorWeight: 2,
                      indicatorColor: LightColors.kDarkBlue,
                      tabs: [
                        Tab(
                            child: Text(
                          "DetailMission",
                          style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text("Document",
                                style: TextStyle(color: Colors.black))),
                      ],
                    ),
                    body: TabBarView(
                      children: [Stepperpage(), Documents()],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
