/*
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Reservation/Floor/bulding_plan.dart';
import 'package:vato/screens/Home/Reservation/Zones/list_view_desck.dart';

class AppBarSearch extends StatefulWidget {
  String selectedDatee;
  DateTime selectedDate;
  String user;
  int mapList;

  AppBarSearch(this.selectedDatee, this.user, this.mapList, this.selectedDate,
      {Key key})
      : super(key: key);

  @override
  _AppBarSearchState createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {

  @override
  Widget build(BuildContext context) {
    final brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return DefaultTabController(
      length: 2,
      initialIndex: widget.mapList,
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: TabBar(
          indicatorColor: LightColors.kDarkBlue,
          tabs: [
            Tab(
                child: Text(
              "MapView",
              style: TextStyle(color: Colors.black),
            )),
            Tab(
                child: Text(
              "ListView",
              style: TextStyle(color: Colors.black),
            )),
          ],
        ),
        body: Container(
          child: TabBarView(
            // physics: NeverScrollableScrollPhysics(),

            children: [
              BuldingPlan(context, widget.selectedDate),

              ListViewDesck(
                  widget.selectedDatee, widget.user, widget.selectedDate),

            ],
          ),
        ),
      ),
    );
  }
}
*/
