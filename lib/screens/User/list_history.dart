import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/HistoryService.dart';

class ListHistory extends StatefulWidget {
  ListHistory({Key key}) : super(key: key);

  @override
  _ListHistoryState createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  int _selectedIndex = 0;
  Future<SharedPreferences> _prefs;
  int NBRreservation;
  String tokenLogin;
  String idUser;
  int NBHistory;
  List<dynamic> Histories = [];
  HistoryService rs = new HistoryService();

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        //  Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
        // String id = prefs.get("_id");
        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
      });
    });
    super.initState();
  }

  Widget _getStatutsHistory(x) {
    if (x == "CHECKOUT")
      return AutoSizeText(
        "Checkout",
        style: TextStyle(
          //customize depth here
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
          //customize color here
        ),
        maxLines: 1,
        minFontSize: 8,
      );
    if (x == "CHECKIN")
      return AutoSizeText(
        "CheckIn",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
        maxLines: 1,
        minFontSize: 8,
      );

    if (x == "CANCELLATION")
      return AutoSizeText(
        "Cancellation",
        style: TextStyle(
            //customize depth here
            color: Colors.red,
            //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        minFontSize: 7,
      );
    if (x == "RESERVATION")
      return AutoSizeText(
        "Reservation",
        style: TextStyle(
//customize depth here
            color: Colors.orange,
            //customize color here

            fontSize: 11,
            fontWeight: FontWeight.bold
            //customize size here
            // AND others usual text style properties (fontFamily, fontWeight, ...)
            ),
        maxLines: 1,
        minFontSize: 7,
      );
    if (x == "WFH_CANCELLATION")
      return AutoSizeText(
        "Cancellation",
        style: TextStyle(
            //customize depth here
            color: Colors.red,
            //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        minFontSize: 7,
      );
    if (x == "WFH_SUBMISSION")
      return AutoSizeText(
        "Submission",
        style: TextStyle(
            //customize depth here
            color: Colors.orange,
            //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        minFontSize: 7,
      );
    if (x == "WFH_APPROVAL")
      return AutoSizeText(
        "Approval",
        style: TextStyle(
          //customize depth here
            color: Colors.green,
            //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        minFontSize: 7,
      );
    if (x == "WFH_REJECTION")
      return AutoSizeText(
        "Rejection",
        style: TextStyle(
          //customize depth here
            color: Colors.orange,
            //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold),
        maxLines: 1,
        minFontSize: 7,
      );
    else {
      return AutoSizeText(
        "",
        style: TextStyle(
            //customize depth here
            color: Colors.grey, //customize color here
            fontSize: 11,
            fontWeight: FontWeight.bold
            //customize size here
            // AND others usual text style properties (fontFamily, fontWeight, ...)
            ),
        maxLines: 1,
        minFontSize: 8,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: NeumorphicColors.background,
            body: Center(
              child: FutureBuilder(
                  future: rs
                      .getHistopryByUser(this.idUser, this.tokenLogin)
                      .then((value) {

                    Histories = value["data"];
                    Histories.sort(
                        (a, b) => b["updatedAt"].compareTo(a["updatedAt"]));

                    if (value["data"] != null) {
                      NBHistory = value["data"].length;
                    }
                  }),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return CircularProgressIndicator();
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        return (NBHistory == 0)
                            ? Center(
                                child: Text("No History"),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                        padding: EdgeInsets.all(1),
                                        itemCount: Histories.length,
                                        itemBuilder: (context, x) {
                                          return (Histories[x]["type"] ==
                                                  "Reservation")
                                              ? HistoryReservation(
                                                  _height, width, x)
                                              : (Histories[x]["type"] ==
                                                      "Request")
                                                  ? HistoryRequets(
                                                      _height, width, x)
                                                  : HistoryOperation (
                                                      _height, width, x);
                                        }),
                                  ),
                                ],
                              );
                    }
                    return CircularProgressIndicator();
                  }
                  // By default, show a loading spinner

                  ),
            )));
  }

  Widget HistoryReservation(_height, width, x) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
        height: 100,
        width: width,
        child: Neumorphic(
            style: NeumorphicStyle(
              color: NeumorphicColors.background,
            ),
            child: Container(
                //  margin: EdgeInsets.all(30),
                child: Row(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: 20,
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Icon(
                            Icons.apartment_outlined,
                            color: LightColors.OnSite,
                            size: 30,
                          ),
                        )),
                      ),
                    )),
                Spacer(),
                Container(
                  width: 140,
                  height: 130,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        AutoSizeText(
                          Histories[x]["Desk"],
                          style: TextStyle(color: Colors.black, fontSize: 17),
                          maxLines: 1,
                          minFontSize: 13,
                        ),
                        AutoSizeText(
                          Histories[x]["zone"] + "/" + Histories[x]["floor"],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          minFontSize: 9,
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              new DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(Histories[x]["time"]))
                                  .toString(),
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              Histories[x]["slot"].toString(),
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 20),
                    child: Container(
                      width: 60,
                      height: 180,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Column(
                              children: [
                                _getStatutsHistory(
                                    Histories[x]["TransactionType"]),
                                AutoSizeText(
                                  new DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                                AutoSizeText(
                                  new DateFormat(' HH:mm ')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ))
              ],
            ))),
      ),
    );
  }

  Widget HistoryOperation(_height, width, x) {
    return Padding(
      padding: EdgeInsets.only(bottom:10),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
        height: 120,
        width: width,
        child: Neumorphic(
            style: NeumorphicStyle(
              color: NeumorphicColors.background,
            ),
            child: Container(
                //  margin: EdgeInsets.all(30),
                child: Row(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: 20,
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Icon(
                            Icons.home_work_outlined,
                            color: LightColors.Telework,
                            size: 30,
                          ),
                        )),
                      ),
                    )),
                Spacer(),
                Container(
                  width: 140,
                  height: 130,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons
                                  .person,
                              color: Colors
                                  .black54,),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                Histories[x]["Manager"],
                                style: TextStyle(
                                    color: Colors
                                        .black54,
                                    fontSize: 15),
                                maxLines: 2,
                                minFontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              new DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(Histories[x]["time"]))
                                  .toString(),
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              Histories[x]["slot"].toString(),
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        )
                        //      Histories[x]["slot"].toString() == "PM"
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 20),
                    child: Container(
                      width: 60,
                      height: 180,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Column(
                              children: [
                                _getStatutsHistory(
                                    Histories[x]["TransactionType"]),
                                AutoSizeText(
                                  new DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                                AutoSizeText(
                                  new DateFormat(' HH:mm ')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ))
              ],
            ))),
      ),
    );
  }

  Widget HistoryRequets(_height, width, x) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
        height: 100,
        width: width,
        child: Neumorphic(
            style: NeumorphicStyle(
              color: NeumorphicColors.background,
            ),
            child: Container(
                //  margin: EdgeInsets.all(30),
                child: Row(
              children: [
                Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: 20,
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Center(
                            child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Icon(
                            Icons.home_work_outlined,
                            color: LightColors.Telework,
                            size: 30,
                          ),
                        )),
                      ),
                    )),
                Spacer(),
                Container(
                  width: 140,
                  height: 130,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons
                                  .person,
                              color: Colors
                                  .black54,),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                Histories[x]["Manager"],
                                style: TextStyle(
                                    color: Colors
                                        .black54,
                                    fontSize: 15),
                                maxLines: 2,
                                minFontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 9.0,
                        ),

                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 20),
                    child: Container(
                      width: 60,
                      height: 180,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Column(
                              children: [
                                _getStatutsHistory(
                                    Histories[x]["TransactionType"]),
                                AutoSizeText(
                                  new DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                                AutoSizeText(
                                  new DateFormat(' HH:mm ')
                                      .format(DateTime.parse(
                                          Histories[x]["updatedAt"]))
                                      .toString(),
                                  style: TextStyle(
                                      //customize depth here
                                      color: Colors.grey,
                                      //customize color here
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                      //customize size here
                                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      ),
                                  maxLines: 1,
                                  minFontSize: 9,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ))
              ],
            ))),
      ),
    );
  }
}
