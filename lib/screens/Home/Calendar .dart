import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:vato/constants/constants.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/User.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/ReservationService.dart';
import 'package:vato/widgets/navBar.dart';

class ListReservation extends StatefulWidget {
  final BuildContext context1;
  DateTime selectedDate;
  ListReservation(
    this.context1,
    this.selectedDate, {
    Key key,
  }) : super(key: key);

  @override
  _ListReservationState createState() => _ListReservationState();
}

class _ListReservationState extends State<ListReservation> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Future<SharedPreferences> _prefs;
  var x;
  User loggedInUser;
  int NBRreservation;
  String tokenLogin;
  String company;
  var Date;
  var DateStart;
  var DateEnd;

  var Operation_id;
  String idUser;
  bool isAllday = false;

  final _storage = const FlutterSecureStorage();

  List<dynamic> reservations;
  ReservationService rs = new ReservationService();
  OperationService _operationService = new OperationService();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  CalendarController _controller = CalendarController();
  String _text = '';
  bool clicked;
  var status;
  var detail;
  var notes;
  List Operations = [];
  var manager;
  var location;

  var startTime;
  var endTime;

  Future<void> Logout() async {
    if (await _storage.containsKey(key: 'refreshToken') == false) {
      print("refreshTokefffffffffffffffffffffffffffffn");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      final _storage = const FlutterSecureStorage();
      await _storage.deleteAll();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(widget.selectedDate)));
    } else {
      print("xxx" + await _storage.read(key: 'refreshToken'));
    }
  }

  @override
  void initState() {
    super.initState();
    Logout();
    this.clicked = false;
    widget.selectedDate = DateTime.now();
    //this.detail="";
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        // prefs.get("token").toString()
        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
        this.company = prefs.get("company").toString();
        Map<String, dynamic> payload = Jwt.parseJwt(
          this.tokenLogin.toString(),
        );
        _operationService
            .getOperationsbyUser(idUser, tokenLogin)
            .then((value) async {
          //   final refreshToken = await _storage.read(key: 'refreshToken');
/*          if (refreshToken==null) {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.clear();
              final _storage = const FlutterSecureStorage();
             await _storage.deleteAll();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInScreen()));
          }*/
          //    selectedDate = await NTP.now();
          //    Operations = value["data"];

          if (value["data"] != null) {
            print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

            setState(() {
              print("bbbbbbbbbbbbbbbbb");

              Operations = value["data"];
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context1) {
    var childButtons = List<UnicornButton>();
/*
   childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "Leave",
        currentButton: FloatingActionButton(
          heroTag: "Leave",
          backgroundColor: NeumorphicColors.background,
          mini: true,
          child: Icon(Icons.work_off, color: LightColors.Leave),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => navigationScreen(
                        0, null, null, 0, null, widget.selectedDate, "leave")));
          },
        )));

    childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "Customer site",
        currentButton: FloatingActionButton(
          heroTag: "Csite",
          backgroundColor: NeumorphicColors.background,
          mini: true,
          child: Icon(
            Icons.hail,
            color: LightColors.CustomSite,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => navigationScreen(
                        0, null, null, 0, null, widget.selectedDate, "site")));
          },
        )));


    // if(this.company=="workpoint") {
   childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "Mission ",
        currentButton: FloatingActionButton(
            heroTag: "Mission",
            backgroundColor: NeumorphicColors.background,
            mini: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => navigationScreen(
                          0, null, null, 0, null, widget.selectedDate, "Dmission")));
            },
            child: Icon(
              Icons.airplanemode_active,
              color: LightColors.Mission,
            ))));*/

    childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "WFH ",
        currentButton: FloatingActionButton(
            heroTag: "télétravail",
            backgroundColor: NeumorphicColors.background,
            mini: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => navigationScreen(0, null, null, 0,
                          null, widget.selectedDate, "homework")));
            },
            child: Icon(
              Icons.home_work,
              color: LightColors.Telework,
            ))));
    childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "EY Tower",
        currentButton: FloatingActionButton(
          heroTag: "Site",
          backgroundColor: NeumorphicColors.background,
          mini: true,
          child: Icon(Icons.apartment_outlined, color: LightColors.OnSite),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => navigationScreen(
                        0, null, null, 0, null, widget.selectedDate, "site")));
          },
        )));

    childButtons.add(UnicornButton(
        labelBackgroundColor: NeumorphicColors.background,
        hasLabel: true,
        labelText: "Mission ",
        currentButton: FloatingActionButton(
            heroTag: "Mission",
            backgroundColor: NeumorphicColors.background,
            mini: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => navigationScreen(0, null, null, 0,
                          null, widget.selectedDate, "addmission")));
            },
            child: Icon(
              Icons.airplanemode_active,
              color: LightColors.Mission,
            ))));
    // }
    int _selectedIndex = 0;
    double _height = MediaQuery.of(context1).size.height;
    double width = MediaQuery.of(context1).size.width;
    String day = new DateFormat("dd MMMM yyyy aaa")
        .format(new DateTime.now())
        .toString();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          SIGN_IN: (BuildContext context2) => SignInScreen(widget.selectedDate),
        },
        home: Scaffold(
          backgroundColor: NeumorphicColors.background,
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: SfCalendar(
                    view: CalendarView.workWeek,
                    showWeekNumber: true,
                    allowViewNavigation: true,
                    showDatePickerButton: true,
                    onSelectionChanged: selectionChanged,
                    appointmentTextStyle: TextStyle(),
                    // onSelectionChanged: selectionChanged,
                    // monthViewSettings: MonthViewSettings(showAgenda: true),
                    timeSlotViewSettings: TimeSlotViewSettings(
                        startHour: 6,
                        endHour: 19,
                        timeInterval: Duration(hours: 2)),
                    controller: _controller,
                    backgroundColor: NeumorphicColors.background,
                    onTap: (CalendarTapDetails detail) {
                      if (detail.appointments != null &&
                          detail.appointments.length != 0) {
                      } else {
                        setState(() {
                          clicked = true;
                          this.detail = null;
                        });
                      }
                    },
                    headerStyle: CalendarHeaderStyle(
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 2,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                    dataSource: _getCalendarDataSource(),
                    allowedViews: <CalendarView>[
                      CalendarView.day,
                      CalendarView.workWeek,
                      CalendarView.month,
                    ],
                    appointmentBuilder: (BuildContext context,
                        CalendarAppointmentDetails details) {
                      final Appointment meeting = details.appointments.first;
                      // final String image = _getImage();
                      if (_controller.view != CalendarView.month &&
                          _controller.view != CalendarView.schedule) {
                        return GestureDetector(
                          child: (meeting.isAllDay != false)
                              ? Container(
                                  height: 120,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.topLeft,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              color: meeting.color,
                                            ),
                                            child: (meeting.color ==
                                                    LightColors.Telework)
                                                ? Center(
                                                    child: Icon(
                                                      Icons.home_work_outlined,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  )
                                                : (meeting.color ==
                                                        LightColors.LLviolet)
                                                    ? Center(
                                                        child: Icon(
                                                        Icons
                                                            .airplanemode_active,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ))
                                                    : Center(
                                                        child: Icon(
                                                          Icons
                                                              .apartment_outlined,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      )),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  color: LightColors.Telework,
                                  child: Center(
                                    child: Icon(
                                      Icons.home_work_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                          onTap: () {
                            if (meeting != null) {
                              print("**********" + meeting.toString());
                              setState(() {
                                clicked = true;
                                this.detail = meeting.color;
                                this.location = meeting.location;
                                this.manager = meeting.subject;
                                this.startTime = meeting.startTime;
                                this.endTime = meeting.endTime;

                                // detail.appointments.map( (entry) => this.detail.add(entry.subject)).toList();
                                Date = meeting.startTime.toString();
                                DateStart = meeting.startTime.toString();
                                DateEnd = meeting.endTime.toString();

                                Operation_id = meeting.notes;
                                status = meeting.location;
                              });
                            } else {
                              setState(() {
                                clicked = false;
                                this.detail = null;
                              });
                            }
                          },
                        );
                      }
                      return Container(
                        child: Text(meeting.subject),
                      );
                    }),
              ),
              Expanded(
                  flex: 3,
                  child: clicked == true && detail != null
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: _height / 500),
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 25),
                                height: 85,
                                width: width,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: NeumorphicColors.background,
                                    ),
                                    child: Container(
                                      //  margin: EdgeInsets.all(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          (detail == LightColors.Telework ||
                                                  detail == LightColors.remote)
                                              ? Container(
                                                  width: width * 0.2,
                                                  height: _height / 7.6,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.home_work_outlined,
                                                      color:
                                                          LightColors.Telework,
                                                      size: 30,
                                                    ),
                                                  ))
                                              : (detail == LightColors.LLviolet)
                                                  ? Container(
                                                      width: width * 0.2,
                                                      height: _height / 7.6,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .airplanemode_active,
                                                          color: LightColors
                                                              .LLviolet,
                                                          size: 30,
                                                        ),
                                                      ))
                                                  : Container(
                                                      width: width * 0.2,
                                                      height: _height / 7.6,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .apartment_outlined,
                                                          color: LightColors
                                                              .OnSite,
                                                          size: 30,
                                                        ),
                                                      )),
                                          Container(
                                              width: width * 0.4,
                                              height: 80,
                                              child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      30, 5, 5, 5),
                                                  child: (detail ==
                                                          LightColors.Telework)
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 15.0,
                                                            ),
                                                            AutoSizeText(
                                                              "WFH",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                              maxLines: 1,
                                                              minFontSize: 13,
                                                            ),
                                                            AutoSizeText(
                                                              manager
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 13),
                                                              maxLines: 1,
                                                              minFontSize: 13,
                                                            ),
                                                            AutoSizeText(
                                                              Date.toString()
                                                                  .substring(
                                                                      0, 16),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13,
                                                              ),
                                                              maxLines: 1,
                                                              minFontSize: 9,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                          ],
                                                        )
                                                      : (detail ==
                                                              LightColors
                                                                  .remote)
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                AutoSizeText(
                                                                  "Remote Working",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          17),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      13,
                                                                ),
                                                                AutoSizeText(
                                                                  manager
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      13,
                                                                ),
                                                                AutoSizeText(
                                                                  Date.toString()
                                                                      .substring(
                                                                          0,
                                                                          16),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      9,
                                                                ),
                                                                SizedBox(
                                                                  height: 3,
                                                                ),
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 15.0,
                                                                ),
                                                                AutoSizeText(
                                                                  "TRAVEL : " +
                                                                      manager,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          17),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      13,
                                                                ),
                                                                AutoSizeText(
                                                                  location
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          13),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      13,
                                                                ),
                                                                AutoSizeText(
                                                                  DateStart.toString()
                                                                          .substring(
                                                                              0,
                                                                              10) +
                                                                      " / " +
                                                                      DateEnd.toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      9,
                                                                ),
                                                                SizedBox(
                                                                  height: 3,
                                                                ),
                                                              ],
                                                            ))),
                                          Spacer(),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              child: Container(
                                                width: width * 0.2,
                                                height: 180,
                                                child: Center(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child:
                                                              GestureDetector(
                                                                  child:
                                                                      NeumorphicIcon(
                                                                    Icons
                                                                        .cancel,
                                                                    size: 25,
                                                                    style: NeumorphicStyle(
                                                                        depth:
                                                                            20,
                                                                        color: LightColors
                                                                            .kRed),
                                                                  ),
                                                                  onTap: () {
                                                                    if (Jiffy(DateTime.now().add(Duration(days: -1))).isBefore(new DateFormat("yyyy-MM-dd").format(DateTime.parse(Date.toString().substring(
                                                                            0,
                                                                            10)))) ==
                                                                        true) {
                                                                      SweetAlert.show(
                                                                          context,
                                                                          subtitle:
                                                                              "Do you want to delete this Operation ?",
                                                                          style: SweetAlertStyle
                                                                              .confirm,
                                                                          confirmButtonColor: LightColors
                                                                              .kRed,
                                                                          cancelButtonColor: Colors
                                                                              .white12,
                                                                          showCancelButton:
                                                                              true,
                                                                          onPress:
                                                                              (bool isConfirm) {
                                                                        if (isConfirm) {
                                                                          _operationService.CancelOperation(Operation_id, this.tokenLogin)
                                                                              .then((value) {
                                                                            SweetAlert.show(context,
                                                                                subtitle: "Deleting...",
                                                                                style: SweetAlertStyle.loading);
                                                                            new Future.delayed(new Duration(seconds: 2),
                                                                                () {
                                                                              setState(() {
                                                                                clicked = true;
                                                                                this.detail = null;
                                                                              });
                                                                              _operationService.getOperationsbyUser(idUser, tokenLogin).then((value) async {
                                                                                Operations = value["data"];
                                                                                if (value["data"] != null) {
                                                                                  setState(() {
                                                                                    Operations = value["data"];
                                                                                  });
                                                                                }
                                                                              });
                                                                              if (value["status"].toString() == "200") {
                                                                                SweetAlert.show(context, subtitle: "Done !", style: SweetAlertStyle.success);
                                                                              } else {
                                                                                {
                                                                                  SweetAlert.show(context, subtitle: "Ooops! Something Went Wrong!!", style: SweetAlertStyle.error);
                                                                                }
                                                                              }
                                                                            });
                                                                          });
                                                                        } else {
                                                                          return true;
                                                                        }
                                                                        // return false to keep dialog
                                                                        return false;
                                                                      });
                                                                    } else {
                                                                      SweetAlert.show(
                                                                          context,
                                                                          subtitle:
                                                                              "cannot remove this Operation!",
                                                                          style:
                                                                              SweetAlertStyle.error);
                                                                    }
                                                                  }),
                                                        ),
                                                        Spacer(),
                                                        status == "accepted"
                                                            ? Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          2,
                                                                          5,
                                                                          8),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      'Approved',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .green,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : status ==
                                                                    "pending"
                                                                ? Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.fromLTRB(0, 2, 5, 8),
                                                                        child: Container(
                                                                            child: Text(
                                                                          'Pending',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.orange,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ))),
                                                                  )
                                                                : status ==
                                                                        "refused"
                                                                    ? Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.fromLTRB(2, 2, 2, 8),
                                                                            child: Container(
                                                                                child: Text(
                                                                              'Rejected',
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ))),
                                                                      )
                                                                    : Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              2,
                                                                              2,
                                                                              8),
                                                                          child:
                                                                              Container(),
                                                                        ),
                                                                      ),
                                                      ]),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              onTap: () {
                                if (detail == "Mission") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              navigationScreen(
                                                  0,
                                                  null,
                                                  null,
                                                  0,
                                                  null,
                                                  widget.selectedDate,
                                                  "Dmission")));
                                }
                              },
                            ),
                          )
                          //CardActivity(_height,width,Date,Operation_id,detail,status,context,tokenLogin),
                          )
                      : Container()),
            ],
          ),
          floatingActionButton: UnicornDialer(
              backgroundColor: Color.fromRGBO(221, 230, 232, 0.6),
              parentButtonBackground: LightColors.kDarkBlue,
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(Icons.add),
              childButtons: childButtons),
        ));
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    var StartTime;
    var EndTime;

    Operations.forEach((element) async {
      print("hello");
      if (element["OperationType"].toString() == "WFH") {
        var Date = element["date"].toString().substring(0, 10);
        var month = DateTime.parse(Date).month;
        var day = DateTime.parse(Date).day;
        var year = DateTime.parse(Date).year;
        if (element["timeslot"] == "AM") {
          StartTime = 8;
          EndTime = 12;
        }
        if (element["timeslot"] == "PM") {
          StartTime = 14;
          EndTime = 18;
        }
        appointments.add(Appointment(
          startTime: new DateTime(year, month, day, StartTime),
          endTime: new DateTime(year, month, day, EndTime, 30),
          subject: element["request"]["idReciever"]["firstname"] +
              " " +
              element["request"]["idReciever"]["lastname"],
          color: LightColors.Telework,
          startTimeZone: '',
          endTimeZone: '',
          location: element["request"]["status"],
          //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
          notes: element["_id"],
          //  location:   "0"
        ));
      } else if (element["OperationType"].toString() == "RESERVATION") {
        var Date = element["reservationdate"].toString().substring(0, 10);
        var month = DateTime.parse(Date).month;
        var day = DateTime.parse(Date).day;
        var year = DateTime.parse(Date).year;
        if (element["timeslot"] == "AM") {
          StartTime = 8;
          EndTime = 12;
        }
        if (element["timeslot"] == "PM") {
          StartTime = 14;
          EndTime = 18;
        }

        appointments.add(Appointment(
          startTime: new DateTime(year, month, day, StartTime),
          endTime: new DateTime(year, month, day, EndTime, 30),
          subject: element["desk"]["name"],
          color: LightColors.OnSite,
          startTimeZone: '',
          endTimeZone: '',
          // location: element["request"]["status"],
          //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
          notes: element["_id"],
          //  location:   "0"
        ));
      } else if (element["OperationType"].toString() == "REMOTE_WORKING") {
        var Start = element["date_debut"].toString().substring(0, 10);
        var Startmonth = DateTime.parse(Start).month;
        var Startday = DateTime.parse(Start).day;
        var Startyear = DateTime.parse(Start).year;

        var Fin = element["date_fin"].toString().substring(0, 10);
        var Finmonth = DateTime.parse(Fin).month;
        var Finday = DateTime.parse(Fin).day;
        var Finyear = DateTime.parse(Fin).year;
        appointments.add(Appointment(
            startTime: new DateTime(
              Startyear,
              Startmonth,
              Startday,
            ),
            endTime: new DateTime(
              Finyear,
              Finmonth,
              Finday,
            ),
            subject: element["request"]["idReciever"]["firstname"] +
                " " +
                element["request"]["idReciever"]["lastname"],
            color: LightColors.remote,
            startTimeZone: '',
            endTimeZone: '',
            location: element["request"]["status"],
            //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
            notes: element["_id"],
            isAllDay: true
            //  location:   "0"

            ));
      } else if (element["OperationType"].toString() == "TRAVEL") {
        var Start = element["date_debut"].toString().substring(0, 10);
        var Startmonth = DateTime.parse(Start).month;
        var Startday = DateTime.parse(Start).day;
        var Startyear = DateTime.parse(Start).year;

        var Fin = element["date_fin"].toString().substring(0, 10);
        var Finmonth = DateTime.parse(Fin).month;
        var Finday = DateTime.parse(Fin).day;
        var Finyear = DateTime.parse(Fin).year;
        appointments.add(Appointment(
            startTime: new DateTime(
              Startyear,
              Startmonth,
              Startday,
            ),
            endTime: new DateTime(
              Finyear,
              Finmonth,
              Finday,
            ),
            subject: (element["request"]["mission"]["title"] != null)
                ? element["request"]["mission"]["title"]
                : "",
            color: LightColors.LLviolet,
            startTimeZone: '',
            endTimeZone: '',
            location:
                element["request"]["mission"]["destinationCountryAller"] == null
                    ? ""
                    : (element["request"]["mission"]["destinationCountryAller"]
                                    ["name"] !=
                                null &&
                            element["request"]["mission"]
                                    ["destinationCountryAller"]["name"] !=
                                null)
                        ? element["request"]["mission"]["departureCountryAller"]
                                ["name"] +
                            " To " +
                            element["request"]["mission"]
                                ["destinationCountryAller"]["name"]
                        : "",
            //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
            notes: element["_id"],
            isAllDay: true
            //  location:   "0"

            ));
      }
    });

    return _AppointmentDataSource(appointments);
  }

  void selectionChanged(CalendarSelectionDetails details) {
    if (detail.appointments != null && detail.appointments.length != 0) {
      setState(() {
        clicked = true;
        this.detail = detail.appointments.first.subject;
        // detail.appointments.map( (entry) => this.detail.add(entry.subject)).toList();
        Date = detail.appointments.first.startTime.toString();
        Operation_id = detail.appointments.first.notes;
        status = detail.appointments.first.location;
      });
    } else {
      setState(() {
        clicked = true;
        this.detail = null;
      });
    }
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
