import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/topContainerScan.dart';

class Myteam extends StatefulWidget {
  const Myteam({Key key}) : super(key: key);

  @override
  _MyteamState createState() => _MyteamState();
}

class _MyteamState extends State<Myteam> {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources;

  List<CalendarResource> filtredResources = <CalendarResource>[];
  List<dynamic> Users;
  List<dynamic> operations = [];

  List<dynamic> filtred = [];
  List<dynamic> UsersId = [];

  int x = 0;

  String User_id, tokenLogin;
  Future<SharedPreferences> _prefs;
  UserService _userService = new UserService();
  OperationService _operationService = new OperationService();

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.tokenLogin = prefs.get("token").toString();
        User_id = prefs.get("_id");

      });
      _userService.getTeamManager(tokenLogin, User_id).then((value) {
        setState(() {
          filtred = Users = value["data"];
        });
      });
      _operationService
          .getOperationsByManager(User_id, tokenLogin)
          .then((value) {
        setState(() {
          operations = value["data"];
        });
      });
    });
    _getCalendarDataSource();
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
        children: <Widget>[
          TopContainer(),
          Expanded(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: NeumorphicColors.background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: NeumorphicColors.background,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                depth: 3,

                                //shape: NeumorphicShape.convex,
                                color: NeumorphicColors.background,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.all(
                                        Radius.elliptical(20, 20))),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  fillColor: NeumorphicColors.background,

                                  //   hoverColor: Colors.red,
                                  /*      border: new OutlineInputBorder(
                                 // borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                                 // borderSide: new BorderSide(color: Colors.red,width: 20 ,style: BorderStyle.none)
                              ),*/
                                  // isCollapsed: true,
                                  // focusColor: Colors.red,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: LightColors.kDarkBlue,
                                  ),
                                  // suffix:  const Icon(Icons.close, color: Colors.black,),

                                  //icon: Icon(Icons.search,color: LightColors.kDarkBlue,)
                                ),
                                onChanged: (value) {
                                  _filterResources(
                                    value,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  depth: 3,

                                  //shape: NeumorphicShape.convex,
                                  color: NeumorphicColors.background,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.all(
                                          Radius.elliptical(20, 20))),
                                ),
                                child: SfCalendar(
                                  backgroundColor: NeumorphicColors.background,
                                  view: CalendarView.timelineWorkWeek,
                                  dataSource: _getCalendarDataSource(),
                                  initialSelectedDate: DateTime.now(),
                                  resourceViewSettings: ResourceViewSettings(
                                      visibleResourceCount: 4,
                                      showAvatar: false,
                                      size: 100,
                                      displayNameTextStyle: TextStyle(
                                          fontSize: 12,
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w400)),
                                  headerDateFormat: "yMEd",
                                  timeSlotViewSettings: TimeSlotViewSettings(
                                      startHour: 8,
                                      endHour: 20,
                                      timeTextStyle: GoogleFonts.rubik(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                      timeFormat: "HH:mm",

                                      //allDayPanelColor: Colors.red,
                                      timeInterval: Duration(hours: 4)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  void _filterResources(value) {
    setState(() {
      filtred = Users.where((element) =>
          element["firstname"]
              .toLowerCase()
              .contains(value.toString().toLowerCase()) ||
          element["lastname"]
              .toLowerCase()
              .contains(value.toString().toLowerCase())).toList();
    });
  }

  DataSource _getCalendarDataSource() {
    var Date = new DateTime(2021, 12, 23, 8);
    var DateE = new DateTime(2021, 12, 23, 12);
    resources = <CalendarResource>[];
    appointments = <Appointment>[];
    filtred.forEach((element) async {
      UsersId.add(element['_id']);
      resources.add(CalendarResource(
        displayName: element["firstname"] + "  " + element["lastname"],
        id: element['_id'].toString(),
        color: Colors.blueGrey.shade100,
      ));
    });

    var StartTime;
    var EndTime;
    int x = 0;
    operations.forEach((element) async {

      if (element["OperationType"].toString() == "WFH") {
        if (UsersId.contains(element['user'].toString())) {
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
            subject: element["OperationType"],
            color: LightColors.Telework,
            startTimeZone: '',
            endTimeZone: '',
            resourceIds: <Object>[element['user'].toString()],

            //       location: element["request"]["status"],
            //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
            notes: element["_id"],
            //  location:   "0"
          ));
        }
      }
      else if (element["OperationType"].toString() == "RESERVATION") {

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
          resourceIds: <Object>[element['user'].toString()],

          color: LightColors.OnSite,
          startTimeZone: '',
          endTimeZone: '',
          // location: element["request"]["status"],
          //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
          notes: element["_id"],
          //  location:   "0"
        ));
      }
      else if (element["OperationType"].toString() == "REMOTE_WORKING") {
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
            subject: element["OperationType"],
            color: LightColors.remote,
            startTimeZone: '',
            endTimeZone: '',
            resourceIds: <Object>[element['user'].toString()],
            location: element["request"]["status"],
            //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
            notes: element["_id"],
            isAllDay: true
            //  location:   "0"

            ));
      }
    });
    return DataSource(appointments, resources);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}
