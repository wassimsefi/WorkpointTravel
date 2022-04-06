import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/services/DeskServices.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/ScanServices.dart';
import 'package:vato/widgets/navBar.dart';

class TopContainer extends StatefulWidget {
  TopContainer();

  @override
  _TopContainerState createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  OperationService _operationServices = new OperationService();

  ScanService _scanServices = new ScanService();

  DeskServices _deskServices = new DeskServices();

  bool StatutAM = true;

  bool StatutPM = true;

  DateTime selectedDate;

  String user;

  String tokenLogin;

  dynamic data;

  dynamic Desk;

  DateTime datetimeenow = DateTime.now();
  Future<SharedPreferences> _prefs;

  String DateNow;
  checkSlot(slot) async {
    if (DateFormat('a').format(DateTime.now()) == "AM") {
      StatutAM = true;
      StatutPM = true;
    } else if ((DateFormat('a').format(DateTime.now()) == "PM") &&
        slot == "AM") {
      StatutAM = false;
      StatutPM = true;
    } else {
      StatutAM = true;
      StatutPM = true;
    }
  }

  @override
  void initState() {
    var newFormat = DateFormat("yyyy-MM-dd");
    DateNow = newFormat.format(datetimeenow);
    _prefs = SharedPreferences.getInstance();

    _prefs.then((SharedPreferences prefs) {
      setState(() {
        user = prefs.get("_id");
        tokenLogin = prefs.get("token");
      });
    });
    checkSlot("AM");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          decoration: BoxDecoration(
              color: LightColors.kDarkBlue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(59.0),
              )),
          height: height / 5.5,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: width / 2.5,
                    height: height / 20,
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  Neumorphic(
                      style: NeumorphicStyle(
                        depth: 1,
                        shape: NeumorphicShape.concave,
                        color: LightColors.kDarkBlue,
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: Container(
                        child: IconButton(
                          onPressed: () async {
                            String scancode =
                                (await BarcodeScanner.scan()) as String;
                            SweetAlert.show(context,
                                subtitle: "Loading ...",
                                style: SweetAlertStyle.loading);
                            Future<dynamic> AcessScan = _scanServices
                                .getAccesScan(user, scancode, tokenLogin);
                            dynamic resultScanAcess = await AcessScan;
                            if (resultScanAcess["data"].toString() == "false") {
                              SweetAlert.show(context,
                                  title: " Access Denied !",
                                  subtitle:
                                      "You don't have access to this zone !",
                                  style: SweetAlertStyle.error);
                            } else {
                              Future<dynamic> rst = _operationServices.ScanDesk(
                                  user, scancode, tokenLogin);
                              dynamic value2 = await rst;
                              if (value2["data"] == "not available") {
                                SweetAlert.show(context,
                                    title: " reservation NOT found !",
                                    subtitle:
                                        "Do you want to book now this desk !",
                                    showCancelButton: true,
                                    style: SweetAlertStyle.confirm,
                                    cancelButtonText: "NO",
                                    confirmButtonText: "YES",
                                    confirmButtonColor: LightColors.kDarkBlue,
                                    cancelButtonColor: Colors.white12,
                                    onPress: (bool isConfirm) {
                                  if (isConfirm) {
                                    _deskServices
                                        .getDeskAvailability(
                                            scancode, DateNow, tokenLogin)
                                        .then((value) {
                                      Desk = value["data"];
                                      _openPopup2(context, Desk, user);
                                    });

                                    // return false to keep dialog
                                    return false;
                                  }
                                });
                              } else if (value2["data"] == "checkOut") {
                                SweetAlert.show(context,
                                    title: "See you next time!",
                                    style: SweetAlertStyle.success);
                              } else if (value2["data"] == "checkIn") {
                                SweetAlert.show(
                                  context,
                                  title: "Welcome to your desk!",
                                  style: SweetAlertStyle.success,
                                );
                              } else if (value2["data"] == "Wrong desk") {
                                SweetAlert.show(
                                  context,
                                  title: "Wrong desk!",
                                  style: SweetAlertStyle.error,
                                );
                              } else {
                                SweetAlert.show(context,
                                    title: "Not A valid QR-Code",
                                    style: SweetAlertStyle.error);
                              }
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.qr_code_scanner_outlined,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * 0.043,
              ),
            ],
          )),
    );
  }

  _openPopup2(context, Desk, userid) {
    double width = MediaQuery.of(context).size.width;
    List<Reservations> reservations = [];

    double height = MediaQuery.of(context).size.height;
    bool PMVAL = false;
    bool AMVAL = false;
    void STATEPM(setState) {
      setState(() {
        PMVAL = !PMVAL;
      });
    }

    void STATEAM(setState) {
      setState(() {
        AMVAL = !AMVAL;
      });
    }

    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      //isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      descStyle: TextStyle(
        color: LightColors.kbluen,
      ),
      alertAlignment: Alignment.center,
    );
/*    String Function() title() {
      return () {
        if(((Desk[0]["statusAM"]=="BOOKED")|| StatutAM == false || Desk[0]["statusAM"]=="OCCUPIED") && ( (Desk[0]["statusPM"]=="BOOKED") || StatutPM == false || Desk[0]["statusPM"]=="OCCUPIED"))
        { return 'Booking is not allowed  !';}
        else{
          return "Choose your time slot";
        }
      };
    }*/
    Alert(
        context: context,
        title: Desk[0]["deskname"],
        type: AlertType.info,
        style: alertStyle,
        desc: "Choose your time slot",
        content: StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Column(children: <Widget>[
              SizedBox(
                height: height / 20,
              ),
              /*                 (((Desk[0]["statusAM"]=="BOOKED")|| StatutAM == false) && ( (Desk[0]["statusPM"]=="BOOKED") || StatutPM == false))?
                  Center(child: Text("There is no free time slot !" ,style: TextStyle(color: Colors.white,fontSize: 15),))
                  :*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // [Monday] checkbox
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "AM",
                        style: TextStyle(color: Colors.white),
                      ),
                      (Desk[0]["statusAM"] == "BOOKED") ||
                              StatutAM == false ||
                              Desk[0]["statusAM"] == "OCCUPIED"
                          ? IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              color: LightColors.kRed,
                              onPressed: () {},
                            )
                          : (AMVAL == false)
                              ? IconButton(
                                  icon: Icon(Icons.radio_button_unchecked),
                                  color: Colors.white,
                                  onPressed: () {
                                    STATEAM(setState);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.check_circle_outline),
                                  color: Colors.green,
                                  onPressed: () {
                                    STATEAM(setState);
                                  },
                                ),
                      (Desk[0]["statusAM"] == "BOOKED") ||
                              Desk[0]["statusAM"] == "OCCUPIED"
                          ? Text(
                              Desk[0]["userAM"]["firstname"].toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                              maxLines: 1,
                            )
                          : Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                      (Desk[0]["statusAM"] == "BOOKED") ||
                              Desk[0]["statusAM"] == "OCCUPIED"
                          ? Text(
                              Desk[0]["userAM"]["lastname"].toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                              maxLines: 1,
                            )
                          : Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            )
                    ],
                  ),
                  // [Tuesday] checkbox
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "PM",
                        style: TextStyle(color: Colors.white),
                      ),
                      (Desk[0]["statusPM"] == "BOOKED") ||
                              Desk[0]["statusPM"] == "OCCUPIED"
                          ? IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              color: LightColors.kRed,
                              onPressed: () {},
                            )
                          : (PMVAL == false)
                              ? IconButton(
                                  icon: Icon(Icons.radio_button_unchecked),
                                  color: Colors.white,
                                  onPressed: () {
                                    STATEPM(setState);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.check_circle_outline),
                                  //focusColor: Colors.green,
                                  color: Colors.green,
                                  onPressed: () {
                                    STATEPM(setState);
                                  },
                                ),
                      (Desk[0]["statusPM"] == "BOOKED") ||
                              Desk[0]["statusPM"] == "OCCUPIED"
                          ? Text(
                              Desk[0]["userPM"]["firstname"].toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                              maxLines: 1,
                            )
                          : Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                      (Desk[0]["statusPM"] == "BOOKED") ||
                              Desk[0]["statusPM"] == "OCCUPIED"
                          ? Text(
                              Desk[0]["userPM"]["lastname"].toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                              maxLines: 1,
                            )
                          : Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            )
                    ],
                  ),

                  // [Wednesday] checkbox
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              (((Desk[0]["statusAM"] == "BOOKED") ||
                          StatutAM == false ||
                          Desk[0]["statusAM"] == "OCCUPIED") &&
                      ((Desk[0]["statusPM"] == "BOOKED") ||
                          StatutPM == false ||
                          Desk[0]["statusPM"] == "OCCUPIED"))
                  ? Center(
                      child: Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )) // [Wednesday] checkbox
                  : DialogButton(
                      width: width / 3,
                      color: LightColors.kDarkBlue,
                      onPressed: () {
                        Navigator.pop(context);
                        selectedDate.toString();
                        Reservations reservation = new Reservations();
                        reservation.desk = Desk[0]["id"].toString();
                        reservation.user = userid.toString();
                        reservation.reservationdate = DateTime.now().toString();

                        if (PMVAL == true && AMVAL == true) {
                          Reservations reservationAM = new Reservations();
                          reservationAM.desk = Desk[0]["id"].toString();
                          reservationAM.user = userid.toString();
                          reservationAM.reservationdate =
                              DateTime.now().toString();
                          reservationAM.timeslot = "AM";

                          reservations.add(reservationAM);

                          Reservations reservationPM = new Reservations();
                          reservationPM.desk = Desk[0]["id"].toString();
                          reservationPM.user = userid.toString();
                          reservationPM.reservationdate =
                              DateTime.now().toString();
                          reservationPM.timeslot = "PM";
                          reservations.add(reservationPM);
                          Future<dynamic> addresesvationPM = OperationService()
                              .AddNewReservations(reservations, tokenLogin);
                          addresesvationPM.then((value) async {
                            if (value["data"].toString() == "200") {
                              SweetAlert.show(context,
                                  subtitle: "Booking ...",
                                  style: SweetAlertStyle.loading);
                              new Future.delayed(new Duration(seconds: 2), () {
                                SweetAlert.show(context,
                                    subtitle: " Done !",
                                    style: SweetAlertStyle.success,
                                    onPress: (bool isConfirm) {
                                  if (isConfirm) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                navigationScreen(
                                                    0,
                                                    null,
                                                    null,
                                                    0,
                                                    null,
                                                    selectedDate,
                                                    "home")));

                                    // return false to keep dialog
                                  }
                                });
                              });
                            } else if (value["data"]["status"].toString() ==
                                "300") {
                              SweetAlert.show(context,
                                  subtitle:
                                      "Ooops! Someone else just booked this desk!",
                                  style: SweetAlertStyle.error);
                            } else if (value["data"]["status"].toString() ==
                                "201") {
                              SweetAlert.show(context,
                                  subtitle: value["data"]["message"],
                                  style: SweetAlertStyle.error);
                            } else if (value["status"].toString() == "400") {
                              SweetAlert.show(context,
                                  subtitle: "Ooops! Something Went Wrong!",
                                  style: SweetAlertStyle.error);
                            }
                          });
                        }

                        if (PMVAL == true && AMVAL == false) {
                          reservation.timeslot = "PM";
                          Future<dynamic> addresesvationPM = OperationService()
                              .AddNewReservation(reservation, this.tokenLogin);
                          addresesvationPM.then((value) async {
                            if (value["data"].toString() == "200") {
                              SweetAlert.show(context,
                                  subtitle: "Booking ...",
                                  style: SweetAlertStyle.loading);
                              new Future.delayed(new Duration(seconds: 2), () {
                                SweetAlert.show(context,
                                    subtitle: "Done!",
                                    style: SweetAlertStyle.success);
                              });
                            } else if (value["data"]["status"].toString() ==
                                "300") {
                              SweetAlert.show(context,
                                  subtitle:
                                      "Ooops! Someone else just booked this desk!",
                                  style: SweetAlertStyle.error);
                            } else if (value["data"]["status"].toString() ==
                                "201") {
                              SweetAlert.show(context,
                                  subtitle: value["data"]["message"],
                                  style: SweetAlertStyle.error);
                            } else if (value["status"].toString() == "400") {
                              SweetAlert.show(context,
                                  subtitle: "Ooops! Something Went Wrong!",
                                  style: SweetAlertStyle.error);
                            }
                          });
                        }
                        if (PMVAL == false && AMVAL == true) {
                          reservation.timeslot = "AM";
                          Future<dynamic> addresesvationPM = OperationService()
                              .AddNewReservation(reservation, this.tokenLogin);
                          addresesvationPM.then((value) async {
                            if (value["data"].toString() == "200") {
                              SweetAlert.show(context,
                                  subtitle: "Booking ...",
                                  style: SweetAlertStyle.loading);
                              new Future.delayed(new Duration(seconds: 2), () {
                                SweetAlert.show(context,
                                    subtitle: "Done!",
                                    style: SweetAlertStyle.success);
                              });
                            } else if (value["data"]["status"].toString() ==
                                "300") {
                              SweetAlert.show(context,
                                  subtitle:
                                      "Ooops! Someone else just booked this desk!",
                                  style: SweetAlertStyle.error);
                            } else if (value["data"]["status"].toString() ==
                                "201") {
                              SweetAlert.show(context,
                                  subtitle: value["data"]["message"],
                                  style: SweetAlertStyle.error);
                            } else if (value["status"].toString() == "400") {
                              SweetAlert.show(context,
                                  subtitle: "Ooops! Something Went Wrong!",
                                  style: SweetAlertStyle.error);
                            }
                          });
                        }
                        if (PMVAL == false && AMVAL == false) {
                          SweetAlert.show(context,
                              subtitle: "please check your time slote !",
                              style: SweetAlertStyle.error);
                        }

                        // Navigator.pop(context);
                      },
                      child: Text(
                        "BOOK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
            ]);
          },
        ),
        buttons: []).show();
  }
}
