import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/widgets/stepper.dart';
import 'package:vato/widgets/topContainerScan.dart';

class AddMissions extends StatefulWidget {
  const AddMissions({Key key}) : super(key: key);

  @override
  _AddMissionsState createState() => _AddMissionsState();
}

class _AddMissionsState extends State<AddMissions> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: StepperWidget(),
            ),
          )
        ],
      ),
    );
  }
}
