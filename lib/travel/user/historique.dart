import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/services/HistoryService.dart';
import 'package:vato/services/Notification.dart';
import 'package:vato/widgets/topContainerScan.dart';

class Historique extends StatefulWidget {
  List missions;
  Historique(this.missions, {Key key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  Future<SharedPreferences> _prefs;
  String user;
  String tokenLogin;
  List Notifications;
  int NBnotifications = 0;

  HistoryService _historyService = new HistoryService();

  Map<String, dynamic> payload;

  @override
  void initState() {
    DateTime datetimeenow = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd");
    //DateNow = newFormat.format(datetimeenow);
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        //  Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
        //firstname = prefs.get("firstname");
        user = prefs.get("_id");
        tokenLogin = prefs.get("token");
      });
      payload = Jwt.parseJwt(
        this.tokenLogin.toString(),
      );
    });
    final date2 = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime selectedDate;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightColors.kDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: NeumorphicColors.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: _historyService
                            .getHistopryByUser(user, tokenLogin)
                            .then((value) {
                          Notifications = value["data"];
                          Notifications.sort((a, b) =>
                              b["updatedAt"].compareTo(a["updatedAt"]));

                          if (value["data"] != null) {
                            NBnotifications = value["data"].length;
                          }
                        }),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.done:
                              return (NBnotifications == 0)
                                  ? Center(
                                      child: Text("No Histories"),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.all(1),
                                      key: new Key("NotificationList"), //new
                                      itemCount: Notifications.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          background: Container(
                                            color: NeumorphicColors.background,
                                          ),
                                          key: ValueKey<dynamic>(
                                              Notifications[index]),
                                          onDismissed:
                                              (DismissDirection direction) {
                                            setState(() {
                                              Notifications.removeAt(index);
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: InkWell(
                                              onTap: () {
                                                /*                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DetailRequest(Requests[x]["_id"], Requests[x]["idReciever"]["firstname"] +" "+Requests[x]["idReciever"]["lastname"], new DateFormat('yyyy-MM-dd HH:mm').format(DateTime.tryParse(Requests[x]["createdAt"])).toString(),Requests[x]["UserNotif"],Requests[x]["status"].toString())
                                              ));*/
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  height: 80,
                                                  width: width,
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      color: NeumorphicColors
                                                          .background,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 80,
                                                                  child: Center(
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.all(1.0),
                                                                        child: FittedBox(
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          child:
                                                                              Icon(
                                                                            Icons.airplanemode_active,
                                                                            color:
                                                                                LightColors.LLviolet,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                    child: AutoSizeText(
                                                                        Notifications[index]["message"]
                                                                            .toString(),
                                                                        maxLines:
                                                                            5,
                                                                        minFontSize:
                                                                            5,
                                                                        maxFontSize:
                                                                            15,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Spacer(),
                                                                Text(
                                                                  Jiffy(Notifications[
                                                                              index]
                                                                          [
                                                                          "updatedAt"])
                                                                      .fromNow()
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        );
                                      });
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
