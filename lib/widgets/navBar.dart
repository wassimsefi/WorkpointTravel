import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Home/Cong%C3%A9/Request.dart';
import 'package:vato/screens/Home/HomeScreen.dart';
import 'package:vato/screens/Home/Mission/add_missions2.dart';
import 'package:vato/screens/Home/Mission/tab_mission.dart';
import 'package:vato/screens/Home/Notification/Notification.dart' as notif;
import 'package:vato/screens/Home/Reservation/Floor/floorplan_screen.dart';
import 'package:vato/screens/Home/Reservation/search_screen.dart';
import 'package:vato/screens/Home/WFH/request_w_f_h.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/travel/Home/list_missions.dart';
import '../screens/Home/Mission/detail_mission.dart';
import 'package:vato/screens/User/usertab.dart';
import 'package:vato/screens/search/FirstPage/list_resources.dart';
import 'package:vato/screens/search/My%20Requests/myrequests.dart';
import 'package:vato/screens/search/MyTeam/myteam.dart';
import 'package:vato/screens/search/teamRequests/team_requests.dart';
import 'package:vato/utils/isnotified.dart' as globals;

class navigationScreen extends StatefulWidget {
  int indexpage;

  DateTime selectedDate;
  Map<dynamic, List<dynamic>> Floors;
  List<dynamic> keys;
  String search;
  String home;
  List<dynamic> Zones;
  int indexfloor;
  String floor_type;

  navigationScreen(this.indexpage, this.Floors, this.keys, this.indexfloor,
      this.search, this.selectedDate, this.home,
      {Key key, this.floor_type})
      : super(key: key);

  @override
  _navigationScreenState createState() => _navigationScreenState();
}

class _navigationScreenState extends State<navigationScreen> {
  GlobalKey _bottomNavigationKey2 = GlobalKey();

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;

  DateTime startDate = DateTime.now();

  Future<SharedPreferences> _prefs;
  String tokenLogin;
  String idUser;
  String role;
  final _storage = const FlutterSecureStorage();
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
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        //  Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));

        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
        this.role = prefs.get("role").toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      // backgroundColor: Colors.orange[200],
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey2,
        index: widget.indexpage,
        color: LightColors.kDarkBlue,
        backgroundColor: NeumorphicColors.background,
        buttonBackgroundColor: LightColors.kDarkBlue,
        height: 50,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        items: [
          Icon(Icons.home_outlined,
              size: 20, color: NeumorphicColors.background),

          Icon(Icons.menu_rounded,
              size: 20, color: NeumorphicColors.background),
          //  Icon(Icons.qr_code_scanner_outlined,
          //   size: 20, color: NeumorphicColors.background),
          (globals.isnotified == true)
              ? Badge(
                  badgeContent: Text(
                    globals.countnotified.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  child: Icon(Icons.notification_important_outlined,
                      size: 20, color: NeumorphicColors.background),
                )
              : Icon(Icons.notification_important_outlined,
                  size: 20, color: NeumorphicColors.background),
          Icon(Icons.account_box_outlined,
              size: 20, color: NeumorphicColors.background),
        ],
        onTap: (index) {
          Logout();
          if (index == 2) {
            setState(() {
              globals.isnotified = false;
              globals.countnotified = 0;
            });
          }
          setState(() {
            widget.indexpage = index;
            widget.home = "";
            widget.search = "";
          });

          debugPrint("je suis dans la page  $index");
        },
      ),
      body: navigationbottombar(
          widget.indexpage,
          widget.Floors,
          widget.indexfloor,
          widget.keys,
          widget.search,
          widget.selectedDate,
          widget.home,
          widget.floor_type),
    );
  }

  navigationbottombar(
    int page,
    Map<dynamic, List<dynamic>> Floors,
    int floor,
    List<dynamic> keys,
    search,
    selectedDate,
    home,
    floor_type,
  ) {
    if (page == 0) {
      if (home == "home") {
        return HomeScreen(selectedDate);
      }
      if (home == "homework") {
        return RequestWFH();
      } else if (home == "leave") {
        return CongeRequest();
      } else if (home == "mission") {
        return ListMissions();
      } else if (home == "addmission") {
        return AddMissions();
      }

      if (home == "Dmission") {
        return DetailMission();
      }
      if (home == "map") {
        return FloorPlanScreen(Floors, floor, keys, selectedDate, floor_type);
      }
      if (home == "site") {
        return SearchScreen(0, selectedDate);
      }
      if (home == "list") {
        return SearchScreen(1, selectedDate);
      } else {
        return HomeScreen(selectedDate);
      }
    }
    if (page == 1) {
      if (search == "team") {
        return Myteam();
      }
      if (search == "Myrequests") {
        return Myrequests(1);
      }
      if (search == "Teamrequests") {
        return TeamRequests();
      } else {
        return ListResources();
      }
    }
    if (page == 2) {
      setState(() {
        globals.countnotified = 0;
        globals.isnotified = false;
      });
      return notif.Notification();
    }
    if (page == 3) {
      return Usertab();
    }
  }
}
