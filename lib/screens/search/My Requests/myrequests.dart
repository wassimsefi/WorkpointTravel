import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Mission/detail_request_mission.dart';
import 'package:vato/screens/search/My%20Requests/detail_request.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:vato/widgets/topContainerScan.dart';

class Myrequests extends StatefulWidget {
  final int manager;
  const Myrequests(this.manager, {Key key}) : super(key: key);

  @override
  _MyrequestsState createState() => _MyrequestsState();
}

class _MyrequestsState extends State<Myrequests> {
  Future<SharedPreferences> _prefs;
  String tokenLogin;
  String idUser;
  RequestService _requestService = new RequestService();
  UserService _userService = new UserService();

  List<dynamic> Requests = [];
  final DateRangePickerController _controller = DateRangePickerController();

  List<dynamic> filtred = [];
  List<dynamic> Dates = [];
  List<dynamic> Users = [];
  List<dynamic> Operations = [];
  bool isBefore = false;

  final List<DropdownMenuItem> manager = [];

  String selectedValue;
  int NBRequests;
  Future<dynamic> getMyrequets;
  dynamic user;
  OperationService _operationService = new OperationService();

  void _filterResources(startDate, EndDate) {
    setState(() {
      filtred = Requests.where((element) =>
          Jiffy(element["createdAt"]).isBetween(startDate, EndDate)).toList();
      print("test !!!" + filtred.toString());
    });
  }

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
      });

      getMyrequets =
          _requestService.getRequestByUser(idUser, tokenLogin).then((value) {
        setState(() {
          filtred = Requests = value["data"];

          print("object" + filtred.toString());
          Requests.sort((a, b) => b["updatedAt"].compareTo(a["updatedAt"]));
        });

        if (value["data"] != null) {
          NBRequests = value["data"].length;
        }
      });

      _userService.getUserProfil(idUser, tokenLogin).then((userData) {
        user = userData["data"];
        _userService.getMangers(tokenLogin).then((value) {
          Users = value["data"];

          Users.asMap().forEach((index, element) {
            if (userData["data"]["_id"].toString() !=
                element["_id"].toString()) {
              setState(() {
                manager.add(
                  DropdownMenuItem(
                      child: Text(
                          element["firstname"] + " " + element["lastname"]),
                      value: element["_id"]),
                );
              });
            }
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime selectedDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LightColors.kDarkBlue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopContainer(),

/*          (role=="manager")? TeamRequest()
              :*/
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("My requests",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          child: Icon(Icons.calendar_today_outlined),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor:
                                          NeumorphicColors.background,
                                      title: Text(''),
                                      content: Container(
                                        color: NeumorphicColors.background,
                                        height: 300,
                                        width: 300,
                                        child: Column(
                                          children: <Widget>[
                                            getDateRangePicker(),
                                            MaterialButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ));
                                });
                          },
                        ),
                        Container(
                          color: Colors.black45,
                          height: 30,
                          width: 2,
                        ),
                        SearchChoices.single(
                          items: manager,
                          value: selectedValue,
                          hint: " Validator",

                          searchHint: "Select your validator",
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              filtred = Requests.where((element) =>
                                  element["idReciever"]["_id"]
                                      .toString()
                                      .contains(value)).toList();
                            });
                          },
                          //   isExpanded: true,
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: getMyrequets,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.done:
                                return (NBRequests == 0)
                                    ? Center(
                                        child: Text("No Requests"),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.all(1),
                                        itemCount: filtred.length,
                                        itemBuilder: (context1, x) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: InkWell(
                                              onTap: () {
                                                // print("000000000"+filtred[x]["mission"]["departureCountryAller"].toString());
                                                Navigator.push(
                                                    context,
                                                    filtred[x]["name"] == "Mission"
                                                        ? MaterialPageRoute(
                                                            builder: (context) => DetailRequestMission(
                                                                filtred[x]
                                                                    ["_id"],
                                                                filtred[x]["idReciever"][
                                                                        "firstname"] +
                                                                    " " +
                                                                    filtred[x]
                                                                            ["idReciever"]
                                                                        [
                                                                        "lastname"],
                                                                new DateFormat(
                                                                        'yyyy-MM-dd HH:mm')
                                                                    .format(
                                                                        DateTime.tryParse(filtred[x]["createdAt"]))
                                                                    .toString(),
                                                                ["testt 111", "test 2222"],
                                                                filtred[x]["status"].toString(),
                                                                filtred[x]["idReciever"]["photo"],
                                                                filtred[x]["mission"]["comment"],
                                                                filtred[x]["mission"]))
                                                        : MaterialPageRoute(builder: (context) => DetailRequest(filtred[x]["_id"], filtred[x]["idReciever"]["firstname"] + " " + filtred[x]["idReciever"]["lastname"], new DateFormat('yyyy-MM-dd HH:mm').format(DateTime.tryParse(filtred[x]["createdAt"])).toString(), filtred[x]["UserNotif"], filtred[x]["status"].toString(), filtred[x]["idReciever"]["photo"], filtred[x]["commentUser"], filtred[x]["commentManager"])));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 25, 10, 10),
                                                height: 120,
                                                width: width,
                                                child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      color: NeumorphicColors
                                                          .background,
                                                    ),
                                                    child: Container(
                                                      //  margin: EdgeInsets.all(30),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Neumorphic(
                                                                style:
                                                                    NeumorphicStyle(
                                                                  shape:
                                                                      NeumorphicShape
                                                                          .flat,
                                                                  depth: 20,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  child: Center(
                                                                    child: Requests[x]["name"].toString() ==
                                                                            "WFH"
                                                                        ? FittedBox(
                                                                            fit:
                                                                                BoxFit.fitWidth,
                                                                            child:
                                                                                Icon(
                                                                              Icons.home_work_outlined,
                                                                              color: LightColors.Telework,
                                                                              size: 30,
                                                                            ),
                                                                          )
                                                                        : Requests[x]["name"].toString() ==
                                                                                "Mission"
                                                                            ? FittedBox(
                                                                                fit: BoxFit.fitWidth,
                                                                                child: Icon(
                                                                                  Icons.airplanemode_active,
                                                                                  color: LightColors.LLviolet,
                                                                                  size: 30,
                                                                                ),
                                                                              )
                                                                            : FittedBox(
                                                                                fit: BoxFit.fitWidth,
                                                                                child: Icon(
                                                                                  Icons.home_work_outlined,
                                                                                  color: LightColors.Telework,
                                                                                  size: 30,
                                                                                ),
                                                                              ),
                                                                  ),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            flex: 9,
                                                            child: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            30.0),
                                                                    child:
                                                                        Center(
                                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              child: (filtred[x]["name"].toString() == "WFH")
                                                                                  ? AutoSizeText(
                                                                                      filtred[x]["name"],
                                                                                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                      maxLines: 1,
                                                                                    )
                                                                                  : (filtred[x]["name"].toString() == "Mission")
                                                                                      ? AutoSizeText(
                                                                                          "Mission : " + filtred[x]["mission"]["title"].toString(),
                                                                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                          maxLines: 1,
                                                                                        )
                                                                                      : AutoSizeText(
                                                                                          "Remote Working",
                                                                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                          maxLines: 1,
                                                                                        ),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              40.0),
                                                                      child: (filtred[x]["name"].toString() ==
                                                                              "Mission")
                                                                          ? Column(
                                                                              children: [
                                                                                Center(
                                                                                  child: filtred[x]["mission"]["onewayDepartureCountry"] == null
                                                                                      ? Expanded(
                                                                                          child: AutoSizeText("pas de deolacement", style: TextStyle(color: Colors.black54, fontSize: 10)),
                                                                                        )
                                                                                      : Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                                                                          Expanded(
                                                                                            child: AutoSizeText(filtred[x]["mission"]["onewayDepartureCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 10)),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 0,
                                                                                          ),

                                                                                          Icon(
                                                                                            Icons.compare_arrows,
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 2,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: AutoSizeText(filtred[x]["mission"]["onewayDestinationCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 10)),
                                                                                          ),

                                                                                          //  Expanded( child: AutoSizeText(filtred[x]["mission"]["departureCountryAller"], style: TextStyle(color: Colors.black54)),)
                                                                                        ]),
                                                                                ),
                                                                                filtred[x]["mission"]["roundTrip"] == true
                                                                                    ? Center(
                                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                                                                          Expanded(
                                                                                            child: AutoSizeText(filtred[x]["mission"]["returnDepartureCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 10)),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 0,
                                                                                          ),

                                                                                          Icon(
                                                                                            Icons.compare_arrows,
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 2,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: AutoSizeText(filtred[x]["mission"]["returnDestinationCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 10)),
                                                                                          ),

                                                                                          //  Expanded( child: AutoSizeText(filtred[x]["mission"]["departureCountryAller"], style: TextStyle(color: Colors.black54)),)
                                                                                        ]),
                                                                                      )
                                                                                    : Container(),
                                                                              ],
                                                                            )
                                                                          : Container()),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0),
                                                                    child:
                                                                        Center(
                                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          children: <
                                                                              Widget>[
                                                                            Icon(
                                                                              Icons.person,
                                                                              color: Colors.black54,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Expanded(
                                                                              child: AutoSizeText(filtred[x]["idReciever"]["firstname"] + " " + Requests[x]["idReciever"]["lastname"], style: TextStyle(color: Colors.black54)),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Column(
                                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                GestureDetector(
                                                                    child:
                                                                        NeumorphicIcon(
                                                                      Icons
                                                                          .cancel,
                                                                      size: 25,
                                                                      style: NeumorphicStyle(
                                                                          depth:
                                                                              20,
                                                                          color:
                                                                              LightColors.kRed),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      List<dynamic>
                                                                          Operationss =
                                                                          [];
                                                                      String
                                                                          OldDate =
                                                                          "";
                                                                      String
                                                                          Datee =
                                                                          "";
                                                                      String
                                                                          DateeRemote =
                                                                          "";

                                                                      _operationService
                                                                          .getOperationsbyRequest(
                                                                              filtred[x]["_id"],
                                                                              tokenLogin)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          Operationss =
                                                                              value["data"];
                                                                        });
                                                                        if (filtred[x]["name"] ==
                                                                            "WFH") {
                                                                          for (var i = 0;
                                                                              i < Operationss.length;
                                                                              i++) {
                                                                            if (Jiffy(DateTime.now().add(Duration(days: -1))).isAfter(new DateFormat("yyyy-MM-dd").format(DateTime.parse(Operationss[i]["date"].toString().substring(0, 10)))) ==
                                                                                true) {
                                                                              OldDate = "yes";
                                                                            } else {
                                                                              Datee = "yes";
                                                                            }
                                                                          }
                                                                          if (Datee ==
                                                                              "yes") {
                                                                            SweetAlert.show(context,
                                                                                subtitle: "Do you want to delete this request",
                                                                                style: SweetAlertStyle.confirm,
                                                                                confirmButtonColor: LightColors.kRed,
                                                                                cancelButtonColor: Colors.white12,
                                                                                showCancelButton: true, onPress: (bool isConfirm) {
                                                                              if (isConfirm) {
                                                                                _requestService.CancelRequet(filtred[x]["_id"], tokenLogin).then((value) {
                                                                                  if (value["status"].toString() == "200") {
                                                                                    SweetAlert.show(context, subtitle: "Deleting...", style: SweetAlertStyle.loading);
                                                                                    new Future.delayed(new Duration(seconds: 2), () {
                                                                                      SweetAlert.show(context, subtitle: "Done !", style: SweetAlertStyle.success);
                                                                                    }).whenComplete(() => setState(() {
                                                                                          filtred.removeAt(x);
                                                                                        }));
                                                                                  } else {
                                                                                    {
                                                                                      SweetAlert.show(context, subtitle: "Ooops! Something Went Wrong!!", style: SweetAlertStyle.error);
                                                                                    }
                                                                                  }
                                                                                });
                                                                              } else {
                                                                                return true;
                                                                              }
                                                                              // return false to keep dialog
                                                                              return false;
                                                                            });
                                                                          } else if (Datee ==
                                                                              "") {
                                                                            SweetAlert.show(context,
                                                                                subtitle: "You cannot cancel this request because it contains older slots!",
                                                                                style: SweetAlertStyle.error);
                                                                          }
                                                                        } else {
                                                                          if (Jiffy(DateTime.now().add(Duration(days: -1))).isAfter(new DateFormat("yyyy-MM-dd").format(DateTime.parse(Operationss[0]["date_debut"].toString().substring(0, 10)))) ==
                                                                              true) {
                                                                            OldDate =
                                                                                "yes";
                                                                          } else {
                                                                            DateeRemote =
                                                                                "yes";
                                                                          }
                                                                          if (DateeRemote ==
                                                                              "yes") {
                                                                            SweetAlert.show(context,
                                                                                subtitle: "Do you want to delete this request",
                                                                                style: SweetAlertStyle.confirm,
                                                                                confirmButtonColor: LightColors.kRed,
                                                                                cancelButtonColor: Colors.white12,
                                                                                showCancelButton: true, onPress: (bool isConfirm) {
                                                                              if (isConfirm) {
                                                                                _requestService.CancelRequet(filtred[x]["_id"], tokenLogin).then((value) {
                                                                                  if (value["status"].toString() == "200") {
                                                                                    SweetAlert.show(context, subtitle: "Deleting...", style: SweetAlertStyle.loading);
                                                                                    new Future.delayed(new Duration(seconds: 2), () {
                                                                                      SweetAlert.show(context, subtitle: "Done !", style: SweetAlertStyle.success);
                                                                                    }).whenComplete(() => setState(() {
                                                                                          filtred.removeAt(x);
                                                                                        }));
                                                                                  } else {
                                                                                    {
                                                                                      SweetAlert.show(context, subtitle: "Ooops! Something Went Wrong!!", style: SweetAlertStyle.error);
                                                                                    }
                                                                                  }
                                                                                });
                                                                              } else {
                                                                                return true;
                                                                              }
                                                                              // return false to keep dialog
                                                                              return false;
                                                                            });
                                                                          } else if (Datee ==
                                                                              "") {
                                                                            SweetAlert.show(context,
                                                                                subtitle: "You cannot cancel this request !",
                                                                                style: SweetAlertStyle.error);
                                                                          }
                                                                        }

/*                                                                          else
                                                                          {
                                                                            SweetAlert.show(context,subtitle: "You cannot cancel this request ", style: SweetAlertStyle.error);

                                                                          }*/

                                                                        //  SweetAlert.show(context,subtitle: "You cannot cancel this request because it contains older slots!", style: SweetAlertStyle.error);
                                                                      });
                                                                    }),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: (filtred[x]["status"] == "pending")
                                                                            ? Text(
                                                                                "Pending",
                                                                                style: TextStyle(color: Colors.orange, fontSize: 13),
                                                                              )
                                                                            : (filtred[x]["status"] == "accepted")
                                                                                ? Text(
                                                                                    "Approved",
                                                                                    style: TextStyle(color: Colors.green, fontSize: 13),
                                                                                  )
                                                                                : Text(
                                                                                    "Rejected",
                                                                                    style: TextStyle(color: Colors.red, fontSize: 13),
                                                                                  ))),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3.0),
                                                                      child: (filtred[x]["name"].toString() ==
                                                                              "Mission")
                                                                          ? Column(
                                                                              children: [
                                                                                Text(
                                                                                  new DateFormat('yyyy-MM-dd').format(DateTime.tryParse(filtred[x]["mission"]["startDate"])).toString(),
                                                                                  style: TextStyle(color: Colors.black54, fontSize: 12),
                                                                                ),
                                                                                Text(
                                                                                  new DateFormat('yyyy-MM-dd').format(DateTime.tryParse(filtred[x]["mission"]["endDate"])).toString(),
                                                                                  style: TextStyle(color: Colors.black54, fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : Text(
                                                                              new DateFormat('yyyy-MM-dd  HH:mm').format(DateTime.tryParse(filtred[x]["createdAt"])).toString(),
                                                                              style: TextStyle(color: Colors.black54, fontSize: 12),
                                                                            ),
                                                                    )),
                                                              ],
                                                            ),
                                                          )
                                                        ],
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: LightColors.kDarkBlue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => navigationScreen(
                        0, null, null, 0, null, selectedDate, "homework")));
          },
        ),
      ),
    );
  }

  Widget getDateRangePicker() {
    return Container(
      height: 250,
      child: SfDateRangePicker(
        controller: _controller,
        // minDate: DateTime.now(),
        backgroundColor: NeumorphicColors.background,
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        onSelectionChanged: selectionChanged,
        monthViewSettings:
            DateRangePickerMonthViewSettings(enableSwipeSelection: false),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate;
    DateTime date2 = ranges.endDate ?? ranges.startDate;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!isSameDate(dat1, ranges.startDate) ||
        !isSameDate(dat2, ranges.endDate)) {
      _controller.selectedRange = PickerDateRange(dat1, dat2);
    }
    Dates = [];

    setState(() {
      Dates.add(dat1);

      Dates.add(dat1.add(Duration(days: 6)));
    });
    _filterResources(Dates[0], Dates[1]);
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }
}
