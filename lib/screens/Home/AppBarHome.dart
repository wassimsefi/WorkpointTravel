/*
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Calendar .dart';
import 'package:vato/screens/User/list_history.dart';

class Appbar extends StatefulWidget {
  BuildContext context;
  Appbar(this.context, {Key key}) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: NeumorphicColors.background,
          appBar: TabBar(
            indicatorWeight: 2,
            indicatorColor: LightColors.kDarkBlue,
            tabs: [
              Tab(child: Text("Active Reservation",style: TextStyle(color: Colors.black),)),
              Tab(child: Text("History",style: TextStyle(color: Colors.black),)),
            //  Tab(child: Text("History",style: TextStyle(color: Colors.black),)),

            ],
          ),
          body: TabBarView(
            children: [
              ListReservation(widget.context),
              ListHistory(),
             // ListHistory(),

            ],
          )),
    );
  }
}
*/
