import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Reservation/Floor/bulding_plan.dart';
import 'package:vato/screens/Home/Reservation/Zones/list_view_desck.dart';

class SearchScreen extends StatefulWidget {
  int mapList;
  DateTime selectedDate;

  SearchScreen(this.mapList, this.selectedDate, {Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String DateString; //List<dynamic> listDesks = List<dynamic>();
  List<dynamic> Zones;
  DateTime startDate;
  DateTime endDate;
  int NBDesks;
  String tokenLogin;

  onSelect(data) async {
    setState(() {
      var newFormat = DateFormat("yyyy-MM-dd");
      DateString = newFormat.format(data);
      widget.selectedDate = data;
    });
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          //fontStyle: FontStyle.italic,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 10),
    );
  }
  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? LightColors.kbluer : Colors.white;
    TextStyle normalStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: LightColors.kDarkBlue);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName,
          style: !isSelectedDate
              ? TextStyle(fontSize: 14.5, color: fontColor)
              : selectedStyle),
      Text(date.day.toString(),
          style: !isSelectedDate
              ? TextStyle(fontSize: 14.5, color: fontColor)
              : selectedStyle),
    ];



    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color:
        !isSelectedDate ? Colors.transparent : NeumorphicColors.background,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }


  Future<SharedPreferences> _prefs;
  String user;
  int NBRZones = 0;
  Future<void>Date;
  DateTime DateNow;
  Future<void> GetDate() async {
    startDate =  DateTime.now();
     DateNow = startDate;

setState(() {
  widget.selectedDate=DateTime.now();
});
    if (DateNow.weekday.toString() == "4") {
      endDate = DateNow.add(Duration(days: 9));
    }
    else if ((DateNow.weekday.toString() == "5")) {
      endDate = DateNow.add(Duration(days: 8));
    }
    else if ((DateNow.weekday.toString() == "6")) {
      endDate = DateNow.add(Duration(days: 7));
    }
    else if ((DateNow
        .weekday
        .toString() == "7")) {
      endDate = DateNow.add(Duration(days: 6));
    }

    else if ((DateNow
        .weekday
        .toString() == "3")) {
      endDate = DateNow.add(Duration(days: 4));
    }
    else {
      endDate = DateNow.add(Duration(days: 5));
    }
  }

  @override
  initState() {
    Date = GetDate();
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        user = prefs.get("_id");
        tokenLogin = prefs.get("token");
      });
    });
    print("ssssssssssssssssssssss"+widget.selectedDate.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body:Column(
        children: [
          Container(
            color: LightColors.kDarkBlue,
            child: Column(
              children: [
                SizedBox(height: height / 20),
                FutureBuilder(
                    future:
                    Date,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none :
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.waiting :
                          return Container(height: 120,);
                        case ConnectionState.done :
                          return CalendarStrip(
                            containerHeight: 120,
                            startDate: startDate,
                            endDate: endDate,
                            selectedDate: widget.selectedDate,
                            onDateSelected: onSelect,
                            iconColor: Colors.white,
                            dateTileBuilder: dateTileBuilder,

                            monthNameWidget: _monthNameWidget,
                            containerDecoration: BoxDecoration(
                                color: LightColors.kDarkBlue),
                          );
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: DefaultTabController(
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
                          BuldingPlan(widget.selectedDate),
                          ListViewDesck(DateString, user, widget.selectedDate),
                        ],
                      ),
                    ),
                  ),
                )
              //   AppBarSearch(selectedDatee, user, widget.mapList, widget.selectedDate)

            ),
          )

          /* Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
               ),
            child: SearchScreen(),
          ),
        )*/
        ],
      ) ,
    );
  }
}

