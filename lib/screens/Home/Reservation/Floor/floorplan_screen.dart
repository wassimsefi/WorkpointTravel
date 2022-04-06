import 'package:auto_size_text/auto_size_text.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/ReservationService.dart';
import 'package:vato/services/ZoneService.dart';
import 'package:vato/widgets/navBar.dart';

class FloorPlanScreen extends StatefulWidget {
  DateTime selectedDate;
  List<dynamic> Zones;
  Map<dynamic, List<dynamic>> Floors;
  List<dynamic> keys;
  int floorindex;
  String floor_type;

  FloorPlanScreen(
    this.Floors,
    this.floorindex,
    this.keys,
    this.selectedDate,
    this.floor_type, {
    Key key,
  }) : super(key: key);

  @override
  _FloorPlanScreenState createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  String selectedDatemap;
  bool selected;
  String iduser;
  List<dynamic> listDesks = List<dynamic>();
  List<dynamic> Zones;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  List<DateTime> markedDates = [DateTime.now().add(Duration(days: 0))];
  ZoneService Zs = new ZoneService();
  int NBDesks;
  final _storage = const FlutterSecureStorage();

  List<dynamic> Desks = [];
  bool StatutPM;
  bool StatutAM;
  bool ispopup = true;
  String NameFloor;
  String spot;
  var resource;
  var ImageFloor;

  dynamic getAvailibility(dynamic data) {
    Desks = [];
    int x = 0;
    data.forEach((element) {
      Desks.add(element[0]["Desks"]);
      x = x + 1;
    });
    // print(data.toString());
    return Desks;
  }

  Future <dynamic> getAvailibilitymap;

  onSelect(data) async {
    setState(() {
      widget.selectedDate = data;
      var newFormat = DateFormat("yyyy-MM-dd");
      selectedDatemap = newFormat.format(data);
      getAvailibilitymap = av();
    });
  }

  checkSlot(iduser, date, slot, spot) async {
    ispopup = false;
    if (widget.floor_type == "Parking") {
      this.NameFloor = "parking";
    }
    else {
      this.NameFloor = "Desk";
    }
    if ((resource == "Parking") && (spot != "null")) {
      StatutAM = false;
      StatutPM = false;
    } else {
      var newFormat = DateFormat("yyyy-MM-dd");
      await OperationService().checkAvailibility(
          iduser.toString(), date.toString(), "PM", this.NameFloor,
          this.tokenLogin).then((value) async {
        if (value["data"] == 201) {
          StatutPM = false;
        }
        else {
          StatutPM = true;
        }
      });

      await OperationService().checkAvailibility(
          iduser.toString(), date.toString(), "AM", this.NameFloor,
          this.tokenLogin).then((value) async {
        if (value["data"] == 201) {
          StatutAM = false;
        }
        else {
          if (date == newFormat.format(DateTime.now())) {
            if (DateFormat('a').format(DateTime.now()) == "AM") {
              StatutAM = true;
            }
            else if ((DateFormat('a').format(DateTime.now()) == "PM") &&
                slot == "AM") {
              StatutAM = false;
            }
            else {
              StatutAM = true;
            }
          }
          else {
            StatutAM = true;
          }
        }
      });
    }
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

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
      ),
      Container(
        width: 7,
        height: 7,
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
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

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

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

  void NBROfDateEnd() {
    if (widget.keys[widget.floorindex].toString() == "Parking -1" ||
        widget.keys[widget.floorindex].toString() == "Parking -2") {
      endDate = DateTime.now();
      widget.selectedDate = DateTime.now();
    } else {
      if (DateTime
          .now()
          .weekday
          .toString() == "4") {
        endDate = DateTime.now().add(Duration(days: 9));
      } else if ((DateTime
          .now()
          .weekday
          .toString() == "5")) {
        endDate = DateTime.now().add(Duration(days: 8));
      } else if ((DateTime
          .now()
          .weekday
          .toString() == "6")) {
        endDate = DateTime.now().add(Duration(days: 7));
      } else if ((DateTime
          .now()
          .weekday
          .toString() == "7")) {
        endDate = DateTime.now().add(Duration(days: 6));
      } else if ((DateTime
          .now()
          .weekday
          .toString() == "3")) {
        endDate = DateTime.now().add(Duration(days: 4));
      } else {
        endDate = DateTime.now().add(Duration(days: 5));
      }
    }
  }

  Future<SharedPreferences> _prefs;
  String user;
  int NBRZones = 0;
  String tokenLogin;
  final GlobalKey<ScaffoldState> containerkey = GlobalKey<ScaffoldState>();

  Future<dynamic> av() async {
    ImageFloor =
    await _storage.read(key: widget.keys[widget.floorindex].toString());
    Data = {
      "idZone": widget.Floors[widget.keys[widget.floorindex].toString()],
      "selectedDate": selectedDatemap,
    };
    await _reservationService.getZonesAV(this.Data, this.tokenLogin).then((
        value) async {
      return getAvailibility(value["data"]);
    });
    return Desks;
  }
  String idUser;

  @override
  void initState() {
    Desks = [];

    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.tokenLogin = prefs.get("token").toString();
        this.idUser = prefs.get("_id").toString();
        this.spot = prefs.get("spot").toString();
      });
      getAvailibilitymap = av();
    });
    startDate = DateTime.now();
    NBROfDateEnd();

    var newFormat = DateFormat("yyyy-MM-dd");
    selectedDatemap = newFormat.format(widget.selectedDate);
    // getAvailibilitymap=av();

  }

  var Data;
  ReservationService _reservationService = new ReservationService();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    Size size = MediaQuery
        .of(context)
        .size;

    //  var img=widget.keys[widget.floorindex].toString();

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: LightColors.kDarkBlue,
        child: Column(children: [
          SizedBox(height: height * 0.03),
          CalendarStrip(
            containerHeight: 120,
            startDate: startDate,
            endDate: endDate,
            selectedDate: widget.selectedDate,
            onDateSelected: onSelect,
            dateTileBuilder: dateTileBuilder,
            iconColor: Colors.white,
            monthNameWidget: _monthNameWidget,
            markedDates: markedDates,
            containerDecoration: BoxDecoration(color: LightColors.kDarkBlue),
          ),
          Container(
            height: height * 0.08,
            color: NeumorphicColors.background,
            child: Neumorphic(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                style: NeumorphicStyle(
                  depth: 20,
                ),
                child: Container(
                  height: height / 16,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: width / 5,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 25,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/OC.png',
                                ),
                              ),
                              AutoSizeText("Occupied",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle())
                            ]),
                      ),
                      Container(
                        width: width / 5,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 25,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/AV.png',
                                ),
                              ),
                              AutoSizeText("Available",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle())
                            ]),
                      ),
                      Container(
                        width: width / 5.2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 25,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/BK.png',
                                ),
                              ),
                              AutoSizeText("Blocked",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle())
                            ]),
                      ),
                      Container(
                        width: width / 5.2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 25,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/BOOK.png',
                                ),
                              ),
                              AutoSizeText("Booked",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle())
                            ]),
                      ),
                      Container(
                        width: width / 5.1 / 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 30,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/AM.png',
                                ),
                              ),
                              AutoSizeText("AM",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle())
                            ]),
                      ),
                      Container(
                        width: width / 5 / 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: height / 50,
                                width: width / 30,
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/PM.png',
                                ),
                              ),
                              AutoSizeText("PM",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 2,
                                  style: TextStyle()),
                              SizedBox(
                                width: width / 150,
                              )
                            ]),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
              child: Container(
                  key: containerkey,
                  color: NeumorphicColors.background,
                  child: Center(
                      child: FutureBuilder(
                          future: getAvailibilitymap,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case (ConnectionState.waiting):
                                return Center(child: CircularProgressIndicator());
                              case (ConnectionState.none):
                                return Center(child: CircularProgressIndicator());

                              case (ConnectionState.done):
                                return (Desks.length != 0)
                                    ? InteractiveViewer(
                                  panEnabled: true,
                                  boundaryMargin: EdgeInsets.all(1),
                                  minScale: 0.5,
                                  maxScale: 10,
                                  child: Stack(
                                      children: [
                                        Center(
                                          child:
                                          Container(
                                              width: 200,
                                              child: SvgPicture.string(
                                                  ImageFloor)),
                                        ),
                                        Stack(
                                            children: List.generate(
                                                snapshot.data.length,
                                                    (idx) {
                                                   print ( "dddddddd"+snapshot.data[idx].toString());
                                                  return Stack(
                                                      children: List.generate(
                                                          snapshot.data.length,
                                                              (idx) {
                                                            return Stack(
                                                                children: List
                                                                    .generate(
                                                                    snapshot
                                                                        .data[idx]
                                                                        .length, (
                                                                    d) {
                                                                  return
                                                                    Center(
                                                                      child: Container(
                                                                        child: (snapshot
                                                                            .data[idx]
                                                                        [d][
                                                                        "positionX"] ==
                                                                            null)
                                                                            ? Center(
                                                                          child:
                                                                          Text(
                                                                              'ERROR'),
                                                                        )
                                                                            : Transform
                                                                            .translate(
                                                                          offset: Offset(
                                                                              (width /
                                                                                  2) +
                                                                                  (double
                                                                                      .parse(
                                                                                      snapshot
                                                                                          .data[idx][d]["positionX"])),
                                                                              -(double
                                                                                  .parse(
                                                                                  snapshot
                                                                                      .data[idx][d]["positionY"]))),
                                                                          child:
                                                                          GestureDetector(
                                                                            child: Stack(
                                                                              children: <
                                                                                  Widget>[
                                                                                Container(
                                                                                    child:
                                                                                    Row(
                                                                                      children: [
                                                                                        //  SizedBox(width: 48,),
                                                                                        (snapshot.data[idx][d]["statusAM"] == "AVAILABLE")?
                                                                                        SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                                  <path d='M4 4C4 6.20891 4 6.13303 4 8C1.79099 8 0 6.20891 0 4C0 1.79063 1.79099 0 4 0C4 1.6 4 1.79063 4 4Z' fill='#14E39A' fill-opacity='0.5'/>
                                                                                                  </svg>""")
                                                                                        :(snapshot.data[idx][d]["statusAM"] == "BLOCKED")?SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                                  <path d='M4 4C4 6.20891 4 6.13303 4 8C1.79099 8 0 6.20891 0 4C0 1.79063 1.79099 0 4 0C4 1.6 4 1.79063 4 4Z' fill='#A9A9BA' fill-opacity='0.5'/>
                                                                                                  </svg>""")
                                                                                            :(snapshot.data[idx][d]["statusAM"] == "BOOKED")?SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                                  <path d='M4 4C4 6.20891 4 6.13303 4 8C1.79099 8 0 6.20891 0 4C0 1.79063 1.79099 0 4 0C4 1.6 4 1.79063 4 4Z' fill='#FF861C' fill-opacity='0.5'/>
                                                                                                  </svg>""")
                                                                                            :SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                                  <path d='M4 4C4 6.20891 4 6.13303 4 8C1.79099 8 0 6.20891 0 4C0 1.79063 1.79099 0 4 0C4 1.6 4 1.79063 4 4Z' fill='#FE3993' fill-opacity='0.5'/>
                                                                                                  </svg>"""),
                                                                                        SizedBox(
                                                                                          width: 1,),

                                                                                        (snapshot.data[idx][d]["statusPM"] == "AVAILABLE")?
                                                                                        SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                            <path d='M4 4C4 6.20891 2.20901 8 0 8C0 8 0 6.20891 0 4C0 1.79063 0 1.86651 0 0C2.20901 0 4 1.79063 4 4Z' fill='#14E39A' fill-opacity='0.5'/>
                                                                                            </svg>"""):
                                                                                        (snapshot.data[idx][d]["statusPM"] == "BLOCKED")?
                                                                                        SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                            <path d='M4 4C4 6.20891 2.20901 8 0 8C0 8 0 6.20891 0 4C0 1.79063 0 1.86651 0 0C2.20901 0 4 1.79063 4 4Z' fill='#A9A9BA' fill-opacity='0.5'/>
                                                                                            </svg>"""):
                                                                                        (snapshot.data[idx][d]["statusPM"] == "BOOKED")?
                                                                                        SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                            <path d='M4 4C4 6.20891 2.20901 8 0 8C0 8 0 6.20891 0 4C0 1.79063 0 1.86651 0 0C2.20901 0 4 1.79063 4 4Z' fill='#FF861C' fill-opacity='0.5'/>
                                                                                            </svg>"""):

                                                                                        SvgPicture
                                                                                            .string(
                                                                                            """"<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
                                                                                            <path d='M4 4C4 6.20891 2.20901 8 0 8C0 8 0 6.20891 0 4C0 1.79063 0 1.86651 0 0C2.20901 0 4 1.79063 4 4Z' fill='#FE3993' fill-opacity='0.5'/>
                                                                                            </svg>"""),
                                                                                        // SizedBox(width: 1,),

                                                                                        /*            // ignore: unrelated_type_equality_checks
                                                                                        snapshot.data[idx][d]["statusAM"] == "AVAILABLE"
                                                                                            ? Container(
                                                                                          width: 8,
                                                                                          height: 8,
                                                                                          child: SvgPicture.string(""""<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
<path d='M4 4C4 6.20891 4 6.13303 4 8C1.79099 8 0 6.20891 0 4C0 1.79063 1.79099 0 4 0C4 1.6 4 1.79063 4 4Z' fill='#22e022' fill-opacity='0.5'/>
</svg>
"""),
                                                                                        )
                                                                                            : snapshot.data[idx][d]["statusAM"] == "BLOCKED"
                                                                                            ? Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/AMB.png'), fit: BoxFit.fill),
                                                                                        )
                                                                                            : snapshot.data[idx][d]["statusAM"] == "BOOKED"
                                                                                            ? Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/AMBO.png'), fit: BoxFit.fill),
                                                                                        )
                                                                                            : Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/AMN.png'), fit: BoxFit.fill),
                                                                                        ),
                                                                                        SizedBox(width: 0,),

                                                                                        snapshot.data[idx][d]["statusPM"] == "AVAILABLE"
                                                                                            ? Container(
                                                                                          width: 8,
                                                                                          height: 8,
                                                                                          child: SvgPicture.string(""""<svg width='4' height='8' viewBox='0 0 4 8' fill='none' xmlns='http://www.w3.org/2000/svg'>
<path d='M4 4C4 6.20891 2.20901 8 0 8C0 8 0 6.20891 0 4C0 1.79063 0 1.86651 0 0C2.20901 0 4 1.79063 4 4Z' fill='#22e022' fill-opacity='0.5'/>
</svg>
"""),
                                                                                        )
                                                                                            : snapshot.data[idx][d]["statusPM"] == "BLOCKED"
                                                                                            ? Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/PMB.png'), fit: BoxFit.fill),
                                                                                        )
                                                                                            : snapshot.data[idx][d]["statusPM"] == "BOOKED"
                                                                                            ? Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/PMBO.png'), fit: BoxFit.fill),
                                                                                        )
                                                                                            : Container(
                                                                                          width: size.width * 0.0182,
                                                                                          height: (size.height - 170) * 0.024,
                                                                                          child: Image(image: AssetImage('assets/images/PMN.png'), fit: BoxFit.fill),
                                                                                        ),*/
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              if (ispopup ==
                                                                                  true) {
                                                                                await checkSlot(
                                                                                    this
                                                                                        .idUser,
                                                                                    selectedDatemap,
                                                                                    "AM",
                                                                                    spot); // TODO: implement initState

                                                                                if (snapshot
                                                                                    .data[idx][d]
                                                                                [
                                                                                "statusPM"] !=
                                                                                    "BLOCKED") {
                                                                                  return _openPopup(
                                                                                      context,
                                                                                      selectedDatemap,
                                                                                      snapshot
                                                                                          .data[idx]
                                                                                      [
                                                                                      d],
                                                                                      this
                                                                                          .idUser
                                                                                          .toString(),
                                                                                      widget
                                                                                          .selectedDate);
                                                                                } else {
                                                                                  //   print("desk bloked");
                                                                                }
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),

                                                                      ),
                                                                    );
                                                                }));
                                                          }));
                                                })),
                                      ]),
                                )
                                    : InteractiveViewer(
                                    panEnabled: true,
                                    boundaryMargin: EdgeInsets.all(1),
                                    minScale: 0.5,
                                    maxScale: 10,
                                    child:Stack(
                                        children: [
                                    Center(
                                    child:
                                    Container(
                                    width: 200,
                                        child: SvgPicture.string(
                                            ImageFloor)),
                                ),]));
                            }
                            return InteractiveViewer(
                                panEnabled: true,
                                boundaryMargin: EdgeInsets.all(1),
                                minScale: 0.5,
                                maxScale: 10,
                                child:Stack(
                                    children: [
                                      Center(
                                        child:
                                        Container(
                                            width: 200,
                                            child: SvgPicture.string(
                                                ImageFloor)),
                                      ),]));
                          })))),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.arrow_back_ios,
          color: LightColors.kDarkBlue,
        ),
        label: Text(
          'Back',
          style: TextStyle(color: LightColors.kDarkBlue, fontSize: 13),
        ),
        onPressed: () {
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
                          DateTime.parse(selectedDatemap),
                          "site")));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  _openPopup(context1, selectedDate, Desks, userid, DateSelected,) {
    List<Reservations>reservations = [];

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    String Function() title() {
      return () {
        if (((Desks["statusAM"] == "BOOKED") || StatutAM == false ||
            Desks["statusAM"] == "OCCUPIED") &&
            ((Desks["statusPM"] == "BOOKED") || StatutPM == false ||
                Desks["statusPM"] == "OCCUPIED")) {
          return 'Booking is not allowed !';
        }
        else {
          return "Choose your time slot";
        }
      };
    }
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
    void state(setState) {

      setState(() {
//
//
// print(selectedDate.toString());
        selectedDate = selectedDate;
      });
    }
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      //isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      titleStyle: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
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
    print(StatutPM.toString());
    var tit = title();
    print(tit().toString());
    Alert(
        context: context,
        title: Desks["deskname"],
        type: AlertType.info,
        style: alertStyle,
        desc: tit().toString(),

        content: StatefulBuilder(builder: (context2, StateSetter setState) {
          ispopup = true;
          return Column(
              children: <Widget>[
                SizedBox(height: height / 30,),
                /*        (((Desks["statusAM"]=="BOOKED")|| StatutAM == false) && ( (Desks["statusPM"]=="BOOKED") || StatutPM == false))?
                Center(child: Text("There is no free time slot !" ,style: TextStyle(color: Colors.white,fontSize: 15),))

                    :*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // [Monday] checkbox
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("AM", style: TextStyle(color: Colors.white),),
                        if ((Desks["statusAM"] == "OCCUPIED") ||
                            (Desks["statusAM"] == "BOOKED") ||
                            StatutAM == false)
                          IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            color: LightColors.kRed,
                            onPressed: () {},
                          ) else
                          (AMVAL == false) ?
                          IconButton(
                            icon: Icon(Icons.radio_button_unchecked),
                            color: Colors.white,
                            onPressed: () {
                              STATEAM(setState);
                            },
                          ) :
                          IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            color: Colors.green,
                            onPressed: () {
                              STATEAM(setState);
                            },
                          ),
                        (Desks["statusAM"] == "BOOKED" ||
                            Desks["statusAM"] == "OCCUPIED") ?
                        Text(Desks["userAM"]["firstname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,) :
                        Text("", style: TextStyle(color: Colors.white),),
                        (Desks["statusAM"] == "BOOKED" ||
                            (Desks["statusAM"] == "OCCUPIED")) ?
                        Text(Desks["userAM"]["lastname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,) :
                        Text("", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    // [Tuesday] checkbox
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("PM", style: TextStyle(color: Colors.white),),
                        (Desks["statusPM"] == "BOOKED") || StatutPM == false ||
                            (Desks["statusPM"] == "OCCUPIED") ?
                        IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          color: LightColors.kRed,
                          onPressed: () {},
                        ) : (PMVAL == false) ?
                        IconButton(
                          icon: Icon(Icons.radio_button_unchecked),
                          color: Colors.white,
                          onPressed: () {
                            STATEPM(setState);
                          },
                        ) :
                        IconButton(
                          icon: Icon(Icons.check_circle_outline),
                          //focusColor: Colors.green,
                          color: Colors.green,
                          onPressed: () {
                            STATEPM(setState);
                          },
                        ),
                        (Desks["statusPM"] == "BOOKED" ||
                            (Desks["statusPM"] == "OCCUPIED")) ?
                        Text(Desks["userPM"]["firstname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,) :
                        Text("", style: TextStyle(color: Colors.white),),
                        (Desks["statusPM"] == "BOOKED" ||
                            (Desks["statusPM"] == "OCCUPIED")) ?
                        Text(Desks["userPM"]["lastname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,) :
                        Text("", style: TextStyle(color: Colors.white),)

                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02,), // [Wednesday] checkbox
                (((Desks["statusAM"] == "BOOKED") || StatutAM == false ||
                    Desks["statusAM"] == "OCCUPIED") &&
                    ((Desks["statusPM"] == "BOOKED") || StatutPM == false ||
                        Desks["statusPM"] == "OCCUPIED")) ?
                Center(child: Text(
                  "", style: TextStyle(color: Colors.white, fontSize: 15),))

                    :
                DialogButton(
                  width: width / 3,
                  color: LightColors.kDarkBlue,
                  onPressed: () async {
                    Navigator.pop(context);
                    selectedDate.toString();
                    Reservations reservation = new Reservations();
                    reservation.desk = Desks["id"].toString();
                    reservation.user = userid.toString();
                    reservation.reservationdate = selectedDate.toString();

                    if (PMVAL == true && AMVAL == true) {
                      Reservations reservationAM = new Reservations();
                      reservationAM.desk = Desks["id"].toString();
                      reservationAM.user = userid.toString();
                      reservationAM.reservationdate = selectedDate.toString();
                      reservationAM.timeslot = "AM";

                      reservations.add(reservationAM);

                      Reservations reservationPM = new Reservations();
                      reservationPM.desk = Desks["id"].toString();
                      reservationPM.user = userid.toString();
                      reservationPM.reservationdate = selectedDate.toString();
                      reservationPM.timeslot = "PM";
                      reservations.add(reservationPM);
                      Future<dynamic> addresesvationPM = OperationService()
                          .AddNewReservations(
                          reservations, tokenLogin);
                      addresesvationPM.then((value) async {

                        if (value["data"].toString() == "200") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1, subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            SweetAlert.show(context1, subtitle: "Done!",
                                style: SweetAlertStyle.success);
                          });
                        }

                        else if (value["data"]["status"].toString() == "300") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      1,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1,
                              subtitle: "Ooops! Someone else just booked this desk!",
                              style: SweetAlertStyle.error);
                        }
                        else if (value["data"]["status"].toString() == "201") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));

                          SweetAlert.show(
                              context1, subtitle: value["data"]["message"],
                              style: SweetAlertStyle.error);
                        }
                        else if (value["status"].toString() == "400") {
                          SweetAlert.show(
                              context, subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }


                    if (PMVAL == true && AMVAL == false) {
                      reservation.timeslot = "PM";
                      Future<dynamic> addresesvationPM = OperationService()
                          .AddNewReservation(
                          reservation, this.tokenLogin);
                      addresesvationPM.then((value) async {
                        print(value["data"].toString());

                        if (value["data"].toString() == "200") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1, subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            SweetAlert.show(context1, subtitle: "Done!",
                                style: SweetAlertStyle.success);
                          });
                        }

                        else if (value["data"]["status"].toString() == "300") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      1,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1,
                              subtitle: "Ooops! Someone else just booked this desk!",
                              style: SweetAlertStyle.error);
                        }
                        else if (value["data"]["status"].toString() == "201") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));

                          SweetAlert.show(
                              context1, subtitle: value["data"]["message"],
                              style: SweetAlertStyle.error);
                        }
                        else if (value["status"].toString() == "400") {
                          SweetAlert.show(
                              context, subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }
                    if (PMVAL == false && AMVAL == true) {
                      reservation.timeslot = "AM";
                      Future<dynamic> addresesvationPM = OperationService()
                          .AddNewReservation(
                          reservation, this.tokenLogin);
                      addresesvationPM.then((value) async {
                        print(value.toString());
                        if (value["data"].toString() == "200") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1, subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            SweetAlert.show(context1, subtitle: "Done!",
                                style: SweetAlertStyle.success);
                          });
                        }

                        else if (value["data"]["status"].toString() == "300") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      1,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));
                          SweetAlert.show(context1,
                              subtitle: "Ooops! Someone else just booked this desk!",
                              style: SweetAlertStyle.error);
                        }
                        else if (value["data"]["status"].toString() == "201") {
                          Navigator.pushReplacement(
                              context1, MaterialPageRoute(
                              builder: (BuildContext context1) =>
                                  navigationScreen(
                                      0,
                                      widget.Floors,
                                      widget.keys,
                                      int.parse(widget.floorindex.toString()),
                                      null,
                                      DateSelected,
                                      "map")));

                          SweetAlert.show(
                              context1, subtitle: value["data"]["message"],
                              style: SweetAlertStyle.error);
                        }
                        else if (value["status"].toString() == "400") {
                          SweetAlert.show(
                              context, subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }
                    if (PMVAL == false && AMVAL == false) {
                      await Future.delayed(new Duration(seconds: 1), () async {
                        Navigator.pushReplacement(
                            context1, MaterialPageRoute(
                            builder: (BuildContext context1) =>
                                navigationScreen(
                                    0,
                                    widget.Floors,
                                    widget.keys,
                                    int.parse(widget.floorindex.toString()),
                                    null,
                                    DateSelected,
                                    "map")));
                      });
                      SweetAlert.show(
                          context1, subtitle: "please check your time slote !",
                          style: SweetAlertStyle.error);
                    }

                    // Navigator.pop(context);

                  },
                  child: Text(
                    "BOOK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]
          );
        },
        ),
        buttons: [
        ]


    ).show();
  }
}
