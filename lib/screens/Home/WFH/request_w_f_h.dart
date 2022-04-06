import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/Request.dart';
import 'package:vato/services/Balences.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:vato/widgets/topContainerScan.dart';

class RequestWFH extends StatefulWidget {
  const RequestWFH({Key key}) : super(key: key);

  @override
  _RequestWFHState createState() => _RequestWFHState();
}

class _RequestWFHState extends State<RequestWFH> {
  TextEditingController commentController = new TextEditingController();
  DateTime selectedDate;
  String tokenLogin;
  List Days = [];
  List weekbalance = [];
  List monthbalance = [];
  List<String> slot = [];
  bool AMselectedM;
  bool PMselectedM;
  bool AMselectedT;
  bool PMselectedT;
  bool AMselectedW;
  bool PMselectedW;
  bool AMselectedTH;
  bool PMselectedTH;
  bool AMselectedF;
  bool PMselectedF;

  String SelectDates;
  List<DateTime> Dates = [];
  DateTime Now;
  dynamic selectedValue;
  List<int> selectedItems = [];
  List<dynamic> managers;
  List<dynamic> Users;

  int WFHweekBalance, WFHmonthBalance;
  final List<DropdownMenuItem> manager = [];
  DateTime date1, date2 = DateTime.now();
  List<String> Selectednotifier = [];
  List<dynamic> selectedDates;
  final List<DropdownMenuItem> notifier = [];
  List<int> selectedItemsMultiDialog = [];
  final DateRangePickerController _controller = DateRangePickerController();
  final DateRangePickerController _controllerRange =
      DateRangePickerController();

  var alertStyle = AlertStyle(
    animationType: AnimationType.shrink,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    backgroundColor: Colors.black12,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: LightColors.kbluen,
    ),
    alertAlignment: Alignment.center,
  );

  UserService _userService = new UserService();
  RequestService _requestservice = new RequestService();
  BalenceServices _balanceservice = new BalenceServices();
  var User;
  String User_id;
  Future<SharedPreferences> _prefs;
  Future<dynamic> getManagers;
  Future<dynamic> getUsers;

  int _selectedIndex = 0;

  @override
  void initState() {
    selectedDates = [];
    slot.add("AM");
    slot.add("PM");
    SelectDates = " Select a week ";
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      setState(() {
        this.tokenLogin = prefs.get("token").toString();
        User_id = prefs.get("_id");
      });
      await _userService.getUserProfil(User_id, tokenLogin).then((userData) {
        setState(() {
          User = userData["data"];
        });
      });
      getManagers = _userService.getMangers(tokenLogin).then((value) {
        setState(() {
          managers = value["data"];
        });

        managers.asMap().forEach((index, element) {
          if (User["_id"].toString() != element["_id"].toString()) {
            setState(() {
              manager.add(
                DropdownMenuItem(
                    child:
                        Text(element["firstname"] + " " + element["lastname"]),
                    value: element),
              );
            });
          }
          manager.forEach((element) {
            if (element.value["_id"] == User["manager"]["_id"]) {
              selectedValue = element.value;
            }
          });
          //  selectedValue = User["manager"];
        });
      });

      getUsers = _userService.getUsers(tokenLogin).then((value) {
        setState(() {
          Users = value["data"];
        });

        Users.asMap().forEach((index, element) {
          if (User["_id"].toString() != element["_id"].toString()) {
            setState(() {
              notifier.add(
                DropdownMenuItem(
                    child:
                        Text(element["firstname"] + " " + element["lastname"]),
                    value: element),
              );
            });
          }
          manager.forEach((element) {
            if (element.value["_id"] == User["manager"]["_id"]) {
              selectedValue = element.value;
            }
          });
          //  selectedValue = User["manager"];
        });
      });

      _balanceservice.getSettingsBalences(this.tokenLogin).then((value) {
        setState(() {
          WFHweekBalance = value["data"][0]["WFHweekBalance"];
          WFHmonthBalance = value["data"][0]["WFHmonthBalance"];
        });
      });
    });

    Days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

    Now = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              child: FutureBuilder(
                  future: getManagers,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                  child: Text("WFH request",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 25,
                                      ))),
                              SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: NeumorphicToggle(
                                  height: 50,
                                  selectedIndex: _selectedIndex,
                                  displayForegroundOnlyIfSelected: true,
                                  alphaAnimationCurve: Curves.easeInCirc,
                                  children: [
                                    ToggleElement(
                                      background: Center(
                                          child: Text(
                                        "WFH",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400),
                                      )),
                                      foreground: Center(
                                          child: Text(
                                        "WFH",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                    ToggleElement(
                                      background: Center(
                                          child: Text(
                                        "Remote working",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400),
                                      )),
                                      foreground: Center(
                                          child: Text(
                                        "Remote working",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    )
                                  ],
                                  thumb: Neumorphic(
                                    style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedIndex = value;
                                    });
                                    if (_selectedIndex == 1) {
                                      Dates = [];
                                      setState(() {
                                        SelectDates = "Select a period";
                                      });
                                    }
                                    if (_selectedIndex == 0) {
                                      setState(() {
                                        SelectDates = "Select a week";
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SearchChoices.single(
                                  items: manager,
                                  value: selectedValue,
                                  hint: " Validator",
                                  searchHint: "Select your Manager",
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SearchChoices.multiple(
                                  items: notifier,
                                  selectedItems: selectedItemsMultiDialog,
                                  hint: "Employees to notify",
                                  searchHint: "Select employees to notify",
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItemsMultiDialog = value;
                                    });
                                  },
                                  closeButton: (selectedItems) {
                                    return (selectedItems.isNotEmpty
                                        ? "Save ${selectedItems.length == 1 ? '"' + notifier[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                        : "Save without selection");
                                  },
                                  isExpanded: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: commentController,
                                  minLines: 2,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Comment',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '\u{1F4C5} ' + SelectDates,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  onPressed: () async {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.focusedChild?.unfocus();
                                    }

                                    setState(() {
                                      AMselectedM = false;
                                      PMselectedM = false;
                                      AMselectedT = false;
                                      PMselectedT = false;
                                      AMselectedW = false;
                                      PMselectedW = false;
                                      AMselectedTH = false;
                                      PMselectedTH = false;
                                      AMselectedF = false;
                                      PMselectedF = false;
                                    });

                                    _balanceservice
                                        .getUserBalences(User_id, tokenLogin)
                                        .then((value) {
                                      setState(() {
                                        weekbalance =
                                            value["data"][0]["WFHweekBalance"];
                                        monthbalance =
                                            value["data"][0]["WFHmonthBalance"];
                                      });
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  NeumorphicColors.background,
                                              title: Text(''),
                                              content: Container(
                                                color:
                                                    NeumorphicColors.background,
                                                height: 300,
                                                width: 300,
                                                child: Column(
                                                  children: <Widget>[
                                                    getDateRangePicker(
                                                        _selectedIndex),
                                                    MaterialButton(
                                                      child: Text("OK"),
                                                      onPressed: () {
                                                        if (_selectedIndex ==
                                                            1) {
                                                          if (date2 != null &&
                                                              date1 != null &&
                                                              date2
                                                                      .difference(
                                                                          date1)
                                                                      .inDays <
                                                                  20) {
                                                            return SweetAlert.show(
                                                                context,
                                                                subtitle:
                                                                    "Please select a minimum period of 3 weeks",
                                                                style:
                                                                    SweetAlertStyle
                                                                        .error);
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ));
                                        });
                                  }),
                              (Dates.length != 0 && _selectedIndex == 0)
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          (Dates[0].isAfter(Now))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(Days[0]
                                                            .toString())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(Dates[0])
                                                            .toString())),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          (AMselectedM)
                                                              ? slotbutton(
                                                                  0,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  0,
                                                                  Colors
                                                                      .transparent,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                          (PMselectedM)
                                                              ? slotbutton(
                                                                  0,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  0,
                                                                  Colors
                                                                      .transparent,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          Days[0].toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(Dates[0])
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          slotbutton(
                                                              0,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                          slotbutton(
                                                              0,
                                                              Colors.grey,
                                                              "PM",
                                                              Colors.grey,
                                                              Colors.red),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          (Dates[1].isAfter(Now))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(Days[1]
                                                            .toString())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(Dates[1])
                                                            .toString())),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          (AMselectedT)
                                                              ? slotbutton(
                                                                  1,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  1,
                                                                  Colors
                                                                      .transparent,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                          (PMselectedT)
                                                              ? slotbutton(
                                                                  1,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  1,
                                                                  Colors
                                                                      .transparent,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          Days[1].toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(Dates[1])
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          slotbutton(
                                                              1,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                          slotbutton(
                                                              1,
                                                              Colors.grey,
                                                              "PM",
                                                              Colors.grey,
                                                              Colors.red),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          (Dates[2].isAfter(Now))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(Days[2]
                                                            .toString())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(Dates[2])
                                                            .toString())),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          (AMselectedW)
                                                              ? slotbutton(
                                                                  2,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  2,
                                                                  Colors
                                                                      .transparent,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                          (PMselectedW)
                                                              ? slotbutton(
                                                                  2,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  2,
                                                                  Colors
                                                                      .transparent,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          Days[2].toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(Dates[2])
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          slotbutton(
                                                              2,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                          slotbutton(
                                                              2,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          (Dates[3].isAfter(Now))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(Days[3]
                                                            .toString())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(Dates[3])
                                                            .toString())),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          (AMselectedTH)
                                                              ? slotbutton(
                                                                  3,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  3,
                                                                  Colors
                                                                      .transparent,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                          (PMselectedTH)
                                                              ? slotbutton(
                                                                  3,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  3,
                                                                  Colors
                                                                      .transparent,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          Days[3].toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(Dates[3])
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          slotbutton(
                                                              3,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                          slotbutton(
                                                              3,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          (Dates[4].isAfter(Now))
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(Days[4]
                                                            .toString())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(Dates[4])
                                                            .toString())),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          (AMselectedF)
                                                              ? slotbutton(
                                                                  4,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  4,
                                                                  Colors
                                                                      .transparent,
                                                                  "AM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                          (PMselectedF)
                                                              ? slotbutton(
                                                                  4,
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.white)
                                                              : slotbutton(
                                                                  4,
                                                                  Colors
                                                                      .transparent,
                                                                  "PM",
                                                                  LightColors
                                                                      .kDarkBlue,
                                                                  Colors.black),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          Days[4].toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(Dates[4])
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          slotbutton(
                                                              4,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                          slotbutton(
                                                              4,
                                                              Colors.grey,
                                                              "AM",
                                                              Colors.grey,
                                                              Colors.red),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          (weekbalance[Jiffy(Dates[3]).week - 1]
                                                          ["count"] >=
                                                      WFHweekBalance ||
                                                  monthbalance[Dates[3].month -
                                                          1]["count"] >=
                                                      WFHmonthBalance)
                                              ? Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Balance for current week Vs Best practices policy: ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      !(weekbalance[Jiffy(Dates[
                                                                          4])
                                                                      .week -
                                                                  1]["count"] >=
                                                              WFHweekBalance)
                                                          ? Text(
                                                              weekbalance[Jiffy(Dates[0]).week -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  "/" +
                                                                  WFHweekBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )
                                                          : Text(
                                                              weekbalance[Jiffy(Dates[0]).week -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  "/" +
                                                                  WFHweekBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                    ],
                                                  ))
                                              : Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Balance for current week Vs Best practices policy: ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      !(weekbalance[Jiffy(Dates[
                                                                          4])
                                                                      .week -
                                                                  1]["count"] >=
                                                              WFHweekBalance)
                                                          ? Text(
                                                              weekbalance[Jiffy(Dates[0]).week -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  "/" +
                                                                  WFHweekBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )
                                                          : Text(
                                                              weekbalance[Jiffy(Dates[0]).week -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  " / " +
                                                                  WFHweekBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                    ],
                                                  )),
                                          (Dates[0].month == Dates[4].month)
                                              ? Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          "Balance for current month Vs Best practices: ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      !(monthbalance[Dates[0]
                                                                      .month -
                                                                  1]["count"] >=
                                                              WFHmonthBalance)
                                                          ? Text(
                                                              monthbalance[Dates[0].month -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  "/" +
                                                                  WFHmonthBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          : Text(
                                                              monthbalance[Dates[0].month -
                                                                              1]
                                                                          [
                                                                          "count"]
                                                                      .toString() +
                                                                  "/" +
                                                                  WFHmonthBalance
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                    ],
                                                  ))
                                              : Column(
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                "Balance for " +
                                                                    DateFormat(
                                                                            "MMM")
                                                                        .format(
                                                                            DateTime.parse(Dates[0].toString()))
                                                                        .toString() +
                                                                    " month Vs Best practices:",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            !(monthbalance[Dates[0]
                                                                            .month -
                                                                        1]["count"] >=
                                                                    WFHmonthBalance)
                                                                ? Text(
                                                                    monthbalance[Dates[0].month - 1]["count"]
                                                                            .toString() +
                                                                        "/" +
                                                                        WFHmonthBalance
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                : Text(
                                                                    monthbalance[Dates[0].month - 1]["count"]
                                                                            .toString() +
                                                                        "/" +
                                                                        WFHmonthBalance
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                          ],
                                                        )),
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                "Balance for " +
                                                                    DateFormat(
                                                                            "MMM")
                                                                        .format(
                                                                            DateTime.parse(Dates[4].toString()))
                                                                        .toString() +
                                                                    " month Vs Best practices:",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            !(monthbalance[Dates[4]
                                                                            .month -
                                                                        1]["count"] >=
                                                                    WFHmonthBalance)
                                                                ? Text(
                                                                    monthbalance[Dates[4].month - 1]["count"]
                                                                            .toString() +
                                                                        "/" +
                                                                        WFHmonthBalance
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                : Text(
                                                                    monthbalance[Dates[4].month - 1]["count"]
                                                                            .toString() +
                                                                        "/" +
                                                                        WFHmonthBalance
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: _height * 0.06),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    child: NeumorphicButton(
                                        onPressed: () async {
                                          if (selectedValue.toString() ==
                                              "null") {
                                            return SweetAlert.show(context,
                                                subtitle:
                                                    "Please select a manager",
                                                style: SweetAlertStyle.error);
                                          } else if (Dates.length == 0 &&
                                              _selectedIndex == 0) {
                                            return SweetAlert.show(context,
                                                subtitle:
                                                    "Please select date(s)",
                                                style: SweetAlertStyle.error);
                                          } else {
                                            Requests request = new Requests();
                                            request.idSender = User_id;
                                            request.idReciever =
                                                selectedValue["_id"].toString();
                                            request.commentUser =
                                                commentController.text;

                                            selectedItemsMultiDialog
                                                .forEach((element) {
                                              request.UserNotif.add(
                                                  (notifier[element].value));
                                            });
                                            if (User["role"].toString() ==
                                                    "manager" ||
                                                User["role"].toString() ==
                                                    "manager_validator") {
                                              request.isManager = true;
                                            } else {
                                              request.isManager = false;
                                            }

                                            if (_selectedIndex == 0) {
                                              request.month = Dates[0].month;
                                              request.week = weekbalance[
                                                      Jiffy(Dates[0]).week - 1]
                                                  ["nb"];
                                              request.countWeek = weekbalance[
                                                      Jiffy(Dates[0]).week -
                                                          1]["count"]
                                                  .toDouble();
                                              request.countMonth = monthbalance[
                                                          Dates[0].month - 1]
                                                      ["count"]
                                                  .toDouble();
                                              if (Dates[0].month !=
                                                  Dates[4].month) {
                                                request.monthTwo =
                                                    Dates[4].month;
                                                request.countMonthTwo =
                                                    monthbalance[
                                                            Dates[4].month - 1]
                                                        ["count"];
                                              }
                                              if (AMselectedM == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[0]),
                                                  "slot": "AM"
                                                });
                                              }
                                              if (PMselectedM == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[0]),
                                                  "slot": "PM"
                                                });
                                              }
                                              if (AMselectedT == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[1]),
                                                  "slot": "AM"
                                                });
                                              }
                                              if (PMselectedT == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[1]),
                                                  "slot": "PM"
                                                });
                                              }
                                              if (AMselectedW == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[2]),
                                                  "slot": "AM"
                                                });
                                              }
                                              if (PMselectedW == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[2]),
                                                  "slot": "PM"
                                                });
                                              }
                                              if (AMselectedTH == true) {
                                                request.date.add({
                                                  "day":
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(Dates[3]),
                                                  "slot": "AM"
                                                });
                                              }
                                              if (PMselectedTH == true) {
                                                request.date.add({
                                                  "day": DateFormat('yyy-MM-dd')
                                                      .format(Dates[3]),
                                                  "slot": "PM"
                                                });
                                              }
                                              if (AMselectedF == true) {
                                                request.date.add({
                                                  "day": DateFormat('yyy-MM-dd')
                                                      .format(Dates[4]),
                                                  "slot": "AM"
                                                });
                                              }
                                              if (PMselectedF == true) {
                                                request.date.add({
                                                  "day": DateFormat('yyy-MM-dd')
                                                      .format(Dates[4]),
                                                  "slot": "PM"
                                                });
                                              }
                                              request.name = "WFH";

                                              if (request.date.length == 0) {
                                                return SweetAlert.show(context,
                                                    subtitle:
                                                        "Please select date(s)",
                                                    style:
                                                        SweetAlertStyle.error);
                                              } else {
                                                _requestservice
                                                    .addRequest(request,
                                                        this.tokenLogin)
                                                    .then((value) async {
                                                  SweetAlert.show(context,
                                                      subtitle: "Loading ...",
                                                      style: SweetAlertStyle
                                                          .loading);
                                                  await Future.delayed(
                                                      new Duration(seconds: 1),
                                                      () async {
                                                    if (value["status"]
                                                            .toString() ==
                                                        "200") {
                                                      await SweetAlert.show(
                                                          context,
                                                          subtitle: " Done !",
                                                          style: SweetAlertStyle
                                                              .success,
                                                          onPress:
                                                              (bool isConfirm) {
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
                                                          return false;
                                                        }
                                                      });
                                                    } else if (value["status"]
                                                            .toString() ==
                                                        "201") {
                                                      await SweetAlert.show(
                                                          context,
                                                          subtitle:
                                                              value["message"],
                                                          style: SweetAlertStyle
                                                              .error);
                                                    } else {
                                                      await SweetAlert.show(
                                                          context,
                                                          subtitle:
                                                              "Ooops! Something Went Wrong!",
                                                          style: SweetAlertStyle
                                                              .error);
                                                    }
                                                  });
                                                });
                                              }
                                            } else {
                                              request.name = "REMOTE_WORKING";

                                              if (date1 == null ||
                                                  date2 == null ||
                                                  date1.isBefore(
                                                      DateTime.now())) {
                                                return SweetAlert.show(context,
                                                    subtitle:
                                                        "Please select valid date(s)",
                                                    style:
                                                        SweetAlertStyle.error);
                                              } else if (date2
                                                      .difference(date1)
                                                      .inDays <
                                                  21) {
                                                return SweetAlert.show(context,
                                                    subtitle:
                                                        "Please select a minimum period of 3 weeks",
                                                    style:
                                                        SweetAlertStyle.error);
                                              } else {
                                                request.start =
                                                    DateFormat('yyy-MM-dd')
                                                        .format(date1);
                                                request.end =
                                                    DateFormat('yyy-MM-dd')
                                                        .format(date2);
                                                for (var i = 0;
                                                    i <=
                                                        date2
                                                            .difference(date1)
                                                            .inDays;
                                                    i++) {
                                                  request.date.add(
                                                    DateFormat('yyy-MM-dd')
                                                        .format(date1.add(
                                                            Duration(days: i))),
                                                  );
                                                }
                                                SweetAlert.show(context,
                                                    subtitle: "Loading ...",
                                                    style: SweetAlertStyle
                                                        .loading);
                                                _requestservice
                                                    .addRequest(request,
                                                        this.tokenLogin)
                                                    .then((value) async {
                                                  if (value["status"]
                                                          .toString() ==
                                                      "200") {
                                                    await SweetAlert.show(
                                                        context,
                                                        subtitle: " Done !",
                                                        style: SweetAlertStyle
                                                            .success,
                                                        onPress:
                                                            (bool isConfirm) {
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
                                                        return false;
                                                      }
                                                    });
                                                  } else if (value["status"]
                                                          .toString() ==
                                                      "201") {
                                                    await SweetAlert.show(
                                                        context,
                                                        subtitle:
                                                            value["message"],
                                                        style: SweetAlertStyle
                                                            .error);
                                                  } else {
                                                    await SweetAlert.show(
                                                        context,
                                                        subtitle:
                                                            "Ooops! Something Went Wrong!",
                                                        style: SweetAlertStyle
                                                            .error);
                                                  }
                                                });
                                              }
                                            }
                                          }
                                        },
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          color: LightColors.kgreenw,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(8)),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Center(
                                          child: AutoSizeText(
                                            'Submit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Container(
                                    height: 50,
                                    child: NeumorphicButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          color: NeumorphicColors.background,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(8)),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Center(
                                          child: AutoSizeText(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                            ],
                          ),
                        );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget slotbutton(
    int day,
    Color selected,
    String slottext,
    Color bordercolor,
    Color textColors,
  ) {
    return InkWell(
        splashColor: Colors.green,
        highlightColor: Colors.blue,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: selected,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: bordercolor)),
          child: Text(
            slottext,
            style: TextStyle(color: textColors),
          ),
        ),
        onTap: () {
          if (textColors == Colors.black) {
            monthbalance[Dates[day].month - 1]["count"] =
                monthbalance[Dates[day].month - 1]["count"] + 0.5;
            weekbalance[Jiffy(Dates[day]).week - 1]["count"] =
                weekbalance[Jiffy(Dates[0]).week - 1]["count"] + 0.5;
          }

          if (textColors == Colors.white) {
            monthbalance[Dates[day].month - 1]["count"] =
                monthbalance[Dates[day].month - 1]["count"] - 0.5;
            weekbalance[Jiffy(Dates[day]).week - 1]["count"] =
                weekbalance[Jiffy(Dates[day]).week - 1]["count"] - 0.5;
          }
          if (textColors == Colors.black || textColors == Colors.white) {
            if (day == 0) {
              if (slottext == "AM") {
                setState(() {
                  AMselectedM = !AMselectedM;
                });
              }
              if (slottext == "PM") {
                setState(() {
                  PMselectedM = !PMselectedM;
                });
              }
            }
            if (day == 1) {
              if (slottext == "AM") {
                setState(() {
                  AMselectedT = !AMselectedT;
                });
              }
              if (slottext == "PM") {
                setState(() {
                  PMselectedT = !PMselectedT;
                });
              }
            }
            if (day == 2) {
              if (slottext == "AM") {
                setState(() {
                  AMselectedW = !AMselectedW;
                });
              }
              if (slottext == "PM") {
                setState(() {
                  PMselectedW = !PMselectedW;
                });
              }
            }
            if (day == 3) {
              if (slottext == "AM") {
                setState(() {
                  AMselectedTH = !AMselectedTH;
                });
              }
              if (slottext == "PM") {
                setState(() {
                  PMselectedTH = !PMselectedTH;
                });
              }
            }
            if (day == 4) {
              if (slottext == "AM") {
                setState(() {
                  AMselectedF = !AMselectedF;
                });
              }
              if (slottext == "PM") {
                setState(() {
                  PMselectedF = !PMselectedF;
                });
              }
            }
          }
        });
  }

  Widget getDateRangePicker(selectedindex) {
    return Container(
      height: 250,
      child: (selectedindex == 0)
          ? SfDateRangePicker(
              controller: _controller,
              backgroundColor: NeumorphicColors.background,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: selectionChanged,
              monthViewSettings:
                  DateRangePickerMonthViewSettings(enableSwipeSelection: true),
            )
          : (selectedindex == 1)
              ? SfDateRangePicker(
                  controller: _controllerRange,
                  backgroundColor: NeumorphicColors.background,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: selectionChangedrange,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      enableSwipeSelection: true),
                )
              : Container(),
    );
  }

  void selectionChangedrange(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange ranges = args.value;
    Dates = [];

    setState(() {
      date1 = ranges.startDate;
      date2 = ranges.endDate;
    });
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
      Dates.add(dat1.add(Duration(days: 1)));
      Dates.add(dat1.add(Duration(days: 2)));
      Dates.add(dat1.add(Duration(days: 3)));
      Dates.add(dat1.add(Duration(days: 4)));
      Dates.add(dat1.add(Duration(days: 5)));
    });
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
