import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/HistoryService.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<SharedPreferences> _prefs;
  String user;
  String tokenLogin;
  List Historys;
  int NBHistorys = 0;

  HistoryService _historyService = new HistoryService();

  Map<String, dynamic> payload;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        user = prefs.get("_id");
        tokenLogin = prefs.get("token");
      });
      payload = Jwt.parseJwt(
        this.tokenLogin.toString(),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: buildListView(),
    );
  }

  Widget buildListView() {
    String prevDay;

    return FutureBuilder(
        future:
            _historyService.getHistopryByUser(user, tokenLogin).then((value) {
          Historys = value["data"];
          Historys.sort((a, b) => b["updatedAt"].compareTo(a["updatedAt"]));

          if (value["data"] != null) {
            NBHistorys = value["data"].length;
          }
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: LightColors.kDarkBlue,
                  size: 50,
                ),
              ));
            case ConnectionState.waiting:
              return Center(
                  child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                  color: LightColors.kDarkBlue,
                  size: 50,
                ),
              ));
            case ConnectionState.done:
              return (NBHistorys == 0)
                  ? Center(
                      child: Text("No Histories"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: Historys.length,
                      itemBuilder: (context, index) {
                        // List<dynamic> transaction = Historys[index];
                        DateTime date =
                            DateTime.fromMillisecondsSinceEpoch(DateTime.now()
                                .add(Duration(
                                  days: Jiffy(Historys[index]["updatedAt"]).day,
                                  hours:
                                      Jiffy(Historys[index]["updatedAt"]).hour,
                                  minutes: Jiffy(Historys[index]["updatedAt"])
                                      .minute,
                                ))
                                .millisecondsSinceEpoch);
                        String dateString =
                            Jiffy(Historys[index]["updatedAt"]).yMMMMEEEEd;

                        bool showHeader = prevDay != dateString;
                        prevDay = dateString;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            showHeader
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Text(
                                      dateString,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  )
                                : Offstage(),
                            buildItem(
                              index,
                              context,
                              date,
                              Historys[index],
                            ),
                          ],
                        );
                      });
          }

          return Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: LightColors.kDarkBlue,
              size: 50,
            ),
          );
        });
  }

  Widget buildItem(int index, BuildContext context, DateTime date,
      Map<String, dynamic> Historys) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(width: 20),
          buildLine(index, context),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(Historys, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(Map<String, dynamic> Historys, BuildContext context) {
    print("Historys :" + Historys.toString());
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Historys["TransactionType"] == "DELETE_MISSION"
                  ? [Colors.deepOrange[300], Colors.red]
                  : [Colors.blue, Color(0xFF002171)]),
          //  colors: [Colors.green, Colors.teal]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                Historys["TransactionType"] == "DELETE_MISSION"
                    ? "Delete Mission"
                    : "Add Mission",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      Historys["message"],
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Icon(
                            Icons.airplanemode_active,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildLine(int index, BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
